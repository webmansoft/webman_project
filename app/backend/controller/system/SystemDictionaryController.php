<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Cache;
use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemDictionaryLogic;

class SystemDictionaryController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemDictionaryLogic();
        parent::__construct();
    }

    /**
     * 获取字典列表
     * @param Request $request
     * @return Response
     */
    public function getDictionaryList(Request $request): Response
    {
        $code = $request->input('code');
        if (empty($code)) {
            return $this->fail('CODE 参数错误');
        }

        $data = Cache::get($code);
        if ($data) {
            return $this->successData($data);
        }

        $query = $this->logic->equalSearch(['status' => 1, 'code' => $code], ['id', 'label', 'value']);
        $data = $this->logic->getQueryAll($query);
        if ($data) {
            Cache::set($code, $data);
            return $this->successData($data);
        }

        return $this->success();
    }
}