<?php
declare(strict_types=1);

namespace app\common\base;

use support\Model;
use app\common\library\StringHelper;
use app\common\library\DatetimeHelper;

abstract class BaseModel extends Model
{
    const DELETED_AT = 'delete_time';
    const UPDATED_AT = 'update_time';
    const CREATED_AT = 'create_time';

    protected $guarded = [];

    // 隐藏字段
    protected $hidden = [self::DELETED_AT];

    public function getCreatedAtAttribute($value): string
    {
        return DatetimeHelper::formatDatetime($value);
    }

    public function getUpdatedAtAttribute($value): string
    {
        return DatetimeHelper::formatDatetime($value);
    }

    public function getCreateTimeAttribute($value): string
    {
        return DatetimeHelper::formatDatetime($value);
    }

    public function getUpdateTimeAttribute($value): string
    {
        return DatetimeHelper::formatDatetime($value);
    }

    /**
     * 字段属性处理
     * @param mixed $value
     * @return string
     */
    public function setExtraAttr(mixed $value): string
    {
        return is_array($value) ? json_encode($value, JSON_UNESCAPED_UNICODE) : $value;
    }

    /**
     * 字段属性处理
     * @param mixed $value
     * @return array
     */
    public function getExtraAttr(mixed $value): array
    {
        return StringHelper::isJson($value) ? json_decode($value, true) : $value;
    }
}