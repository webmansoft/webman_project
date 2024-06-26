<?php
/**
 * @desc SystemOperLogLogic
 * @date 2024/06/25 16:16:37
 */

declare(strict_types=1);

namespace app\common\logic\system;

use app\common\base\BaseLogic;
use app\common\model\system\SystemOperationLogModel;

class SystemOperationLogLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemOperationLogModel();
    }
}