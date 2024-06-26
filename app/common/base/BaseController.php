<?php
declare(strict_types=1);

namespace app\common\base;

use support\Response;
use Tinywan\Validate\Validate;
use Webman\Exception\NotFoundException;
use app\common\service\CaptchaService;

abstract class BaseController
{
    /**
     * 逻辑层注入
     */
    protected object $logic;

    /**
     * 验证器注入
     */
    protected Validate $validate;

    /**
     * 构造方法
     */
    public function __construct()
    {

    }

    /**
     * 返回格式化json数据
     * @param int $code
     * @param mixed $message
     * @param mixed $data
     * @param int $count
     * @param bool $isCount
     * @return Response
     */
    protected function json(int $code, mixed $message = '', mixed $data = '', int $count = 0, bool $isCount = false): Response
    {
        $result = ['code' => $code, 'message' => $message, 'data' => $data];
        if ($isCount) {
            $result['count'] = $count;
        }

        return json($result);
    }

    protected function successCount(mixed $data, int $count, mixed $message = '操作成功', int $code = 0): Response
    {
        return $this->json($code, $message, $data, $count, true);
    }

    protected function successData(mixed $data, mixed $message = '操作成功', int $code = 0): Response
    {
        return $this->json($code, $message, $data);
    }

    protected function success(mixed $message = '操作成功', mixed $data = '', int $code = 0): Response
    {
        return $this->json($code, $message, $data);
    }

    protected function successReload(mixed $message = '操作成功'): Response
    {
        return $this->successData('javascript:top.location.reload();', $message);
    }

    protected function fail(mixed $message = '操作失败', int $code = 1): Response
    {
        return $this->json($code, $message);
    }

    /**
     * 获取验证码
     * @return Response
     * @throws NotFoundException
     */
    protected function getCaptcha(): Response
    {
        $captcha = CaptchaService::mk()->init();
        return $this->successData($captcha->getAttrs());
    }
}