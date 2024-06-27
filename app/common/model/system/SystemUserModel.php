<?php
declare(strict_types=1);

namespace app\common\model\system;

use app\common\base\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class SystemUserModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'system_user';

    public function getBackendSettingAttr($value)
    {
        return json_decode($value ?? '', true);
    }

    public function setBackendSettingAttr($value): bool|string
    {
        return json_encode($value, JSON_UNESCAPED_UNICODE);
    }
//
//    /**
//     * 根据岗位id进行搜索
//     */
//    public function searchPostIdAttr($query, $value)
//    {
//        $query->join('eb_system_user_post post', 'eb_system_user.id = post.user_id')
//            ->where('post.post_id', $value);
//    }
//
//    /**
//     * 根据角色id进行搜索
//     */
//    public function searchRoleIdAttr($query, $value)
//    {
//        $query->whereRaw('id in (SELECT user_id FROM eb_system_user_role WHERE role_id =?)', [$value]);
//    }

    /**
     * 通过中间表关联角色
     */
    public function role(): BelongsToMany
    {
        return $this->belongsToMany(SystemRoleMenuModel::class, SystemUserRoleModel::class, 'user_id', 'role_id');
    }

    /**
     * 通过中间表关联岗位
     */
    public function post(): BelongsToMany
    {
        return $this->belongsToMany(SystemPostModel::class, SystemUserPostModel::class, 'user_id', 'post_id');
    }

    /**
     * 通过中间表关联部门
     */
    public function department(): BelongsTo
    {
        return $this->belongsTo(SystemDepartmentModel::class);
    }
}