<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use app\common\base\BaseApiController;
use app\common\logic\system\SystemPostLogic;

class SystemPostController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemPostLogic();
        parent::__construct();
    }
}