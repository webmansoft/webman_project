<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemOperationLogLogic;

class SystemOperationLogController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemOperationLogLogic();
        parent::__construct();
    }

    /**
     * 获取操作日志
     * @param Request $request
     * @return Response
     */
    public function index(Request $request): Response
    {
        $condition = $request->formatInput([
            ['ip'],
            'like' => ['username', 'router'],
            'betweenDate' => ['create_time']
        ]);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryList($query, ['request_data', 'delete_time']);
        return $this->successData($data);
    }

    /**
     * 获取我的操作日志
     * @return Response
     */
    public function getListByUsername(): Response
    {
        $query = $this->logic->equalSearch(['username' => $this->admin_name]);
        $data = $this->logic->getQueryList($query, ['request_data', 'delete_time']);
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