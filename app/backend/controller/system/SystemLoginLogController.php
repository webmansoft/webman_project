<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemLoginLogLogic;

class SystemLoginLogController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemLoginLogLogic();
        $this->condition = Request()->formatInput([
            ['status', 'ip'],
            'like' => ['username'],
            'betweenDate' => ['login_time']
        ]);
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
     * 真实删除日志
     * @return Response
     */
    public function clearLog(): Response
    {
        $this->logic->clearLog();
        return $this->success();
    }
}