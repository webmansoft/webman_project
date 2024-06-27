<?php
declare(strict_types=1);

namespace app\common\logic\system;

use Illuminate\Database\Eloquent\Builder;
use app\common\base\BaseLogic;
use app\common\model\system\SystemDictTypeModel;

class SystemDictTypeLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemDictTypeModel();
    }
}