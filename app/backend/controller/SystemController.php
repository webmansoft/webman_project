<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Cache;
use support\Request;
use support\Response;
use app\common\library\ArrayHelper;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemMenuLogic;
use app\common\logic\system\SystemRoleLogic;
use app\common\logic\system\SystemUploadLogic;
use app\common\logic\system\SystemDictDataLogic;
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
            $info['roles'] = ArrayHelper::getArrayColumn($this->admin['role_list'], 'code');
            $info['routers'] = $logic->getRoutersByIds($menu_ids);
        }

        return $this->successData($info);
    }

    /**
     * 数据字典
     */
    public function dictData(Request $request): Response
    {
        $code = $request->input('code');
        if (empty($code)) {
            return $this->fail('CODE 参数错误');
        }

        $data = Cache::get($code);
        if ($data) {
            return $this->successData($data);
        }

        $logic = new SystemDictDataLogic();
        $query = $logic->equalSearch(['status' => 1, 'code' => $code], ['id', 'label', 'value']);
        $data = $logic->getQueryAll($query);
        if ($data) {
            Cache::set($code, $data);
            return $this->successData($data);
        }

        return $this->success();
    }

    /**
     * 获取资源列表
     * @param Request $request
     * @return Response
     */
    public function getResourceList(Request $request): Response
    {
        $logic = new SystemUploadLogic();
        $where = $request->more([['mime_type', 'storage_mode'], 'like' => ['origin_name']]);
        $query = $logic->search($where);
        $data = $logic->getQueryPageList($query);
        return $this->successData($data);
    }

    /**
     * 清除缓存
     * @return Response
     */
    public function clearAllCache(): Response
    {
        return $this->success('清除缓存成功');
    }
}