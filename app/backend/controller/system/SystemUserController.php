<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use app\common\library\ArrayHelper;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemMenuLogic;
use app\common\logic\system\SystemRoleLogic;
use app\common\logic\system\SystemUserLogic;

class SystemUserController extends BaseApiController
{
    /**
     * 获取管理员信息
     * @return Response
     */
    public function adminInfo(): Response
    {
        $logic = new SystemMenuLogic();
        $roleLogic = new SystemRoleLogic();
        $info['admin'] = $this->admin;
        if ($this->admin['id'] === config('project.super_id')) {
            $info['codes'] = ['*'];
            $info['roles'] = ['superAdmin'];
            $info['routers'] = $logic->getAllMenus();
        } else {
            $role_ids = ArrayHelper::getArrayColumn($this->admin['role_list'], 'id');
            $roles = $roleLogic->getMenuIdsByRoleIds($role_ids);
            $menu_ids = $logic->filterMenuIds($roles);
            $info['codes'] = $logic->getMenuCodeById($menu_ids);
            $info['roles'] = ArrayHelper::getArrayColumn($this->admin['role_list'], 'code');
            $info['routers'] = $logic->getRoutersByIds($menu_ids);
        }

        return $this->successData($info);
    }

    /**
     * 获取用户列表
     * @param Request $request
     * @return Response
     */
    public function getSystemUserList(Request $request): Response
    {
        $logic = new SystemUserLogic();
        $condition = [
            ['dept_id', 'role_id', 'post_id'],
            'like' => ['username', 'nickname', 'phone', 'email'],
        ];
        $where = $request->more($condition);
        $query = $logic->search($where);
        $data = $logic->getQueryList($query);
        return $this->successData($data);
    }
}