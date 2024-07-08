<?php
declare(strict_types=1);

namespace app\common\model\system;

use app\common\base\BaseModel;

class SystemConfigModel extends BaseModel
{
    public $timestamps = false;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'system_config';

    public function getConfigSelectDataAttribute($value): array
    {
        return $this->getExtraAttr($value);
    }
}