<?php
declare(strict_types=1);

namespace app\common\logic\system;

use Illuminate\Database\Eloquent\Builder;
use app\common\base\BaseLogic;
use app\common\model\system\SystemRoleMenuModel;

class SystemRoleMenuLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemRoleMenuModel();
    }
}