<?php
declare(strict_types=1);

namespace app\backend\controller\system;

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
     * @return Response
     */
    public function getList(): Response
    {
        $condition = [
            ['ip'],
            'like' => ['username','router'],
            'betweenDate' => ['create_time']
        ];
        $query = $this->logic->search($condition);
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