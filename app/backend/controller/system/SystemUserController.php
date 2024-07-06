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
    public function __construct()
    {
        $this->logic = new SystemUserLogic();
        parent::__construct();
    }

    /**
     * 获取管理员信息
     * @return Response
     */
    public function getUserInfo(): Response
    {
        $logic = new SystemMenuLogic();
        $roleLogic = new SystemRoleLogic();
        $info['user'] = $this->admin;
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
     * 根据id获取管理员信息
     * @param Request $request
     * @return Response
     */
    public function getListByIds(Request $request): Response
    {
        $ids = $request->input('ids');
        if (empty($ids)) {
            return $this->fail('IDS 参数错误');
        }

        $data = $this->logic->inSearch(['id' => $ids], ['id', 'username', 'nickname', 'phone', 'email', 'create_time'])->get()->toArray();
        return $this->successData($data);
    }

    /**
     * 获取用户列表
     * @param Request $request
     * @return Response
     */
    public function getList(Request $request): Response
    {
        $condition = $request->formatInput([
            ['dept_id', 'role_id', 'post_id'],
            'like' => ['username', 'nickname', 'phone', 'email'],
        ]);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }

    /**
     * 更新资料
     * @param Request $request
     * @return Response
     */
    public function updateInfo(Request $request): Response
    {
        $data = $request->post();
        unset($data['deptList']);
        unset($data['postList']);
        unset($data['roleList']);
        $result = $this->logic->updateByWhere($data, ['id' => $this->admin_id], ['nickname', 'phone', 'email', 'avatar', 'backend_setting']);
        if ($result) {
            return $this->success();
        }

        return $this->fail();
    }

    /**
     * 修改密码
     * @param Request $request
     * @return Response
     */
    public function modifyPassword(Request $request): Response
    {
        $oldPassword = $request->input('oldPassword');
        $newPassword = $request->input('newPassword');
        $result = $this->logic->modifyPassword($this->admin_id, $oldPassword, $newPassword);
        if ($result) {
            return $this->success('修改成功');
        }

        return $this->fail();
    }

    /**
     * 更新用户缓存
     * @return Response
     */
    public function clearCache(): Response
    {
        return $this->success();
    }

    /**
     * 重置密码
     * @param Request $request
     * @return Response
     */
    public function initUserPassword(Request $request): Response
    {
        $id = intval($request->post('id', 0));
        if ($id === config('project.super_id')) {
            return $this->fail('超级管理员不允许重置密码');
        }

        $data = ['password' => password_hash('123456', PASSWORD_DEFAULT)];
        $result = $this->logic->updateByWhere($data, ['id' => $id]);
        if ($result) {
            return $this->success();
        }

        return $this->fail();
    }

    /**
     * 设置首页
     * @param Request $request
     * @return Response
     */
    public function setHomePage(Request $request): Response
    {
        $id = intval($request->post('id', 0));
        $dashboard = $request->post('dashboard', '');
        $data = ['dashboard' => $dashboard];
        $this->logic->updateByWhere($data, ['id' => $id]);
        return $this->success();
    }
}