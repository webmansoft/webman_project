<?php
declare(strict_types=1);

namespace app\common\base;

use Closure;
use support\Model;
use app\common\library\TreeHelper;
use app\common\trait\TableFieldsTrait;

abstract class LogicSearch
{
    use TableFieldsTrait;

    protected Model $model;                // 模型
    protected int $admin_id = 0;           // 当前管理员编号
    protected array $admin = [];           // 当前管理员信息
    protected bool $scope = false;      // 数据边界启用状态

    private array $query = [];          // 原始查询数据
    private int $page = 1;
    private int $limit = 10;
    private array $fields = [];         // 模型所有字段
    private string $format = 'normal';  // 当前数据输出格式
    private array $orderBy = [];        // 排序 可以多个
    private array $querySearchKeyValue = []; // 保留搜索字段的键值对 字段必须在表中存在 且不能为空
    private array $searchField = [];    // 统计搜索字段
    private array $hiddenField = ['updated_time', 'deleted_time', 'updated_at', 'deleted_at', 'created_by', 'updated_by', 'password']; // 隐藏字段
    private array $rules = ['>', '>=', '=', '<', '<=', '<>', 'like', 'not like', 'in', 'not in', 'null', 'not null', 'between'];
    private array $formatList = [
        // 输出数据格式类型
        'select' => 'formatSelect',
        'tree' => 'formatTree',
        'table_tree' => 'formatTableTree',
    ];

    // 搜索条件
    // ['name', ['like','keyword']]
    // ['phone', ['between','2011-12-22','2012-01-02']]
    // ['age', ['>','6']]
    private array $searchCondition = [];

    // 自定义搜索条件 自带数值
    private array $appendIn = [];
    private array $appendLike = [];
    private array $appendBetween = [];
    private array $appendWhere = [];

    private array $appendHas = [];
    private array $appendWith = [];
    private array $appendWithWhereHas = [];

    // 自定义显示字段
    private array $appendField = [];

    /**
     * 初始化
     * @param int $admin_id
     * @param array $admin
     * @return void
     */
    public function init(int $admin_id, array $admin): void
    {
        $this->admin = $admin;
        $this->admin_id = $admin_id;
    }

    public function __construct()
    {
        if (request()) {
            $this->initBase();
            $this->initFields();
            $this->initOrderBy();
            $this->initQuerySearchKeyValue();
            $this->initInnerSearchCondition();
        }
    }

    /**
     * 初始化 get newQuery page limit format
     * @return void
     */
    private function initBase(): void
    {
        $this->query = Request()->get() ?? [];
        $this->page = intval($this->query['page'] ?? 1);
        $this->limit = intval($this->query['limit'] ?? 10);
        if (isset($this->query['format']) && array_key_exists($this->query['format'], $this->formatList)) {
            $this->format = $this->query['format'];
            if (in_array($this->format, ['tree', 'table_tree'])) {
                $this->limit = 1000;
            }
        }
    }

    /**
     * 初始化显示字段 设置附加字段 设置隐藏字段
     * @return void
     */
    private function initFields(): void
    {
        $this->fields = $this->getCacheTableField($this->model->getTable());
    }

    /**
     * 初始化排序
     * @return void
     */
    private function initOrderBy(): void
    {
        $sortOrder = $this->query['sortOrder'] ?? false;
        // 自动排序
        if (isset($this->fields['sort'])) {
            if ($sortOrder === false) {
                // 树形必须顺序排序
                if (in_array($this->format, ['tree', 'table_tree'])) {
                    $sortOrder = 'asc';
                }
            } else {
                $sortOrder = in_array($sortOrder, ['asc', 'desc']) ? $sortOrder : 'asc';
            }
        } else {
            $sortOrder = false;
        }

        // 按权重字段排序
        if ($sortOrder) {
            $this->orderBy['sort'] = $sortOrder;
        }

        $orderField = $this->query['orderField'] ?? $this->model->getKeyName();
        if (isset($this->fields[$orderField]) && $orderField !== 'sort') {
            $orderType = $this->query['orderType'] ?? 'desc';
            $orderType = in_array($orderType, ['asc', 'desc']) ? $orderType : 'desc';
            $this->orderBy[$orderField] = $orderType;
        }
    }

