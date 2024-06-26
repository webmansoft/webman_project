<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemUserLogicSearch;

class SystemController extends BaseApiController
{
    public function test(Request $request): Response
    {
        $logic = new SystemUserLogicSearch();
        list($total, $items) = $logic->select();
        return $this->successCount($items, $total);
    }
}