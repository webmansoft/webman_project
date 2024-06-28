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
        $where = $request->equal(['table_name']);
        $query = $this->logic->search($where);
        $data = $this->logic->getQueryList($query);
        return $this->success($data);
    }

    /**
     * 修改数据
     * @param Request $request
     * @return Response
     */
    public function update(Request $request): Response
    {
        $data = $request->post();
        if ($this->validate) {
            if ($this->validate->scene('update')->check($data) === false) {
                return $this->fail($this->validate->getError());
            }
        }

        $this->logic->updateTableAndColumns($data);
        return $this->success();
    }

    /**
     * 装载数据表
     * @param Request $request
     * @return Response
     */
    public function loadTable(Request $request): Response
    {
        $names = $request->input('names', []);
        $source = $request->input('source', '');
        $this->logic->loadTable($names, $source);
        return $this->success();
    }

    /**
     * 同步数据表字段信息
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function sync(Request $request,int $id): Response
    {
        $this->logic->sync($id);
        return $this->success();
    }

    /**
     * 代码预览
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function preview(Request $request, int $id): Response
    {
        $data = $this->logic->preview($id);
        return $this->success($data);
    }

    /**
     * 代码生成
     * @param Request $request
     * @return Response
     */
    public function generate(Request $request): Response
    {
        $ids = $request->input('ids', '');
        $data = $this->logic->generate($ids);
        return response()->download($data['download'], $data['filename']);
    }

    /**
     * 获取数据表字段信息
     * @param Request $request
     * @return Response
     */
    public function getTableColumns(Request $request): Response
    {
        $table_id = $request->input('table_id', '');
        $data = $this->logic->getTableColumns($table_id);
        return $this->success($data);
    }

}