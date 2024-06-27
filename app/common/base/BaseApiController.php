<?php
declare(strict_types=1);

namespace app\common\base;

use app\common\exception\ApiException;
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

        write_log($this->logic, 'logic');
        // 用户数据传递给逻辑层
        $this->logic && $this->logic->init($this->admin_id, $this->admin);
    }

    /**
     * 接口权限认证
     */
    protected function checkAuth(): void
    {

    }
}
