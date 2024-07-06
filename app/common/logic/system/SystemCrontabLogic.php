<?php
declare(strict_types=1);

namespace app\common\logic\system;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
use app\common\base\BaseLogic;
use app\common\model\system\SystemCrontabModel;
use app\common\model\system\SystemCrontabLogModel;

class SystemCrontabLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemCrontabModel();
        parent::__construct();
    }

    /**
     * 执行定时任务
     * @param $id
     * @return bool
     */
    public function run($id): bool
    {
        $info = $this->checkModel($id);
        $data['crontab_id'] = $info->getAttribute('id');
        $data['name'] = $info->getAttribute('name');
        $data['target'] = $info->getAttribute('target');
        $data['parameter'] = $info->getAttribute('parameter');
        switch ($info->getAttribute('type')) {
            case 1:
                // URL任务GET
                $httpClient = new Client([
                    'timeout' => 5,
                    'verify' => false,
                ]);
                try {
                    $httpClient->request('GET', $info->getAttribute('target'));
                    $data['status'] = 1;
                    SystemCrontabLogModel::create($data);
                    return true;
                } catch (GuzzleException $e) {
                    $data['status'] = 2;
                    $data['exception_info'] = $e->getMessage();
                    SystemCrontabLogModel::create($data);
                    return false;
                }
            case 2:
                // URL任务POST
                $httpClient = new Client([
                    'timeout' => 5,
                    'verify' => false,
                ]);
                try {
                    $res = $httpClient->request('POST', $info->getAttribute('target'), [
                        'form_params' => json_decode($info->getAttribute('parameter') ?? '', true)
                    ]);
                    $data['status'] = 1;
                    $data['exception_info'] = $res->getBody();
                    SystemCrontabLogModel::create($data);
                    return true;
                } catch (GuzzleException $e) {
                    $data['status'] = 2;
                    $data['exception_info'] = $e->getMessage();
                    SystemCrontabLogModel::create($data);
                    return false;
                }
            case 3:
                // 类任务
                $class_name = $info->getAttribute('target');
                $method_name = 'run';
                $class = new $class_name;
                if (method_exists($class, $method_name)) {
                    $return = $class->$method_name($info->getAttribute('parameter'));
                    $data['status'] = 1;
                    $data['exception_info'] = $return;
                    SystemCrontabLogModel::create($data);
                    return true;
                } else {
                    $data['status'] = 2;
                    $data['exception_info'] = '类:' . $class_name . ',方法:run,未找到';
                    SystemCrontabLogModel::create($data);
                    return false;
                }
            default:
                return false;
        }
    }
}