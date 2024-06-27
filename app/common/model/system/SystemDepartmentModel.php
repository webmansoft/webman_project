<?php
declare(strict_types=1);

namespace app\common\model\system;

use app\common\base\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class SystemDepartmentModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'system_department';

    public function leader(): BelongsToMany
    {
        return $this->belongsToMany(SystemUserModel::class, SystemDepartmentModel::class, 'department_id', 'user_id');
    }
}