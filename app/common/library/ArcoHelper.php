<?php
declare(strict_types=1);

namespace app\common\library;

class ArcoHelper
{
    /**
     * 数据树形化
     * @param array $data 数据
     * @param string $pk 数据主键字段名
     * @return array
     */
    public static function makeTree(array $data, string $pk = 'id'): array
    {
        $list = [];
        foreach ($data as $value) {
            $list[$value[$pk]] = $value;
        }

        return TreeHelper::tree($list);
    }

    /**
     * 生成ElementPlus菜单
     * @param array $data 数据
     * @param string $pk 数据主键字段名
     * @param string $pid 数据上级字段名
     * @return array
     */
    public static function makeEleMenus(array $data, string $pk = 'id', string $pid = 'parent_id'): array
    {
        $list = [];
        foreach ($data as $value) {
            if ($value['auth_type'] === 1) {
                $temp = [
                    $pk => $value[$pk],
                    $pid => $value[$pid],
                    'name' => StringHelper::camelize(str_replace('/', '_', $value['path'])),
                    'path' => $value['path'],
                    'component' => $value['component'],
                    'meta' => [
                        'title' => $value['title'],
                        'isLink' => $value['link_url'],
                        'isKeepAlive' => $value['is_keep'] === 1,
                        'isAffix' => $value['is_affix'] === 1,
                        'isIframe' => $value['is_iframe'] === 1,
                        'isHide' => $value['is_hide'] === 1,
                        'icon' => $value['icon'],
                    ],
                ];
                $list[$value[$pk]] = $temp;
            }
        }

        return TreeHelper::tree($list);
    }

    /**
     * 生成Arco菜单
     * @param array $data 数据
     * @param string $pk 数据主键字段名
     * @param string $pid 数据上级字段名
     * @return array
     */
    public static function makeArcoMenus(array $data, string $pk = 'id', string $pid = 'parent_id'): array
    {
        $list = [];
        foreach ($data as $value) {
            if ($value['type'] === 'M') {
                $temp = [
                    $pk => $value[$pk],
                    $pid => $value[$pid],
                    'name' => $value['route'],
                    'path' => '/' . $value['route'],
                    'component' => $value['component'],
                    'redirect' => $value['redirect'],
                    'meta' => [
                        'title' => $value['name'],
                        'type' => $value['type'],
                        'hidden' => $value['is_hidden'] === 1,
                        'hiddenBreadcrumb' => false,
                        'icon' => $value['icon'],
                    ],
                ];
                $list[$value[$pk]] = $temp;
            }
            if ($value['type'] === 'I' || $value['type'] === 'L') {
                $temp = [
                    $pk => $value[$pk],
                    $pid => $value[$pid],
                    'name' => $value['code'],
                    'path' => $value['route'],
                    'meta' => [
                        'title' => $value['name'],
                        'type' => $value['type'],
                        'hidden' => $value['is_hidden'] === 1,
                        'hiddenBreadcrumb' => false,
                        'icon' => $value['icon'],
                    ],
                ];
                $list[$value[$pk]] = $temp;
            }
        }

        return TreeHelper::tree($list);
    }

    /**
     * 生成按钮权限数组
     * @param array $data 数据
     * @return array
     */
    public static function makeEleButtons(array $data): array
    {
        $list = [];
        foreach ($data as $value) {
            if ($value['type'] === 'B') {
                $list[] = $value['code'];
            }
        }

        return $list;
    }

    /**
     * 获取业务名称
     * @param string $tableName
     * @return string
     */
    public static function getBusiness(string $tableName): string
    {
        $start = strrpos($tableName, '_');
        if ($start !== false) {
            $result = substr($tableName, $start + 1);
        } else {
            $result = $tableName;
        }

        return StringHelper::camelize($result);
    }

    /**
     * 获取业务名称
     * @param string $tableName
     * @return string
     */
    public static function getBigBusiness(string $tableName): string
    {
        $start = strrpos($tableName, '_');
        $result = substr($tableName, $start + 1);
        return StringHelper::camel($result);
    }

    /**
     * 只替换一次字符串
     * @param string $needle
     * @param string $replace
     * @param string $haystack
     * @return string|array
     */
    public static function strReplaceOnce(string $needle, string $replace, string $haystack): string|array
    {
        $pos = strpos($haystack, $needle);
        if ($pos === false) {
            return $haystack;
        }

        return substr_replace($haystack, $replace, $pos, strlen($needle));
    }
}