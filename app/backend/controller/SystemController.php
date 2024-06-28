<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemUserLogicSearch;

class SystemController extends BaseApiController
{
    /**
     * 测试高级搜索
     * @param Request $request
     * @return Response
     */
    public function test(Request $request): Response
    {
        $logic = new SystemUserLogicSearch();
        list($total, $items) = $logic->select();
        return $this->successCount($items, $total);
    }

    /**
     * 清除缓存
     * @return Response
     */
    public function clearAllCache(): Response
    {
        return $this->success('清除缓存成功');
    }
}