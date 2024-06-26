<?php
declare(strict_types=1);

namespace app\common\logic\system;

use app\common\base\LogicSearch;
use app\common\model\system\SystemUserModel;

class SystemUserLogicSearch extends LogicSearch
{
    public function __construct()
    {
        $this->model = new SystemUserModel();
        parent::__construct();
    }
}