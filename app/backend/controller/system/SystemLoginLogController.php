<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemLoginLogLogic;

class SystemLoginLogController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemLoginLogLogic();
        parent::__construct();
    }

    /**
     * 获取我的登录日志
     * @return Response
     */
    public function getListByUsername(): Response
    {
        $query = $this->logic->equalSearch(['username' => $this->admin_name]);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }

    /**
     * 获取登录日志
     * @param Request $request
     * @return Response
     */
    public function getList(Request $request): Response
    {
        $condition = $request->formatInput([
            ['status', 'ip'],
            'like' => ['username'],
            'betweenDate' => ['login_time']
        ]);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }

    /**
     * 真实删除日志
     * @return Response
     */
    public function clearLog(): Response
    {
        $this->logic->clearLog();
        return $this->success();
    }
}