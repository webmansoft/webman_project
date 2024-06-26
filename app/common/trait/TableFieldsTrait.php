<?php

namespace app\common\trait;

use support\Db;
use support\Cache;
use app\common\exception\ApiException;

trait TableFieldsTrait
{
    /**
     * 获取数据表全部字段
     * @return array
     */
    public function getTableField(): array
    {
        $table = config('database.connections.mysql.prefix') . $this->model->getTable();
        $field = Db::select("desc `$table`");
        if (!$field) {
            throw new ApiException($table . ' 表不存在');
        } else {
            return array_column($field, 'Field', 'Field');
        }
    }

    /**
     * 获取缓存数据表全部字段
     * @param bool $force
     * @return array
     */
    public function getCacheTableField(bool $force = false): array
    {
        $key = $this->model->getTable() . '_cache_field';
        $fields = Cache::get($key);
        if (empty($fields) || $force) {
            $fields = $this->getTableField();
            Cache::set($key, $fields);
            return $fields;
        }

        return $fields;
    }
}