    /**
     * 初始化可用搜索字段 键值对
     * @return void
     */
    private function initQuerySearchKeyValue(): void
    {
        $where = $this->query;
        foreach ($where as $field => $value) {
            if (trim($value) === '' || !isset($this->fields[$field])) {
                unset($where[$field]);
            }
        }

        $this->querySearchKeyValue = $where;
    }

    /**
     * 内置字段搜索条件
     * @return void
     */
    private function initInnerSearchCondition(): void
    {
        $like = ['name', 'title', 'account', 'phone', 'email', 'username', 'nickname', 'realname', 'origin_name', 'file_hash'];
        $between = ['created_time', 'updated_time', 'deleted_time', 'created_at', 'updated_at', 'deleted_at', 'last_at'];
        $eq = ['status'];

        foreach ($like as $k => $field) {
            if (isset($this->fields[$field])) {
                $this->searchField[$field] = $field;
            } else {
                unset($like[$k]);
            }
        }

        foreach ($between as $field) {
            if (isset($this->fields[$field])) {
                $this->searchField[$field] = $field;
            } else {
                unset($between[$k]);
            }
        }

        foreach ($eq as $k => $field) {
            if (isset($this->fields[$field])) {
                $this->searchField[$field] = $field;
            } else {
                unset($eq[$k]);
            }
        }

        $condition = $this->toolFormat(['like' => $like, 'between' => $between, '=' => $eq]);
        $this->searchCondition = array_merge($this->searchCondition, $condition);
    }

    public function setOrderType(string|array $orderField, string $orderType = 'DESC'): static
    {
        $this->orderBy = [];
        if (is_string($orderField)) {
            $this->orderBy[$orderField] = $orderType;
        } elseif (is_array($orderField)) {
            foreach ($orderField as $field => $type) {
                $this->orderBy[$field] = $type;
            }
        }

        return $this;
    }

    // 设置隐藏字段
    public function setAppendHidden(array|string $hiddenField): static
    {
        if (is_string($hiddenField)) {
            $hiddenField = explode(',', $hiddenField);
        }

        foreach ($hiddenField as $key => $field) {
            if (!isset($this->fields[$field])) {
                unset($hiddenField[$key]);
            }
        }

        $this->hiddenField = array_merge($this->hiddenField, $hiddenField);
        return $this;
    }

    // 设置附加字段
    public function setAppendField(array|string $appendField): static
    {
        if (is_string($appendField)) {
            $appendField = explode(',', $appendField);
        }

        $this->appendField = $appendField;
        return $this;
    }

    // 设置附加搜索
    public function setAppendWhere(array|string $field, Closure|string|int|bool $value = 0): static
    {
        if (is_array($field)) {
            foreach ($field as $key => $value) {
                $this->appendWhere[$key] = $value;
            }
        } else {
            if (is_bool($value)) {
                $value = intval($value);
            }
            $this->appendWhere[$field] = $value;
        }

        return $this;
    }

    // 快捷设置搜索 In
    public function setAppendIn(string $field, Closure|array|string|int $value): static
    {
        if (is_string($value)) {
            $value = explode(',', $value);
        } elseif (is_int($value)) {
            $value = [$value];
        }

        $this->appendIn[$field] = $value;
        return $this;
    }

    // 快捷设置搜索 Like
    public function setAppendLike(string $field, string $value): static
    {
        $this->appendLike[$field] = $value;
        return $this;
    }

    // 快捷设置搜索 Between
    public function setAppendBetween(string $field, array|string $value): static
    {
        if (is_string($value)) {
            $value = explode(' - ', $value);
        }

        $this->appendBetween[$field] = $value;
        return $this;
    }

    // 快捷设置 whereHas
    public function setAppendHas(string $name, Closure $closure): static
    {
        $this->appendHas[$name] = $closure;
        return $this;
    }

    // 快捷设置 with
    public function setAppendWith(array|string $name, Closure|null $closure = null): static
    {
        if (is_array($name)) {
            foreach ($name as $key => $value) {
                if (is_string($key) && is_callable($value)) {
                    $this->appendWith[$key] = $value;
                } elseif (is_int($key) && is_string($value)) {
                    $this->appendWith[$value] = null;
                }
            }
        } else {
            $this->appendWith[$name] = $closure;
        }

        return $this;
    }

