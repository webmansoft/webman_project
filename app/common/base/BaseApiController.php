<?php
declare(strict_types=1);

namespace app\common\base;

use support\Request;
use support\Response;
use app\common\library\ArrayHelper;
use app\common\exception\ApiException;
use app\common\logic\system\SystemMenuLogic;
use app\common\logic\system\SystemRoleLogic;
use app\common\logic\system\SystemUserLogic;

abstract class BaseApiController extends BaseController
{
    /**
     * 当前用户信息
     */
    protected array $admin;

    /**
     * 当前用户编号
     */
    protected int $admin_id = 0;

    /**
     * 当前用户账号
     */
    protected string $admin_name = '';

    /**
     * 构造方法
     */
    public function __construct()
    {
        $this->init();
    }

    /**
     * 控制器初始化
     */
    protected function init(): void
    {
        $result = get_jwt_user();
        if ($result) {
            $this->admin_id = $result['id'];
            $this->admin_name = $result['username'];
            $this->admin = (new SystemUserLogic)->read($this->admin_id);
        } else {
            throw new ApiException('当前用户信息读取失败,请重新登录');
        }

        // 接口权限认证
        $server_auth = config('project.server_auth', true);
        if ($server_auth) {
            $this->admin_id > config('project.super_id') && $this->checkAuth();
        }

        // 用户数据传递给逻辑层
        $this->logic && $this->logic->init($this->admin_id, $this->admin);
    }

    /**
     * 接口权限认证
     */
    protected function checkAuth(): void
    {
        // 接口请求权限判断
        $path = request()->route?->getPath();
        if ($path && preg_match("/\{[^}]+}/", $path)) {
            $path = rtrim(preg_replace("/\{[^}]+}/", '', $path), '/');
            $logic = new SystemMenuLogic();
            $routes = $logic->getAllCode();
            if (in_array($path, $routes)) {
                // 请求接口有权限配置则进行验证
                $role_ids = ArrayHelper::getArrayColumn($this->admin['role_list'], 'id');
                $roleLogic = new SystemRoleLogic();
                $roles = $roleLogic->getMenuIdsByRoleIds($role_ids);
                $menu_ids = $logic->filterMenuIds($roles);
                $allow_codes = $logic->getMenuCodeById($menu_ids);
                if (!in_array($path, $allow_codes)) {
                    throw new ApiException('您没有权限进行访问');
                }
            }
        }
    }

    /**
     * 保存数据
     * @param Request $request
     * @return Response
     */
    public function save(Request $request): Response
    {
        $data = $request->post();
        if ($this->validate) {
            if ($this->validate->scene('save')->check($data) === false) {
                return $this->fail($this->validate->getError());
            }
        }

        $result = $this->logic->insert($data);
        if ($result) {
            $this->afterChange('save');
            return $this->success();
        } else {
            return $this->fail();
        }
    }

    /**
     * 更新数据
     * @param Request $request
     * @return Response
     */
    public function update(Request $request): Response
    {
        $data = $request->post();
        if ($this->validate) {
            if ($this->validate->scene('update')->check($data) === false) {
                return $this->fail($this->validate->getError());
            }
        }

        $result = $this->logic->update($data);
        if ($result) {
            $this->afterChange('update');
            return $this->success();
        } else {
            return $this->fail();
        }
    }

    /**
     * 更新状态
     * @param Request $request
     * @return Response
     */
    public function changeStatus(Request $request): Response
    {
        $data = $request->post();
        if ($this->validate->scene('changeStatus')->check($data) === false) {
            return $this->fail($this->validate->getError());
        }

        $result = $this->logic->update($data);
        if ($result) {
            $this->afterChange('changeStatus');
            return $this->success();
        } else {
            return $this->fail();
        }
    }

    /**
     * 删除数据
     * @param Request $request
     * @return Response
     */
    public function destroy(Request $request): Response
    {
        $this->logic->delete();
        $this->afterChange('destroy');
        return $this->success();
    }

    /**
     * 读取信息
     * @param int|string $id
     * @return Response
     */
    public function read(int|string $id): Response
    {
        $data = $this->logic->checkModel($id)->toArray();
        return $this->successData($data);
    }

    /**
     * 回收站数据
     * @param Request $request
     * @return Response
     */
    public function recycle(Request $request): Response
    {
        $where = $request->more(['betweenDate' => ['create_time'], 'null' => ['delete_time']]);
        $query = $this->logic->search($where);
        $data = $this->logic->getQueryList($query);
        return $this->success($data);
    }

    /**
     * 恢复数据
     * @param Request $request
     * @return Response
     */
    public function recovery(Request $request): Response
    {
        $this->logic->restore();
        $this->afterChange('recovery');
        return $this->success();
    }

    /**
     * 数据销毁-真实删除
     * @param Request $request
     * @return Response
     */
    public function realDestroy(Request $request): Response
    {
        $this->logic->forceDelete();
        $this->afterChange('realDestroy');
        return $this->success();
    }

    /**
     * 数据改变后执行
     * @return void
     */
    public function afterChange($type)
    {
        // todo
    }
}
