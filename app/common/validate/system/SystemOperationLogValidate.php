<?php
declare(strict_types=1);

namespace app\common\validate\system;

use app\common\base\BaseValidate;

class SystemOperationLogValidate extends BaseValidate
{
    /**
     * 定义验证规则
     */
    protected $rule = [
        'id' => 'require|number',
        'name' => 'require',
    ];

    /**
     * 定义错误信息
     */
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须为纯数字',

        'name.require' => '标题不能为空',
    ];

    /**
     * 定义场景
     */
    protected $scene = [
        'add' => [
            'name',
        ],
        'edit' => [
            'id',
            'name',
        ],
    ];
}