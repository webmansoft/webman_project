<?php
declare(strict_types=1);

namespace app\common\logic\tool;

use Exception;;
use support\Db;
use ReflectionClass;
use ReflectionException;
use app\common\base\BaseLogic;
use app\common\library\ArcoHelper;
use app\common\library\FileHelper;
use app\common\service\ZipService;
use app\common\library\StringHelper;
use app\common\service\TemplateService;
use app\common\exception\ApiException;

class ToolGenerateTablesLogic extends BaseLogic
{
    protected ?object $toolLogic = null;
    protected ?object $columnLogic = null;

    /**
     * 构造函数
     */
    public function __construct()
    {
        $this->toolLogic = new ToolLogic();
        $this->columnLogic = new ToolGenerateColumnsLogic();
    }

    /**
     * 删除表和字段信息
     * @param array $ids
     * @return void
     */
    public function destroy(array $ids): void
    {
        DB::beginTransaction();
        try {
            $this->delete();
            $this->columnLogic->delete(['table_id', 'id', $ids]);
            DB::commit();
        } catch (Exception $e) {
            DB::rollBack();
            throw new ApiException($e->getMessage());
        }
    }

    /**
     * 装载表信息
     * @param $names
     * @param $source
     * @return void
     */
    public function loadTable($names, $source): void
    {
        $config = config('thinkorm.connections')[$source];
        $prefix = $config['prefix'];
        foreach ($names as $item) {
            $class_name = StringHelper::camel(ArcoHelper::strReplaceOnce($prefix, '', $item['name']));
            $tableInfo = [
                'table_name' => $item['name'],
                'table_comment' => $item['comment'],
                'menu_name' => $item['comment'],
                'tpl_category' => 'single',
                'template' => 'plugin',
                'namespace' => '',
                'package_name' => '',
                'source' => $source,
                'business_name' => ArcoHelper::getBusiness($item['name']),
                'class_name' => $class_name,
                'generate_menus' => 'save,update,read,delete,recycle,recovery',
            ];
            $table_id = $this->insert($tableInfo);
            $columns = $this->toolLogic->getColumnList($item['name'], $source);
            foreach ($columns as &$column) {
                $column['table_id'] = $table_id;
            }

            $this->columnLogic->saveExtra($columns);
        }
    }

    /**
     * 同步表字段信息
     * @param int $id
     * @return void
     */
    public function sync(int $id): void
    {
        $model = $this->checkModel($id);
        $this->columnLogic->forceDelete(['table_id' => $id]);
        $columns = $this->toolLogic->getColumnList($model['table_name'], $model['source'] ?? '');
        foreach ($columns as &$column) {
            $column['table_id'] = $model['id'];
        }

        $this->columnLogic->saveExtra($columns);
    }

    /**
     * 代码预览
     * @param int $id
     * @return array
     */
    public function preview(int $id): array
    {
        $table = $this->checkModel($id)->toArray();
        if (!in_array($table['template'], ["plugin", "app"])) {
            throw new ApiException('模板必须为plugin或者app');
        }

        $columns = $this->columnLogic->where('table_id', $id)->select()->toArray();
        $pk = 'id';
        foreach ($columns as &$column) {
            if ($column['is_pk'] == 2) {
                $pk = $column['column_name'];
            }
            if ($column['column_name'] == 'delete_time') {
                unset($column['column_name']);
            }
        }

        $template_name = '/plugin/saiadmin/stub/saiadmin';
        $tpl = new TemplateService($template_name);
        $tpl->assign('pk', $pk);
        $tpl->assignArray($table);
        $tpl->assign('tables', [$table]);
        $tpl->assign('columns', $columns);
        if ($table['tpl_category'] == 'tree') {
            $tree_id = $table['options']['tree_id'] ?? '';
            $tree_parent_id = $table['options']['tree_parent_id'] ?? '';
            $tree_name = $table['options']['tree_name'] ?? '';
            $tpl->assign('tree_id', $tree_id);
            $tpl->assign('tree_parent_id', $tree_parent_id);
            $tpl->assign('tree_name', $tree_name);
        }

        if ($table['template'] == 'plugin') {
            $namespace_start = "plugin\\" . $table['namespace'] . "\\app\\";
        } else {
            $namespace_start = "app\\" . $table['namespace'] . "\\";
        }

        $namespace_end = $table['package_name'] != "" ? "\\" . $table['package_name'] : "";
        $url_path = $table['namespace'] . ($table['package_name'] != "" ? "/" . $table['package_name'] : "") . '/' . $table['business_name'];
        if ($table['component_type'] == 3) {
            $tpl->assign('tag_id', $table['options']['tag_id'] ?? mt_rand(10000, 99999));
            $tpl->assign('tag_name', $table['options']['tag_name'] ?? $table['menu_name']);
        }
        $tpl->assign('namespace_start', $namespace_start);
        $tpl->assign('namespace_end', $namespace_end);
        $tpl->assign('url_path', $url_path);

        $relations = [];
        if (isset($table['options']['relations'])) {
            if (count($table['options']['relations']) > 0) {
                $relations = $table['options']['relations'];
            }
        }
        $tpl->assign('relations', $relations);

        $fileArr = FileHelper::getDir($template_name);
        $data = [];
        foreach ($fileArr as $dir) {
            $files = FileHelper::getDir($template_name . DIRECTORY_SEPARATOR . $dir);
            foreach ($files as $file) {
                if ($dir === 'vue') {
                    if (pathinfo($file, PATHINFO_FILENAME) !== $table['tpl_category']) {
                        continue;
                    }
                }

                $template = $tpl->show(DIRECTORY_SEPARATOR . $dir . DIRECTORY_SEPARATOR . $file);
                $tab_name = pathinfo($file, PATHINFO_FILENAME) . '.' . $dir;
                $lang = $dir;
                if ($dir == 'js' || $dir == 'ts') {
                    $lang = 'javascript';
                }

                if ($dir == 'vue') {
                    $lang = 'html';
                    $tab_name = 'index.vue';
                }

                if ($dir == 'sql') {
                    $lang = 'mysql';
                }

                $data[] = [
                    'tab_name' => $tab_name,
                    'name' => pathinfo($file, PATHINFO_FILENAME),
                    'lang' => $lang,
                    'code' => $template
                ];
            }
        }

        return $data;
    }

