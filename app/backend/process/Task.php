<?php
declare(strict_types=1);

namespace app\backend\process;

use Workerman\Crontab\Crontab;
use app\common\logic\system\SystemCrontabLogic;

class Task
{
    public function onWorkerStart(): void
    {
//        $logic = new SystemCrontabLogic();
//        $taskList = $logic->selectByWhere(['status' => 1]);
//        foreach ($taskList as $item) {
//            new Crontab($item['rule'], function () use ($logic, $item) {
//                $logic->run($item['id']);
//            });
//        }
    }

    public function run($args): string
    {
        echo '任务调用：' . date('Y-m-d H:i:s') . "\n";
        var_dump('参数:' . $args);
        return '任务调用：' . date('Y-m-d H:i:s') . "\n";
    }
}