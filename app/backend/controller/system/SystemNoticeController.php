<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemNoticeLogic;

class SystemNoticeController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemNoticeLogic();
        parent::__construct();
    }

    /**
     * 获取系统公告
     * @param Request $request
     * @return Response
     */
    public function index(Request $request): Response
    {
        $condition = $request->formatInput([
            ['type'],
            'like' => ['title'],
            'betweenDate' => ['create_time']
        ]);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }

    public function getRecycleList(Request $request): Response
    {
        $condition = $request->formatInput([
            ['type'],
            'like' => ['title'],
            'betweenDate' => ['create_time']
        ]);
        return $this->recycle($condition);
    }
}