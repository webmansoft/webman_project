<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\base\BaseController;

class IndexController extends BaseController
{
    public function index(Request $request): Response
    {
        return $this->success();
    }
}
