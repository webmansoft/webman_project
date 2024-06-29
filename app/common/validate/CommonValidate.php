<?php
declare(strict_types=1);

namespace app\common\validate;

use app\common\base\BaseValidate;

class CommonValidate extends BaseValidate
{
    /**
     * 定义验证规则
     */
    protected $rule = [
        'id' => 'require',
        'status' => 'require|in:1,2',
        'is_default' => 'require|in:1,2',
        'action' => 'require|same:sort',
        'sort' => 'require|number',
        'origin_name' => 'require',
    ];

    /**
     * 定义错误信息
     */
    protected $message = [
        'id.require' => '主键不能为空',

        'status.require' => '状态值不能为空',
        'status.in' => '状态值范围异常',

        'is_default.require' => '默认状态值不能为空',
        'is_default.in' => '默认状态值范围异常',

        'action.require' => '排序字段名不能为空',
        'action.same' => '排序字段名异常',
        'sort.require' => '排序字段值不能为空',
        'sort.number' => '排序字段值必须为数字',

        'origin_name.require' => '上传文件名称不能为空',
    ];

    /**
     * 定义场景
     */
    protected $scene = [
        'changeStatus' => [
            'id',
            'status'
        ],
        'default' => [
            'id',
            'is_default'
        ],
        'sort' => [
            'id',
            'action',
            'sort',
        ],
    ];
}