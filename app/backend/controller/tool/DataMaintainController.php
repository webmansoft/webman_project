<?php
declare(strict_types=1);

namespace app\backend\controller\tool;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\tool\DataMaintainLogic;

class DataMaintainController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new DataMaintainLogic();
        parent::__construct();
    }

    /**
     * 数据列表
     * @param Request $request
     * @return Response
     */
    public function index(Request $request): Response
    {
        return $this->success();
    }

    public function source(): Response
    {
        $data = config('thinkorm.connections');
        $list = [];
        foreach ($data as $k => $v) {
            $list[] = $k;
        }

        return $this->success($list);
    }

    /**
     * 获取表字段信息
     * @param Request $request
     * @return Response
     */
    public function detail(Request $request): Response
    {
        $table = $request->input('table', '');
        return $this->success();
    }

    /**
     * 优化表
     * @param Request $request
     * @return Response
     */
    public function optimize(Request $request): Response
    {
        $tables = $request->input('tables', []);
        $this->logic->optimizeTable($tables);
        return $this->success('优化成功');
    }

    /**
     * 清理表碎片
     * @param Request $request
     * @return Response
     */
    public function fragment(Request $request): Response
    {
        $tables = $request->input('tables', []);
        $this->logic->fragmentTable($tables);
        return $this->success('清理成功');
    }
}