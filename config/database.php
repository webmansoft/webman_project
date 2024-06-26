<?php

return [
    // 默认数据库
    'default' => 'mysql',

    // 各种数据库配置
    'connections' => [
        'mysql' => [
            'driver' => 'mysql',
            'host' => env('DATABASE_HOSTNAME', '127.0.0.1'),
            'port' => env('DATABASE_HOSTPORT', 3306),
            'database' => env('DATABASE_DATABASE', 'webman_project'),
            'username' => env('DATABASE_USERNAME', 'root'),
            'password' => env('DATABASE_PASSWORD', 'root'),
            'unix_socket' => '',
            'charset' => env('DATABASE_CHARSET', 'utf8mb4'),
            'collation' => 'utf8mb4_unicode_ci',
            'prefix' => env('DATABASE_PREFIX', 'wp_'),
            'strict' => true,
            'engine' => null,
            'options' => [
                PDO::ATTR_TIMEOUT => 3
            ]
        ],
    ],
];