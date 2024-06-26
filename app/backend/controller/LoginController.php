<?php
declare (strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use Webman\Exception\NotFoundException;
use app\common\base\BaseController;
use app\common\logic\system\SystemUserLogic;
use app\common\validate\system\SystemUserValidate;

class LoginController extends BaseController
{
    public function __construct()
    {
        $this->logic = new SystemUserLogic();
        $this->validate = new SystemUserValidate();
        parent::__construct();
    }

    /**
     * 获取验证码
     * @param Request $request
     * @return Response
     * @throws NotFoundException
     */
    public function captcha(Request $request): Response
    {
        return $this->getCaptcha();
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
            $result = $this->logic->login($data['username'], $data['password'], $data['client']);
            return $this->successData($result);
        } else {
            $error = strval($this->validate->getError());
            return $this->fail($error);
        }
    }
}