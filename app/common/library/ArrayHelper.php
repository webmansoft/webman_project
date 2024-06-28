<?php
declare(strict_types=1);

namespace app\common\library;

class ArrayHelper
{
    /**
     * 获取数组中指定的列
     * @param array $source
     * @param string $column
     * @return array
     */
    public static function getArrayColumn(array $source, string $column): array
    {
        $columnArr = [];
        foreach ($source as $item) {
            if (isset($item[$column])) {
                $columnArr[] = $item[$column];
            }
        }

        return $columnArr;
    }

    /**
     * 数组中根据key值获取value
     * @param array $array
     * @param string $key
     * @return mixed
     */
    public static function getConfigValue(array $array, string $key): mixed
    {
        foreach ($array as $item) {
            if ($item['key'] === $key) {
                return $item['value'];
            }
        }

        return '';
    }
}