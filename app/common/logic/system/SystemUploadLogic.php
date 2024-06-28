<?php
declare(strict_types=1);

namespace app\common\logic\system;

use app\common\base\BaseLogic;
use app\common\model\system\SystemUploadModel;

class SystemUploadLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemUploadModel();
    }
}