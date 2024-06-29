<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use app\common\base\BaseApiController;
use app\common\logic\system\SystemConfigLogic;
use app\common\validate\system\SystemConfigValidate;

class SystemConfigController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemConfigLogic();
        $this->validate = new SystemConfigValidate;
        parent::__construct();
    }
}