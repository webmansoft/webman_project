<?php
declare(strict_types=1);

namespace app\backend\controller\tool;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\tool\ToolGenerateTablesLogic;
use app\common\validate\tool\ToolGenerateTablesValidate;

class GenerateTablesController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new ToolGenerateTablesLogic;
        $this->validate = new ToolGenerateTablesValidate;
        parent::__construct();
    }

    /**
     * 数据列表
     * @param Request $request
     * @return Response
     */
    public function index(Request $request): Response
    {
        $condition = $request->inputEqual(['table_name']);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }
}