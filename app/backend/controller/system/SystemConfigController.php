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
        $this->tree_list = true;
        $this->condition = Request()->formatInput([
            ['group_id', 'key'],
            'like' => ['name'],
        ]);
        parent::__construct();
    }

    /**
     * 根据key值修改配置项
     * @param Request $request
     * @return Response
     */
    public function updateByKeys(Request $request): Response
    {
        $data = $request->post();
        $last_key = '';
        foreach ($data as $key => $value) {
            $last_key = $key;
            $update_data = ['value' => is_array($value) ? json_encode($value, JSON_UNESCAPED_UNICODE) : $value];
            $this->logic->updateByWhere($update_data, ['key' => $key]);
            Cache::delete('config_' . $key);
        }

        if ($last_key) {
            $config = $this->logic->checkModel($last_key, 'key')->toArray();
            $config_group = (new SystemConfigGroupLogic())->findOne($config['group_id'])->toArray();
            if ($config_group) {
                Cache::delete('config_group_' . $config_group['code']);
            }
        }

        return $this->success();
    }
}