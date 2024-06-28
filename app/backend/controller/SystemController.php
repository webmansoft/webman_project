<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;

class SystemController extends BaseApiController
{
    /**
     * 清除缓存
     * @return Response
     */
    public function clearAllCache(): Response
    {
        return $this->success('清除缓存成功');
    }
}