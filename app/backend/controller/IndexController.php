<?php
declare(strict_types=1);

namespace app\backend\controller;

use support\Request;
use support\Response;
use app\common\library\OsHelper;
use app\common\base\BaseController;

class IndexController extends BaseController
{
    public function index(Request $request): Response
    {
        return $this->success('index');
    }

    /**
     * 获取服务器信息
     * @return Response
     */
    public function getServerInfo() : Response
    {
        return $this->successData([
            'cpu' => OsHelper::getCpuInfo(),
            'memory' => OsHelper::getMemInfo(),
            'php' => OsHelper::getPhpAndEnvInfo(),
        ]);
    }

    /**
     * 清除缓存
     * @return Response
     */
    public function clearCache(): Response
    {
        return $this->success('清除缓存成功');
    }
}
