<?php
declare(strict_types=1);

namespace app\common\library;

class TreeHelper
{
    /**
     * 数据树形化
     * @param array $data 数据
     * @param string $childrenName 子数据名
     * @param string $keyName 数据key名
     * @param string $parentName 数据上级key名
     * @return array
     */
    public static function makeTree(array $data, string $childrenName = 'children', string $keyName = 'id', string $parentName = 'parent_id'): array
    {
        $list = [];
        foreach ($data as $value) {
            $list[$value[$keyName]] = $value;
        }

        $tree = []; // 格式化好的树
        foreach ($list as $item) {
            if (isset($list[$item[$parentName]])) {
                $list[$item[$parentName]][$childrenName][] = &$list[$item[$keyName]];
            } else {
                $tree[] = &$list[$item[$keyName]];
            }
        }

        return $tree;
    }

    public static function formatArray(array &$data): void
    {
        foreach ($data as $index=>$item){
            if(is_object($item)){
                $data[$index] = (array)$item;
            }
        }
    }

    /**
     * 树形菜单
     * @param array $data 原始数据集
     * @param string $indexField 主键字段名
     * @param string $parentField 父级字段名
     * @param string $childrenField 包含子集字段名
     * @param bool $indexKey 是否用主键字段作为索引
     * @return array
     */
    public static function getTreeMenu(array $data, string $indexField = 'id', string $parentField = 'parent_id', string $childrenField = 'children', bool $indexKey = false): array
    {
        $tree = [];
        $items = [];

        foreach ($data as $v) {
            $items[$v[$indexField]] = $v;
        }

        foreach ($items as $k => $v) {
            $pid = $v[$parentField];
            if (isset($items[$pid])) {
                $items[$pid][$childrenField][] = &$items[$k];
                $items[$pid]['ids'][] = $k;
                $items[$pid]['all'] = [];
                if (!in_array($pid, $items[$pid]['all'])) {
                    $items[$pid]['all'][] = $pid;
                }
                $items[$pid]['all'][] = $k;
            } else {
                if ($indexKey) {
                    $tree[$k] = &$items[$k];
                } else {
                    $tree[] = &$items[$k];
                }
            }
        }

        return $tree;
    }

    /**
     * 用主键字段作为索引 树形菜单
     * @param array $data 原始数据集
     * @param string $indexField 主键字段名
     * @param string $parentField 父级字段名
     * @param string $childrenField 包含子集字段名
     * @return array
     */
    public static function getIndexTreeMenu(array $data, string $indexField = 'id', string $parentField = 'parent_id', string $childrenField = 'children'): array
    {
        return static::getTreeMenu($data, $indexField, $parentField, $childrenField, true);
    }

    /**
     * 树形菜单 格式化输出
     * @param array $data 原始数据集
     * @param int $parentValue 父级ID值
     * @param string $parentField 父级字段名
     * @param string $indexField 主键字段名
     * @param string $textField 显示文本字段名
     * @param string $html 层级文本标识
     * @param int $level 当前所在层级
     * @param array $returnData 返回数组值
     * @return array
     */
    public static function getTreeMenuHtml(array $data, string $textField = 'name', string $parentField = 'parent_id', string $indexField = 'id', int $parentValue = 0, string $html = '├─ ', int $level = 0, array &$returnData = []): array
    {
        foreach ($data as $key => $value) {
            if ($value[$parentField] == $parentValue) {
                $value[$textField] = str_repeat($html, $level) . $value[$textField];
                $returnData[] = $value;
                unset($data[$key]);
                static::getTreeMenuHtml($data, $textField, $parentField, $indexField, $value[$indexField], $html, $level + 1, $returnData);
            }
        }

        return $returnData;
    }

    /**
     * 将一个二维数组按照指定字段的值分组
     * @param array $data
     * @param string $keyField
     * @return array
     */
    public static function arrayGroupBy(array $data, string $keyField = 'id'): array
    {
        $result = [];
        foreach ($data as $row) {
            if (isset($row[$keyField])) {
                $key = $row[$keyField];
                $result[$key] = $row;
            }
        }

        return $result;
    }

    /**
     * 使用实例
     * $result = [];
     * ArrayUtils::getParentPath($tree, 1, $result, 'id');
     *
     * 获取父类节点
     * @param array $tree 树形数据
     * @param int $indexValue 当前索引值
     * @param array $result 返回结果
     * @param string $indexField
     * @param string $textField
     * @param string $childrenField
     * @return bool
     */
    public static function getParentPath(array $tree, int $indexValue, array &$result, string $indexField = 'id', string $textField = 'name', string $childrenField = 'children'): bool
    {
        foreach ($tree as $item) {
            $result[$item[$indexField]] = $item[$textField];
            if ($item[$indexField] === $indexValue) {
                return true;
            }
            if (isset($item[$childrenField]) && static::getParentPath($item[$childrenField], $indexValue, $result, $indexField, $textField, $childrenField)) {
                return true;
            }
            array_pop($result);
        }

        return false;
    }
}