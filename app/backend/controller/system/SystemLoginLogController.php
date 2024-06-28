<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use Webman\Http\Response;
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
     * 获取登录日志
     * @return Response
     */
    public function getLoginLogList(): Response
    {
        $query = $this->logic->search(['username' => $this->admin_name]);
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