    // 快捷设置 with
    public function setAppendWithWhereHas(string $name, Closure $closure): static
    {
        $this->appendWithWhereHas[$name] = $closure;
        return $this;
    }

    // 设置搜索条件格式
    // 自定义设置搜索字段和规则 querySearchKeyValue提供数据
    // ['>', '>=', '=', '<', '<=', '<>', 'like', 'not like', 'in', 'not in', 'null', 'not null', 'between'];
    public function setWhere(string|array $field, string $rule = '='): static
    {
        if (is_string($field)) {
            $field = explode(',', $field);
        }

        if (in_array($rule, $this->rules)) {
            $data[$rule] = $field;
            $condition = $this->toolFormat($data);
            $this->searchCondition = array_merge($this->searchCondition, $condition);
        }

        return $this;
    }

    public function setWhereLike(string|array $field): static
    {
        $this->setWhere($field, 'like');
        return $this;
    }

    public function setWhereNotLike(string|array $field): static
    {
        $this->setWhere($field, 'not like');
        return $this;
    }

    public function setWhereIn(string|array $field): static
    {
        $this->setWhere($field, 'in');
        return $this;
    }

    public function setWhereNotIn(string|array $field): static
    {
        $this->setWhere($field, 'not in');
        return $this;
    }

    public function setWhereBetween(string|array $field): static
    {
        $this->setWhere($field, 'between');
        return $this;
    }

    private function query(): void
    {
        $this->model->newQuery()->select($this->fields);
        if ($this->appendHas) {
            foreach ($this->appendHas as $field => $value) {
                $this->model->newQuery()->whereHas($field, $value);
            }
        }

        if ($this->appendWith) {
            $with = [];
            foreach ($this->appendWith as $name => $closure) {
                if (is_callable($closure)) {
                    $with[$name] = $closure;
                } else {
                    $with[] = $name;
                }
            }

            $this->model->newQuery()->with($with);
        }

        if ($this->appendWithWhereHas) {
            foreach ($this->appendWithWhereHas as $name => $closure) {
                $this->model->newQuery()->withWhereHas($name, $closure);
            }
        }

        $this->initSearchCondition();

        if ($this->orderBy) {
            foreach ($this->orderBy as $filed => $type) {
                $this->model->newQuery()->orderBy($filed, $type);
            }
        }
    }

    /**
     * [$total, $items]
     * @param mixed $field
     * @return array
     */
    public function select(mixed $field = ['*']): array
    {
        $this->query();
        $offset = ($this->page - 1) * $this->limit;
        $total = $this->model->newQuery()->count();
        $items = $this->model->newQuery()
            ->select($field)
            ->offset($offset)
            ->limit($this->limit)
            ->get()
            ->append($this->appendField)
            ->makeHidden($this->hiddenField)
            ->toArray();

        switch ($this->format) {
            case 'tree':
                $items = $this->formatTree($items);
                break;
            case 'table_tree':
                $items = $this->formatTableTree($items);
                break;
            case 'select':
                $items = $this->formatSelect($items);
                break;
        }

        if (config('app.debug')) {
            write_log($this->model->newQuery()->toSql(), 'select toSql');
        }

        return [$total, $items];
    }

    public function selectAll(mixed $field = ['*']): array
    {
        $this->query();
        $items = $this->model->newQuery()
            ->select($field)
            ->get()
            ->append($this->appendField)
            ->makeHidden($this->hiddenField)
            ->toArray();

        if (config('app.debug')) {
            write_log($this->model->newQuery()->toSql(), 'select toSql');
        }

        return $items;
    }

