<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Cache;
use support\Request;
use support\Response;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemConfigLogic;
use app\common\logic\system\SystemConfigGroupLogic;
use app\common\validate\system\SystemConfigValidate;

class SystemConfigController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemConfigLogic();
        $this->validate = new SystemConfigValidate;
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
            ['group_id', 'key'],
            'like' => ['name'],
        ]);
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryAll($query);
        return $this->successData($data);
    }

    /**
     * 根据key值修改配置项
     * @param Request $request
     * @return Response
     */
    public function updateByKeys(Request $request): Response
    {
        $data = $request->post();
        $group = '';
        foreach ($data as $key => $value) {
            $group = $key;
            $update = ['value' => is_array($value) ? json_encode($value, JSON_UNESCAPED_UNICODE) : $value];
            $this->logic->updateByWhere($update, ['key' => $key]);
            Cache::delete('config_' . $key);
        }

        if ($group != '') {
            $model = $this->logic->checkModel($group, 'key')->toArray();
            $group_model = (new SystemConfigGroupLogic())->findOne($model['group_id'])->toArray();
            if ($group_model) {
                Cache::delete('config_group_' . $group_model['code']);
            }
        }

        return $this->success();
    }
}