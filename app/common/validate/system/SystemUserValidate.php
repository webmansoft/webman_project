<?php
/**
 * @desc SystemUserValidate
 * @date 2024/06/25 15:45:24
 */

declare(strict_types=1);

namespace app\common\validate\system;

use app\common\base\BaseValidate;
use app\common\service\CaptchaService;
use Webman\Exception\NotFoundException;

class SystemUserValidate extends BaseValidate
{
    /**
     * 定义验证规则
     */
    protected $rule = [
        'id' => 'require|number',
        'username' => 'require|min:5|max:20',
        'password' => 'require|min:6|max:32',
        'oldPassword' => 'require|min:6|max:32',
        'newPassword' => 'require|min:6|max:32',
        'confirmPassword' => 'require|confirm:newPassword',
        'role_id' => 'require',
        'phone' => 'mobile',
        'email' => 'email',
        // 登录
        'client' => 'require|in:WEB,MOBILE',
        'uuid' => 'require',
        'captcha' => 'require|alphaNum|length:4|checkCaptcha',
    ];

    /**
     * 定义错误信息
     */
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须为纯数字',
        'username.require' => '账号必须填写',
        'username.min' => '账号最少5个字符',
        'username.max' => '账号最多20个字符',
        'password.require' => '密码必须填写',
        'password.min' => '密码最少6个字符',
        'password.max' => '密码最多32个字符',
        'oldPassword.require' => '原密码必须填写',
        'oldPassword.min' => '原密码最少6个字符',
        'oldPassword.max' => '原密码最多32个字符',
        'newPassword.require' => '新密码必须填写',
        'newPassword.min' => '新密码最少6个字符',
        'newPassword.max' => '新密码最多32个字符',
        'confirmPassword.require' => '确认密码必须填写',
        'confirmPassword.confirm' => '两次输入密码不一致',
        'nickname.require' => '昵称必须填写',
        'email.email' => '邮箱格式错误',
        'phone.mobile' => '手机号格式错误',
        // 登录
        'client.require' => '客户端类型必须填写',
        'client.in' => '客户端类型范围错误',
        'uuid.require' => '唯一码不能为空',
        'captcha.require' => '验证码必须填写',
        'captcha.alphaNum' => '验证码必须字母和数字',
        'captcha.length' => '验证码长度必须为4',
    ];

    /**
     * 定义场景
     */
    protected $scene = [
        // 登录
        'login' => [
            'username',
            'password',
            'client',
            'uuid',
            'captcha'
        ],
    ];

    /**
     * 验证数据 / 验证规则 / 全部数据（数组）/ 字段名 / 字段描述
     * https://doc.thinkphp.cn/v8_0/validator.html
     * 检测验证码
     * @param string $captcha
     * @param string $rule
     * @param array $data
     * @return bool|string
     * @throws NotFoundException
     */
    protected function checkCaptcha(string $captcha, string $rule, array $data = []): bool|string
    {
        $service = CaptchaService::mk()->init();
        if ($service->verify($data['uuid'], $captcha)) {
            return true;
        } else {
            return '验证码验证失败';
        }
    }
}