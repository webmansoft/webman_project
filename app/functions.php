<?php

use support\Log;
use support\Response;
use Webman\Route;
use Webmansoft\Jwt\JwtToken;
use Tinywan\Validate\Validate;
use app\common\exception\ApiException;

function version(): string
{
    if (config('app.debug', false)) {
        return date('YmdHis');
    } else {
        return config('project.version');
    }
}

function write_log(mixed $data, string $msg = 'write_log'): void
{
    $method = request()?->method();
    $type = gettype($data);
    if ($type === 'boolean') {
        $type = $type . ' = ' . (int)$data;
    }

    if (is_null($method)) {
        $log = [
            'msg' => $msg,
            'gettype' => $type,
            'data' => $data,
        ];
    } else {
        $method = strtolower($method);
        $log = [
            'method' => $method,
            'ip' => request()->getRealIp(),
            'url' => get_full_url(),
            'msg' => $msg,
            'gettype' => $type,
            'input' => $data,
            'request_params' => request()->{$method}(),
        ];
    }
    log::channel('debug')->debug(print_r($log, true));
}

function get_full_url(): string
{
    return (request()->getRemotePort() == 443 ? 'https:' : 'http:') . request()->fullUrl();
}

function check_redis(): void
{
    $result = extension_loaded('redis');
    if ($result === false) {
        throw new ApiException('请检查Redis配置');
    }
}

/**
 * 生成验证对象
 * @param array $data 数据
 * @param array|string $validate 验证器类名或者验证规则数组
 * @param array $message 错误提示信息
 * @param bool $batch 是否批量验证
 * @param bool $failException 是否抛出异常
 * @return bool
 */
function validate(array $data, array|string $validate = '', array $message = [], bool $batch = false, bool $failException = true): bool
{
    if (is_array($validate)) {
        $v = new Validate();
        $v->rule($validate);
    } else {
        if (strpos($validate, '.')) {
            [$validate, $scene] = explode('.', $validate);
        }
        $v = new $validate();
        if (!empty($scene)) {
            $v->scene($scene);
        }
    }

    return $v->message($message)->batch($batch)->failException($failException)->check($data);
}

/**
 * 获取当前登录用户
 */
function get_jwt_user(): bool|array
{
    if (request()) {
        $result = JwtToken::getExtend(false);
        if (isset($result['id']) && isset($result['username']) && $result['id'] && $result['username']) {
            return $result;
        }
    }

    return false;
}

/**
 * 下载模板
 * @param $file_name
 * @return Response
 */
function download_file($file_name): Response
{
    $base_dir = base_path() . '/extend/template';
    if (file_exists($base_dir . DIRECTORY_SEPARATOR . $file_name)) {
        return response()->download($base_dir . DIRECTORY_SEPARATOR . $file_name, urlencode($file_name));
    } else {
        throw new ApiException('模板不存在');
    }
}

/**
 * 快速注册路由 index|save|update|read|changeStatus|destroy|recycle|recovery|import|export
 * @param string $name
 * @param string $controller
 * @return void
 */
function fastRoute(string $name, string $controller): void
{
    $name = trim($name, '/');
    if (method_exists($controller, 'index')) Route::get("/$name/index", [$controller, 'index']);
    if (method_exists($controller, 'save')) Route::post("/$name/save", [$controller, 'save']);
    if (method_exists($controller, 'update')) Route::post("/$name/update", [$controller, 'update']);
    if (method_exists($controller, 'read')) Route::get("/$name/read/{id}", [$controller, 'read']);
    if (method_exists($controller, 'changeStatus')) Route::post("/$name/changeStatus", [$controller, 'changeStatus']);
    if (method_exists($controller, 'destroy')) Route::delete("/$name/destroy", [$controller, 'destroy']);
    if (method_exists($controller, 'recycle')) Route::get("/$name/recycle", [$controller, 'recycle']);
    if (method_exists($controller, 'realDestroy')) Route::delete("/$name/realDestroy", [$controller, 'realDestroy']);
    if (method_exists($controller, 'recovery')) Route::post("/$name/recovery", [$controller, 'recovery']);
    if (method_exists($controller, 'import')) Route::post("/$name/import", [$controller, 'import']);
    if (method_exists($controller, 'export')) Route::post("/$name/export", [$controller, 'export']);
}