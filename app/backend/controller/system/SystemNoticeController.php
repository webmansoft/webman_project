<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use app\common\base\BaseApiController;
use app\common\logic\system\SystemNoticeLogic;

class SystemNoticeController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemNoticeLogic();
        parent::__construct();
    }
}