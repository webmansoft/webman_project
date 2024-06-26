<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;

class SystemController extends BaseApiController
{
    public function test(Request $request): Response
    {
        return $this->success();
    }
}