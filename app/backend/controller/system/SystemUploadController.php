<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemUploadLogic;

class SystemUploadController extends BaseApiController
{
    /**
     * 获取资源列表
     * @param Request $request
     * @return Response
     */
    public function getSystemUploadList(Request $request): Response
    {
        $logic = new SystemUploadLogic();
        $condition = [
            ['mime_type', 'storage_mode'],
            'like' => ['origin_name']
        ];
        $where = $request->more($condition);
        $query = $logic->search($where);
        $data = $logic->getQueryList($query);
        return $this->successData($data);
    }
}