<?php
declare(strict_types=1);

namespace app\common\logic\system;

use support\Cache;
use app\common\base\BaseLogic;
use app\common\exception\ApiException;
use app\common\model\system\SystemConfigModel;

class SystemConfigLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemConfigModel();
        parent::__construct();
    }

    /**
     * 获取单项配置
     * @param string $key
     * @return array
     */
    public function getConfigByKey(string $key): array
    {
        $prefix = 'config_' . $key;
        $data = Cache::get($prefix);
        if ($data) {
            return $data;
        }

        $data = $this->checkModel($key, 'key')->toArray();
        Cache::set($prefix, $data);
        return $data;
    }

    /**
     * 获取配置组
     */
    public function getGroupByCode(string $code)
    {
        $prefix = 'config_group_' . $code;
        $data = Cache::get($prefix);
        if ($data) {
            return $data;
        }

        $group = (new SystemConfigGroupLogic)->findOne($code, 'code')->toArray();
        if ($group) {
            $data = $this->findAll(['group_id' => $group['id']])->toArray();
            // write_log($data, 'getGroupByCode data');
            Cache::set($prefix, $data);
            return $data;
        }

        throw new ApiException('配置组不存在');
    }
}