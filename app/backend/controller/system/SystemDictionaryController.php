<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Cache;
use support\Request;
use support\Response;
use app\common\base\BaseApiController;

class SystemDictionaryController extends BaseApiController
{
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

        $logic = new SystemDictionaryLogic();
        $query = $logic->equalSearch(['status' => 1, 'code' => $code], ['id', 'label', 'value']);
        $data = $logic->getQueryAll($query);
        if ($data) {
            Cache::set($code, $data);
            return $this->successData($data);
        }

        return $this->success();
    }
}