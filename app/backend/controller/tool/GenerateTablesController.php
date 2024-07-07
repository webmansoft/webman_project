<?php
declare(strict_types=1);

namespace app\backend\controller\tool;

use app\common\base\BaseApiController;
use app\common\logic\tool\ToolGenerateTablesLogic;
use app\common\validate\tool\ToolGenerateTablesValidate;

class GenerateTablesController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new ToolGenerateTablesLogic;
        $this->validate = new ToolGenerateTablesValidate;
        $this->condition = Request()->inputEqual(['table_name']);
        parent::__construct();
    }
}