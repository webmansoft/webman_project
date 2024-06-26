<?php
declare(strict_types=1);

namespace app\common\logic\system;

use app\common\base\BaseLogic;
use app\common\model\system\SystemDepartmentLeaderModel;

class SystemDepartmentLeaderLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemDepartmentLeaderModel();
        parent::__construct();
    }
}