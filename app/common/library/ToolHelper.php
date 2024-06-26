<?php
declare(strict_types=1);

namespace app\common\library;

use Exception;
use Ip2Region;
use Overtrue\Pinyin\Pinyin;

class ToolHelper
{
    public static function getIpLocation($ip): string
    {
        $ip2region = new Ip2Region();
        try {
            $region = $ip2region->memorySearch($ip);
        } catch (Exception) {
            return '未知';
        }

        // list($country, $number, $province, $city, $network) = explode('|', $region['region']);
        $data = explode('|', $region['region']);
        $country = $data[0];
        $province = $data[2];
        $city = $data[3];
        $network = $data[4];

        if ($network === '内网IP') {
            return $network;
        }

        if ($country == '中国') {
            return $province . '-' . $city . ':' . $network;
        } else if ($country == '0') {
            return '未知';
        } else {
            return $country;
        }
    }

    /**
     * 获取拼音
     * @param string $chinese
     * @param bool $onlyFirst
     * @param string $separator
     * @param bool $ucFirst
     * @return string
     */
    public static function pinyin(string $chinese, bool $onlyFirst = false, string $separator = '', bool $ucFirst = false): string
    {
        $pinyin = new Pinyin();
        $result = $onlyFirst ? $pinyin->abbr($chinese) : $pinyin->permalink($chinese, $separator);
        if ($ucFirst) {
            $pinyinArr = explode($separator, $result);
            $result = implode($separator, array_map('ucfirst', $pinyinArr));
        }

        return $result;
    }

    /**
     * 格式化文件大小 将字节转换为可读文本
     * @param int $fileSize
     * @return string
     */
    public static function formatBytes(int $fileSize): string
    {
        $size = sprintf("%u", $fileSize);
        if ($size == 0) {
            return '0 Bytes';
        }

        $sizeName = [' Bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB'];
        return round($size / pow(1024, ($i = floor(log((float)$size, 1024)))), 2) . $sizeName[$i];
    }

    /**
     * 获取注释中第一行
     * @param string|bool $comment
     * @return string|bool
     */
    public static function getCommentFirstLine(string|bool $comment): string|bool
    {
        if ($comment === false) {
            return false;
        }

        foreach (explode("\n", $comment) as $str) {
            if ($s = trim($str, "*/\ \t\n\r\0\x0B")) {
                return $s;
            }
        }

        return $comment;
    }
}