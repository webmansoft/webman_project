<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemPostLogic;

class SystemPostController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemPostLogic();
        parent::__construct();
    }

    /**
     * 数据列表
     * @param Request $request
     * @return Response
     */
    public function index(Request $request) : Response
    {
        $condition = $request->formatInput([
            ['status'],
            'like' => ['name','code'],
            'betweenDate' => ['create_time']
        ]);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }
}