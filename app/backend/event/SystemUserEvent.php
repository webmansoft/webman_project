<?php
declare(strict_types=1);

namespace app\backend\event;

use app\common\library\OsHelper;
use app\common\library\ToolHelper;
use app\common\model\system\SystemMenuModel;
use app\common\model\system\SystemLoginLogModel;
use app\common\model\system\SystemOperationLogModel;

class SystemUserEvent
{
    public function login(array $item): void
    {
        $ip = request()->getRealIp();
        $http_user_agent = request()->header('user-agent');
        $data['username'] = $item['username'];
        $data['ip'] = $ip;
        $data['ip_location'] = ToolHelper::getIpLocation($ip);
        $data['os'] = OsHelper::getOs($http_user_agent);
        $data['browser'] = OsHelper::getBrowser($http_user_agent);
        $data['status'] = $item['status'];
        $data['message'] = $item['message'];
        $data['login_time'] = date('Y-m-d H:i:s');
        SystemLoginLogModel::create($data);
    }

    public function operation(): void
    {
        if (request()->method() === 'GET') {
            return;
        }
        $admin = get_jwt_user();
        $ip = request()->getRealIp();
        $module = request()->app;
        $rule = trim(strtolower(request()->uri()));
        $data['username'] = $admin['username'] ?? '';
        $data['method'] = request()->method();
        $data['router'] = $rule;
        $data['service_name'] = $this->getServiceName();
        $data['app'] = $module;
        $data['ip'] = $ip;
        $data['ip_location'] = ToolHelper::getIpLocation($ip);
        $data['request_data'] = $this->filterParams(request()->all());
        SystemOperationLogModel::create($data);
    }

    protected function getServiceName(): string
    {
        $path = request()->route->getPath();
        if (preg_match("/\{[^}]+}/", $path)) {
            $path = rtrim(preg_replace("/\{[^}]+}/", '', $path), '/');
        }

        $name = SystemMenuModel::where('code', $path)->value('name');
        return $name ?: '未知';
    }

    /**
     * 过滤字段
     */
    protected function filterParams(array $params): string
    {
        $blackList = ['password', 'oldPassword', 'newPassword', 'confirmPassword', 'old_password', 'new_password', 'confirm_password', 'content'];
        foreach ($params as $key => $value) {
            if (in_array($key, $blackList)) {
                $params[$key] = '******';
            }
        }

        return json_encode($params, JSON_UNESCAPED_UNICODE);
    }
}