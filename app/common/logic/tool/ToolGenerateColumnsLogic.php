<?php
declare(strict_types=1);

namespace app\common\logic\tool;

use app\common\base\BaseLogic;
use app\common\model\tool\ToolGenerateColumnsModel;

class ToolGenerateColumnsLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new ToolGenerateColumnsModel();
    }
}