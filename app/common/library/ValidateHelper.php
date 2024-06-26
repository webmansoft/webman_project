<?php
declare(strict_types=1);

namespace app\common\library;

class ValidateHelper
{
    const FILTER = [
        'email' => FILTER_VALIDATE_EMAIL,
        'ip' => [FILTER_VALIDATE_IP, FILTER_FLAG_IPV4 | FILTER_FLAG_IPV6],
        'integer' => FILTER_VALIDATE_INT,
        'url' => FILTER_VALIDATE_URL,
        'macAddr' => FILTER_VALIDATE_MAC,
        'float' => FILTER_VALIDATE_FLOAT,
    ];

    /**
     * 使用filter_var方式验证
     * @access public
     * @param mixed $value 字段值
     * @param mixed $rule 验证规则
     * @return bool
     */
    private static function filter(mixed $value, mixed $rule): bool
    {
        if (is_string($rule) && strpos($rule, ',')) {
            list($rule, $param) = explode(',', $rule);
        } elseif (is_array($rule)) {
            $param = $rule[1] ?? null;
            $rule = $rule[0];
        } else {
            $param = null;
        }

        return false !== filter_var($value, is_int($rule) ? $rule : filter_id($rule), $param);
    }

    /**
     * 判断是否是邮箱
     * @param mixed $value
     * @return bool
     */
    public static function isEmail(mixed $value): bool
    {
        return self::filter($value, self::FILTER['email']);
    }

    /**
     * 判断是否是金额
     * @param float|int $value 金额
     * @param bool $zero 允许为0
     * @param bool $negative 允许为负数
     * @return bool
     */
    public static function isAmount(float|int $value, bool $zero = false, bool $negative = false): bool
    {
        // 必须是整数或浮点数，且允许为负
        if (!preg_match("/^-?\d+(.\d{1,2})?$/", (string)$value)) {
            return false;
        }
        // 不为 0
        if (!$zero && empty((int)($value * 100))) {
            return false;
        }
        // 不为负数
        if (!$negative && (int)($value * 100) < 0) {
            return false;
        }

        return true;
    }

    /**
     * 判断是否为空值
     * @param array|string $value 要判断的值
     * @return bool
     */
    public static function isEmpty(array|string $value): bool
    {
        if (empty($value)) {
            return true;
        }

        if (trim($value) === '') {
            return true;
        }

        return false;
    }

    /**
     * 验证输入的手机号码
     * @access  public
     * @param $mobile
     * @return bool
     */
    public static function isMobile($mobile): bool
    {
        // 正则表达式判断手机号
        if (preg_match('/^1[3-9][0-9]\d{8}$/', $mobile)) {
            return true;
        } else {
            return false;
        }
    }
}