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
}