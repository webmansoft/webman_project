<?php
declare(strict_types=1);

namespace app\common\logic\system;

use Webman\Event\Event;
use Webmansoft\Jwt\JwtToken;
use app\common\base\BaseLogic;
use app\common\exception\ApiException;
use app\common\model\system\SystemUserModel;

class SystemUserLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemUserModel();
        parent::__construct();
    }

    public function read(int|string $id): array
    {
        $admin = $this->model->find($id);
        $hidden = ['password', 'created_by', 'updated_by', $this->model::CREATED_AT, $this->model::UPDATED_AT];
        $data = $admin->makeHidden($hidden)->toArray();
        $data['role_list'] = $admin->getAttribute('role')?->toArray() ?? [];
        $data['post_list'] = $admin->getAttribute('post')?->toArray() ?? [];
        $data['department_list'] = $admin->getAttribute('department')?->toArray() ?? [];
        return $data;
    }

    /**
     * 用户登录
     * @param string $username
     * @param string $password
     * @param string $client
     * @return array
     */
    public function login(string $username, string $password, string $client = JwtToken::TOKEN_CLIENT_WEB): array
    {
        $status = 1;
        $message = '登录成功';
        $admin = $this->model->where('username', $username)->first();
        if (empty($admin)) {
            $message = '账号或密码错误';
            throw new ApiException($message);
        }

        if ($admin['status'] === 2) {
            $status = 0;
            $message = '您已被禁止登录';
        }

        if (!password_verify($password, $admin['password'])) {
            $status = 0;
            $message = '账号或密码错误';
        }

        if ($status === 0) {
            // 登录事件
            Event::emit('system.user.login', compact('username', 'status', 'message', 'client'));
            throw new ApiException($message);
        }

        $admin->login_time = date('Y-m-d H:i:s');
        $admin->login_ip = request()->getRealIp();
        $admin->save();
        // 登录事件
        Event::emit('system.user.login', compact('username', 'status', 'message', 'client'));
        return $this->getToken($admin->id, $username, $client);
    }
}