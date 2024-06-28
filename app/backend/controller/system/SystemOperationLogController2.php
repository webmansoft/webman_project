<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use app\common\base\BaseApiController;
use app\common\logic\system\SystemLoginLogLogic;

class SystemOperationLogController2 extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemLoginLogLogic();
        parent::__construct();
    }
}