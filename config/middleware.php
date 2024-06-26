<?php

return [
    '' => [
        app\common\middleware\AccessCross::class, // 跨域设置 不能注释
    ],
    'backend' => [
        app\backend\middleware\SystemToken::class,
    ],
    'frontend' => [

    ],
];