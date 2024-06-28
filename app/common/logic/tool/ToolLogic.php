<?php
declare(strict_types=1);

namespace app\common\logic\tool;

use support\Db;
use app\common\base\BaseLogic;

class ToolLogic extends BaseLogic
{

    public function getList($query): array
    {
        $page = request()->input('page') ? request()->input('page') : 1;
        $limit = request()->input('limit') ? request()->input('limit') : 10;

        return self::getTableList($query, $page, $limit);
    }

    /**
     * 获取数据库表数据
     */
    public function getTableList($query, $current_page = 1, $per_page = 10): array
    {
        if (!empty($query['source'])) {
            if (!empty($query['name'])) {
                $sql = 'show table status where name=:name ';
                $list = Db::connection($query['source'])->query($sql, ['name' => $query['name']]);
            } else {
                $list = Db::connection($query['source'])->query('show table status');
            }
        } else {
            if (!empty($query['name'])) {
                $sql = 'show table status where name=:name ';
                $list = Db::query($sql, ['name' => $query['name']]);
            } else {
                $list = Db::query('show table status');
            }
        }

        $data = [];
        foreach ($list as $item) {
            $data[] = [
                'name' => $item['Name'],
                'engine' => $item['Engine'],
                'rows' => $item['Rows'],
                'data_free' => $item['Data_free'],
                'data_length' => $item['Data_length'],
                'index_length' => $item['Index_length'],
                'collation' => $item['Collation'],
                'create_time' => $item['Create_time'],
                'comment' => $item['Comment'],
            ];
        }
        $total = count($data);
        $last_page = ceil($total/$per_page);
        $startIndex = ($current_page - 1) * $per_page;
        $pageData = array_slice($data, $startIndex, $per_page);
        return [
            'data' => $pageData,
            'total' => $total,
            'current_page' => $current_page,
            'per_page' => $per_page,
            'last_page' => $last_page,
        ];
    }

    /**
     * 获取列信息
     */
    public function getColumnList($table, $source): array
    {
        $columnList = [];
        if (preg_match("/^[a-zA-Z0-9_]+$/", $table)) {
            if (!empty($source)) {
                $list = Db::connect($source)->query('SHOW FULL COLUMNS FROM `'.$table.'`');
            } else {
                $list = Db::query('SHOW FULL COLUMNS FROM `'.$table.'`');
            }
            foreach ($list as $column) {
                preg_match('/^\w+/', $column['Type'], $matches);
                $columnList[] = [
                    'column_key' => $column['Key'],
                    'column_name'=> $column['Field'],
                    'column_type' => $matches[0],
                    'column_comment' => trim(preg_replace("/\([^()]*\)/", "", $column['Comment'])),
                    'extra' => $column['Extra'],
                    'default_value' => $column['Default'],
                    'is_nullable' => $column['Null'],
                ];
            }
        }

        return $columnList;
    }

    /**
     * 优化表
     */
    public function optimizeTable($tables): void
    {
        foreach ($tables as $table) {
            if (preg_match("/^[a-zA-Z0-9_]+$/", $table)) {
                Db::execute('OPTIMIZE TABLE `'. $table. '`');
            }
        }
    }

    /**
     * 清理表碎片
     */
    public function fragmentTable($tables): void
    {
        foreach ($tables as $table) {
            if (preg_match("/^[a-zA-Z0-9_]+$/", $table)) {
                Db::execute('ANALYZE TABLE `'. $table. '`');
            }
        }
    }

}
