<?php

use support\Request;

return [
    'debug' => boolval(env('APP_DEBUG', false)),
    'error_reporting' => E_ALL,
    'default_timezone' => 'Asia/Shanghai',
    'request_class' => Request::class,
    'public_path' => base_path('public'),
    'runtime_path' => base_path('runtime'),
    'controller_suffix' => 'Controller',
    'controller_reuse' => false,
];