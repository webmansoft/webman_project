<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\base\BaseController;
use app\common\service\CaptchaService;
use app\common\logic\system\SystemUserLogic;
use app\common\validate\system\SystemUserValidate;

class LoginController extends BaseController
{
    public function __construct()
    {
        $this->logic = new SystemUserLogic();
        $this->validate = new SystemUserValidate();
    }

    /**
     * 获取验证码
     * @return Response
     */
    public function captcha(): Response
    {
        return $this->successData((new CaptchaService())->getAttrs());
    }

    /**
     * 登录
     * @param Request $request
     * @return Response
     */
    public function login(Request $request): Response
    {
        $data = $request->post();
        if ($this->validate->scene('login')->check($data)) {
            $result = $this->logic->login($data['username'], $data['password'], strtoupper($data['client']));
            return $this->successData($result);
        } else {
            $error = strval($this->validate->getError());
            return $this->fail($error);
        }
    }
}