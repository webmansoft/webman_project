<?php
declare(strict_types=1);

namespace app\common\library;

class DatetimeHelper
{
    /**
     * 获取某天前时间戳
     * @param  $day
     * @return int
     */
    public static function linuxTime($day): int
    {
        $day = intval($day);
        return mktime(23, 59, 59, intval(date('m')), intval(date('d')) - $day, intval(date('y')));
    }

    /**
     * 返回今天还剩多少秒
     * @return int
     */
    public static function todaySeconds(): int
    {
        $mtime = mktime(23, 59, 59, intval(date('m')), intval(date('d')), intval(date('y')));
        return $mtime - time();
    }

    /**
     * 判断当前是否为当天时间
     * @param $time
     * @return bool
     */
    public static function isToday($time): bool
    {
        if (!$time) {
            return false;
        }

        $today = date('Y-m-d');
        if (str_contains($time, '-')) {
            $time = strtotime($time);
        }

        return $today == date('Y-m-d', $time);
    }

    /**
     * 格式化时间
     * @param [type] $time
     * @param bool $unix
     * @return string
     */
    public static function publishedDate($time, bool $unix = true): string
    {
        if (!$unix) {
            $time = strtotime($time);
        }

        $currentTime = time() - $time;
        $published = [
            '86400' => '天',
            '3600' => '小时',
            '60' => '分钟',
            '1' => '秒'
        ];

        if ($currentTime == 0) {
            return '1秒前';
        } else if ($currentTime >= 604800 || $currentTime < 0) {
            return date('Y-m-d H:i:s', $time);
        } else {
            foreach ($published as $k => $v) {
                if (0 != $c = floor($currentTime / (int)$k)) {
                    return $c . $v . '前';
                }
            }
        }

        return date('Y-m-d H:i:s', $time);
    }

    /**
     * 计算天数
     * @param int|string $time
     * @return float
     */
    public static function distanceDay(int|string $time): float
    {
        if (!is_numeric($time)) {
            $time = strtotime($time);
        }

        $time = time() - $time;
        return ceil($time / (60 * 60 * 24));
    }

    /**
     * 日期格式标准输出
     * @param int|string $datetime 输入日期
     * @param string $format 输出格式
     * @return string
     */
    public static function formatDatetime(int|string $datetime, string $format = 'Y-m-d H:i:s'): string
    {
        if (empty($datetime)) {
            return '-';
        } elseif (is_numeric($datetime)) {
            return date($format, intval($datetime));
        } elseif ($timestamp = strtotime($datetime)) {
            return date($format, $timestamp);
        } else {
            return $datetime;
        }
    }
}