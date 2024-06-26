<?php

return [
    // 应用版本
    'version' => '1.0.0',

    // 后端是否开启验证
    'server_auth' => true,

    // 超级管理员编号
    'super_id' => 1,

    // 验证码存储模式
    'captcha' => [
        // 开启debug
        'debug' => boolval(env('CAPTCHA_DEBUG', false)),
        // 验证码
        'value' => 'abcd',
        // 验证码存储模式 session或者redis
        'mode' => 'redis',
        // 缓存前缀
        'prefix' => 'captcha_',
        // 验证码过期时间(秒) 默认300
        'expire' => 300,
    ],

    // 路由白名单
    'white_list' => [
        '/backend/login/captcha',
        '/backend/login/login',
    ],

    // 接口限速
    'limit' => [
        'limit' => 10, // 请求次数
        'window_time' => 60, // 窗口时间，单位：秒
        'body' => 'Too Many Requests' // 响应信息
    ]
];