    /**
     * 代码生成
     * @param array $table_ids
     * @return array
     * @throws ReflectionException
     */
    public function generate(array $table_ids): array
    {
        $zip = new ZipService();
        $tables = $this->findAll(['id', 'in', $table_ids]);
        foreach ($table_ids as $table_id) {
            $this->genUnit($table_id, $tables);
        }

        $filename = 'code.zip';
        $download = $zip->compress($filename);
        return compact('filename', 'download');
    }

    /**
     * 代码生成子任务
     * @param $table_id
     * @param $tables
     * @return void
     * @throws ReflectionException
     */
    public function genUnit($table_id, $tables): void
    {
        $table = $this->checkModel($table_id)->toArray();
        if (!in_array($table['template'], ["plugin", "app"])) {
            throw new ApiException('模板必须为plugin或者app');
        }

        $columns = $this->columnLogic->findAll(['table_id' => $table_id]);
        $pk = 'id';
        foreach ($columns as &$column) {
            if ($column['is_pk'] == 2) {
                $pk = $column['column_name'];
            }
            if ($column['column_name'] == 'delete_time') {
                unset($column['column_name']);
            }
        }

        $template_name = '/plugin/saiadmin/stub/saiadmin';
        $tpl = new TemplateService($template_name);
        $tpl->assign('pk', $pk);
        $tpl->assignArray($table);
        $tpl->assign('tables', $tables);
        $tpl->assign('columns', $columns);
        if ($table['tpl_category'] == 'tree') {
            $tree_id = $table['options']['tree_id'] ?? '';
            $tree_parent_id = $table['options']['tree_parent_id'] ?? '';
            $tree_name = $table['options']['tree_name'] ?? '';
            $tpl->assign('tree_id', $tree_id);
            $tpl->assign('tree_parent_id', $tree_parent_id);
            $tpl->assign('tree_name', $tree_name);
        }

        if ($table['template'] == 'plugin') {
            $namespace_start = "plugin\\" . $table['namespace'] . "\\app\\";
        } else {
            $namespace_start = "app\\" . $table['namespace'] . "\\";
        }

        $namespace_end = $table['package_name'] != "" ? "\\" . $table['package_name'] : "";
        $url_path = $table['namespace'] . ($table['package_name'] != "" ? "/" . $table['package_name'] : "") . '/' . $table['business_name'];
        if ($table['component_type'] == 3) {
            $tpl->assign('tag_id', $table['options']['tag_id'] ?? mt_rand(10000, 99999));
            $tpl->assign('tag_name', $table['options']['tag_name'] ?? $table['menu_name']);
        }
        $tpl->assign('namespace_start', $namespace_start);
        $tpl->assign('namespace_end', $namespace_end);
        $tpl->assign('url_path', $url_path);

        $relations = [];
        if (isset($table['options']['relations'])) {
            if (count($table['options']['relations']) > 0) {
                $relations = $table['options']['relations'];
            }
        }
        $tpl->assign('relations', $relations);

        $template = $table['template'];
        $class = new ReflectionClass('plugin\saiadmin\utils\GenStruct');
        $instance = $class->newInstanceArgs();
        if (!$class->hasMethod($template)) {
            throw new ApiException('请到GenStruct中为当前模板配置文件结构解析方法!');
        }

        $method = $class->getMethod($template);
        $fileArr = $method->invokeArgs($instance, [$table]);
        foreach ($fileArr as $item) {
            $tpl->gen($item['input'], $item['output']);
        }
    }

    /**
     * 获取数据表字段信息
     * @param int $table_id
     * @return mixed
     */
    public function getTableColumns(int $table_id): mixed
    {
        $query = $this->columnLogic->equalSearch(['table_id' => $table_id]);
        return $this->columnLogic->getAll($query);
    }

    /**
     * 更新表结构和字段信息
     * @param $data
     * @return void
     */
    public function updateTableAndColumns($data): void
    {
        $columns = $data['columns'];
        unset($data['columns']);

        if (!empty($data['belong_menu_id'])) {
            $data['belong_menu_id'] = is_array($data['belong_menu_id']) ? array_pop($data['belong_menu_id']) : $data['belong_menu_id'];
        } else {
            $data['belong_menu_id'] = 0;
        }

        $data['generate_menus'] = implode(',', $data['generate_menus']);
        if (empty($data['options'])) {
            unset($data['options']);
        }

        $data['options'] = json_encode($data['options'], JSON_UNESCAPED_UNICODE);
        // 更新业务表
        $this->update($data);

        // 更新业务字段表
        foreach ($columns as $column) {
            if ($column['options']) {
                $column['options'] = json_encode($column['options'], JSON_NUMERIC_CHECK);
            }

            $this->columnLogic->update($column);
        }
    }
}