    protected function initSearchCondition(): static
    {
        foreach ($this->searchCondition as $field => $value) {
            if (is_array($value)) {
                if ($value[0] === 'like' || $value[0] === 'not like') {
                    $this->model->newQuery()->where($field, $value[0], "%$value[1]%");
                } elseif (in_array($value[0], ['>', '>=', '=', '<', '<=', '<>'])) {
                    $this->model->newQuery()->where($field, $value[0], $value[1]);
                } elseif ($value[0] == 'in' && !empty($value[1])) {
                    $valArr = $value[1];
                    if (is_string($value[1])) {
                        $valArr = explode(',', trim($value[1]));
                    }
                    $this->model->newQuery()->whereIn($field, $valArr);
                } elseif ($value[0] == 'not in' && !empty($value[1])) {
                    $valArr = $value[1];
                    if (is_string($value[1])) {
                        $valArr = explode(',', trim($value[1]));
                    }
                    $this->model->newQuery()->whereNotIn($field, $valArr);
                } elseif ($value[0] == 'null') {
                    $this->model->newQuery()->whereNull($field);
                } elseif ($value[0] == 'not null') {
                    $this->model->newQuery()->whereNotNull($field);
                } elseif ($value[0] !== '' || $value[1] !== '') {
                    $this->model->newQuery()->whereBetween($field, $value);
                }
            } else {
                $this->model->newQuery()->where($field, $value);
            }
        }

        if ($this->appendWhere) {
            foreach ($this->appendWhere as $field => $value) {
                $this->model->newQuery()->where($field, $value);
                $this->searchField[$field] = $field;
            }
        }

        if ($this->appendIn) {
            foreach ($this->appendIn as $field => $value) {
                $this->model->newQuery()->whereIn($field, $value);
                $this->searchField[$field] = $field;
            }
        }

        if ($this->appendLike) {
            foreach ($this->appendLike as $field => $value) {
                $this->model->newQuery()->where($field, 'like', "%$value%");
                $this->searchField[$field] = $field;
            }
        }

        if ($this->appendBetween) {
            foreach ($this->appendBetween as $field => $value) {
                $this->model->newQuery()->whereBetween($field, $value);
                $this->searchField[$field] = $field;
            }
        }

        // 未删除的剩余数据用等号搜索
        if ($this->querySearchKeyValue) {
            foreach ($this->querySearchKeyValue as $field => $value) {
                if (!isset($this->searchField[$field])) {
                    $this->model->newQuery()->where($field, $value);
                }
            }
        }

        return $this;
    }

    /**
     * 格式化表格树
     * @param array $items
     * @return array
     */
    private function formatTree(array $items): array
    {
        return TreeHelper::makeTree($this->formatData($items));
    }

    /**
     * 格式化表格树
     * @param array $items
     * @return array
     */
    private function formatTableTree(array $items): array
    {
        return TreeHelper::getTreeMenuHtml($this->formatData($items));
    }

    /**
     * 格式化下拉列表
     * @param array $items
     * @return array
     */
    private function formatSelect(array $items): array
    {
        $formatItems = [];
        foreach ($items as $item) {
            $formatItems[] = [
                'name' => $item['name'] ?? $item['title'] ?? $item['id'],
                'value' => $item['id']
            ];
        }

        return $formatItems;
    }

    /**
     * 格式化树
     * @param array $items
     * @return array
     */
    private function formatData(array $items): array
    {
        foreach ($items as &$item) {
            $item['name'] = $item['name'] ?? $item['title'] ?? $item['id'];
        }

        return $items;
    }

    /**
     * ['like' => ['name','phone','email']]
     * ['like' => ['origin_name'], 'in' => ['file_ext'], 'between' => ['created_at']]
     * 字段已定义规则和对应值
     * @param array $data
     * @return array
     */
    private function toolFormat(array $data): array
    {
        $where = [];
        foreach ($data as $rule => $fields) {
            if (is_array($fields)) {
                foreach ($fields as $field) {
                    if (isset($this->querySearchKeyValue[$field]) && in_array($rule, $this->rules)) {
                        $value = $this->querySearchKeyValue[$field];
                        if ($value || $value === '0') {
                            if ($rule === 'between' && str_contains($value, ' - ')) {
                                // 开始日期 >= and <= 结束日期
                                $array = explode(' - ', $value);
                                $where[$field] = [$array[0], $array[1] . ' 23:59:59'];
                            } elseif (in_array($rule, ['null', 'not null'])) {
                                $where[$field] = [$rule];
                            } else {
                                $where[$field] = [$rule, $value];
                            }

                            unset($this->querySearchKeyValue[$field]);
                        }
                    }
                }
            }
        }

        return $where;
    }
}