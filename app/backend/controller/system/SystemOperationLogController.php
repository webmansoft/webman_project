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
        $this->condition_hidden = ['request_data', 'delete_time'];
        $this->condition = Request()->formatInput([
            ['ip'],
            'like' => ['username', 'router'],
            'betweenDate' => ['create_time']
        ]);
        parent::__construct();
    }

    /**
     * 获取我的操作日志
     * @return Response
     */
    public function getListByUsername(): Response
    {
        $query = $this->logic->equalSearch(['username' => $this->admin_name]);
        $data = $this->logic->getQueryList($query, $this->condition_hidden);
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