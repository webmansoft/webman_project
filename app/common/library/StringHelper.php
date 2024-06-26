<?php
declare(strict_types=1);

namespace app\common\library;

class StringHelper
{
    public static function isJson($string): bool
    {
        return !((json_decode($string) == null));
    }

    public static function strReplace(string $string): string
    {
        return str_replace(["\t", "\n", "\r", '\t', '\n', '\r', ' ', "'"], '', trim($string));
    }

    /**
     * 将一个字符串部分字符用*替代隐藏
     * @param string $string 待转换的字符串
     * @param int $begin 起始位置，从0开始计数，当$type=4时，表示左侧保留长度
     * @param int $len 需要转换成*的字符个数，当$type=4时，表示右侧保留长度
     * @param int $type 转换类型：0，从左向右隐藏；1，从右向左隐藏；2，从指定字符位置分割前由右向左隐藏；3，从指定字符位置分割后由左向右隐藏；4，保留首末指定字符串中间用***代替
     * @param string $glue 分割符
     * @return string|bool 处理后的字符串
     */
    public static function hideStr(string $string, int $begin = 3, int $len = 4, int $type = 4, string $glue = '@'): string|bool
    {
        if (empty($string)) {
            return false;
        }

        $array = [];
        $strlen = $length = mb_strlen($string);

        if ($type == 0 || $type == 1 || $type == 4) {
            while ($strlen) {
                $array[] = mb_substr($string, 0, 1, 'utf8');
                $string = mb_substr($string, 1, $strlen, 'utf8');
                $strlen = mb_strlen($string);
            }
        }

        if ($type == 0) {
            for ($i = $begin; $i < ($begin + $len); $i++) {
                if (isset($array[$i])) {
                    $array[$i] = '*';
                }
            }
            $string = implode('', $array);
        } elseif ($type == 1) {
            $array = array_reverse($array);
            for ($i = $begin; $i < ($begin + $len); $i++) {
                if (isset($array[$i])) {
                    $array[$i] = '*';
                }
            }
            $string = implode('', array_reverse($array));
        } elseif ($type == 2) {
            $array = explode($glue, $string);
            if (isset($array[0])) {
                $array[0] = self::hideStr($array[0], $begin, $len, 1);
            }
            $string = implode($glue, $array);
        } elseif ($type == 3) {
            $array = explode($glue, $string);
            if (isset($array[1])) {
                $array[1] = self::hideStr($array[1], $begin, $len);
            }
            $string = implode($glue, $array);
        } elseif ($type == 4) {
            $left = $begin;
            $right = $len;
            $tem = array();
            for ($i = 0; $i < ($length - $right); $i++) {
                if (isset($array[$i])) {
                    $tem[] = $i >= $left ? '' : $array[$i];
                }
            }
            $tem[] = '*****';
            $array = array_chunk(array_reverse($array), $right);
            $array = array_reverse($array[0]);
            for ($i = 0; $i < $right; $i++) {
                if (isset($array[$i])) {
                    $tem[] = $array[$i];
                }
            }
            $string = implode('', $tem);
        }

        return $string;
    }

    /**
     * 字符串截取 同时去掉HTML与空白
     * @param string $str
     * @param int $start
     * @param int $length
     * @param string $charset
     * @param bool $suffix
     * @return string
     */
    public static function cutString(string $str, int $start = 0, int $length = 100, string $charset = 'utf-8', bool $suffix = true): string
    {
        $str = preg_replace('/<[^>]+>/', '', preg_replace("/[\r\n\t ]+/", ' ', self::removeBlank((strip_tags($str)))));
        $str = preg_replace('/&(\w{4});/i', '', $str);

        // 直接返回
        if ($start == -1) {
            return $str;
        }

        if (function_exists("mb_substr")) {
            $slice = mb_substr($str, $start, $length, $charset);
        } elseif (function_exists('iconv_substr')) {
            $slice = iconv_substr($str, $start, $length, $charset);

        } else {
            $re['utf-8'] = "/[x01-x7f]|[xc2-xdf][x80-xbf]|[xe0-xef][x80-xbf]{2}|[xf0-xff][x80-xbf]{3}/";
            $re['gb2312'] = "/[x01-x7f]|[xb0-xf7][xa0-xfe]/";
            $re['gbk'] = "/[x01-x7f]|[x81-xfe][x40-xfe]/";
            $re['big5'] = "/[x01-x7f]|[x81-xfe]([x40-x7e]|xa1-xfe])/";
            preg_match_all($re[$charset], $str, $match);
            $slice = join("", array_slice($match[0], $start, $length));
        }

        $fix = '';
        if (strlen($slice) < strlen($str)) {
            $fix = '...';
        }

        return $suffix ? $slice . $fix : $slice;
    }

    /**
     * 去掉换行
     * @param string $value 字符串
     * @return string
     */
    public static function removeLineBreaks(string $value): string
    {
        $value = str_replace(["<nr/>", "<rr/>"], ["\n", "\r"], $value);
        return trim($value);
    }

    /**
     * 去掉连续空白
     * @param string $value 字符串
     * @return string
     */
    public static function removeBlank(string $value): string
    {
        $value = str_replace('　', ' ', str_replace('', ' ', $value));
        $value = preg_replace("/[\r\n\t ]+/", ' ', $value);
        return trim($value);
    }

    /**
     * 只替换一次字符串
     * @param string $needle
     * @param string|array $replace
     * @param string $haystack
     * @return string|array
     */
    public static function strReplaceOnce(string $needle, string|array $replace, string $haystack): string|array
    {
        $pos = strpos($haystack, $needle);
        if ($pos === false) {
            return $haystack;
        }

        return substr_replace($haystack, $replace, $pos, strlen($needle));
    }

    /**
     * 下划线转驼峰 首字母大写
     * @param string $value
     * @return string
     */
    public static function studly(string $value): string
    {
        $value = ucwords(str_replace(['-', '_'], ' ', $value));
        return str_replace(' ', '', $value);
    }

    /**
     * 下划线转驼峰
     */
    public static function camelize(string $underlineWords, string $separator = '_'): string
    {
        $underlineWords = $separator . str_replace($separator, ' ', strtolower($underlineWords));
        return ltrim(str_replace(' ', '', ucwords($underlineWords)), $separator);
    }

    /**
     * 驼峰命名转下划线命名
     */
    public static function unCamelize(string|array $camelCaps, string $separator = '_'): string
    {
        return strtolower(preg_replace('/([a-z])([A-Z])/', "$1" . $separator . "$2", $camelCaps));
    }

    /**
     * 转换为驼峰
     * @param string $value
     * @return string
     */
    public static function camel(string $value): string
    {
        static $cache = [];
        $key = $value;
        if (isset($cache[$key])) {
            return $cache[$key];
        }

        $value = ucwords(str_replace(['-', '_'], ' ', $value));
        return $cache[$key] = str_replace(' ', '', $value);
    }

    public static function substr(string $string, int $start, int $length = null): string
    {
        return mb_substr($string, $start, $length, 'UTF-8');
    }
}