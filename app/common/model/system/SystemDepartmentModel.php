<?php
declare(strict_types=1);

namespace app\common\model\system;

use app\common\base\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;

class SystemDepartmentModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'system_department';
}