<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use app\common\base\BaseApiController;
use app\common\logic\system\SystemConfigGroupLogic;
use app\common\validate\system\SystemConfigGroupValidate;

class SystemConfigGroupController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemConfigGroupLogic();
        $this->validate = new SystemConfigGroupValidate();
        $this->tree_list = true;
        $this->condition = Request()->formatInput([
            ['code'],
            'like' => ['name'],
        ]);
        parent::__construct();
    }
}