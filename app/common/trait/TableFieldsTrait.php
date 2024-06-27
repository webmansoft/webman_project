<?php

namespace app\common\trait;

use support\Db;
use support\Cache;
use app\common\exception\ApiException;

trait TableFieldsTrait
{
    /**
     * 获取数据表全部字段
     * @param string $table_name
     * @return array
     */
    public function getTableField(string $table_name): array
    {
        $table = config('database.connections.mysql.prefix') . $table_name;
        $field = Db::select("desc `$table`");
        if (!$field) {
            throw new ApiException($table . ' 表不存在');
        } else {
            return array_column($field, 'Field', 'Field');
        }
    }

    /**
     * 获取缓存数据表全部字段
     * @param string $table_name
     * @param bool $force
     * @return array
     */
    public function getCacheTableField(string $table_name, bool $force = false): array
    {
        $key = $table_name . '_cache_field';
        $fields = Cache::get($key);
        if (empty($fields) || $force) {
            $fields = $this->getTableField($table_name);
            Cache::set($key, $fields);
            return $fields;
        }

        return $fields;
    }
}