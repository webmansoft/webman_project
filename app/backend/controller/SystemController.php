<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\library\ArrayHelper;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemMenuLogic;
use app\common\logic\system\SystemRoleLogic;
use app\common\logic\system\SystemUserLogicSearch;

class SystemController extends BaseApiController
{
    public function test(Request $request): Response
    {
        $logic = new SystemUserLogicSearch();
        list($total, $items) = $logic->select();
        return $this->successCount($items, $total);
    }

    /**
     * 用户信息
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
            $info['roles'] = ArrayHelper::getArrayColumn($this->admin['role_list'],'code');
            $info['routers'] = $logic->getRoutersByIds($menu_ids);
        }

        return $this->successData($info);
    }
}