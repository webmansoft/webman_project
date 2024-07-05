<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Cache;
use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemConfigGroupLogic;
use app\common\validate\system\SystemConfigGroupValidate;

class SystemConfigGroupController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemConfigGroupLogic();
        $this->validate = new SystemConfigGroupValidate();
        parent::__construct();
    }

    /**
     * 数据列表
     * @param Request $request
     * @return Response
     */
    public function index(Request $request): Response
    {
        $condition = $request->formatInput([
            ['code'],
            'like' => ['name'],
        ]);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryAll($query);
        return $this->successData($data);
    }
}