<?php
declare(strict_types=1);

namespace app\common\model\system;

use app\common\base\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class SystemRoleModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'system_role';

    /**
     * 通过中间表获取菜单
     */
    public function menu(): BelongsToMany
    {
        return $this->belongsToMany(SystemMenuModel::class, SystemRoleMenuModel::class, 'role_id', 'menu_id');
    }

    /**
     * 通过中间表获取部门
     */
    public function department(): BelongsToMany
    {
        return $this->belongsToMany(SystemDepartmentModel::class, SystemRoleDepartmentModel::class, 'role_id', 'department_id');
    }
}