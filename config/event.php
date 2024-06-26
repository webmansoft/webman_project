<?php

use app\backend\event\SystemUserEvent;

return [
    'system.user.login' => [
        [SystemUserEvent::class, 'login'],
    ],
    'system.user.operation' => [
        [SystemUserEvent::class, 'operation'],
    ]
];