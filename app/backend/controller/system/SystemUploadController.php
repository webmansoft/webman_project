<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemUploadLogic;

class SystemUploadController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemUploadLogic();
        parent::__construct();
    }

    /**
     * 获取资源列表
     * @param Request $request
     * @return Response
     */
    public function getSystemUploadList(Request $request): Response
    {
        $condition = [
            ['mime_type', 'storage_mode'],
            'like' => ['origin_name']
        ];
        $where = $request->more($condition);
        $query = $this->logic->search($where);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }
}