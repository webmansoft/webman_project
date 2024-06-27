<?php

use Webman\Route;
use Webman\Exception\NotFoundException;

Route::group('/backend/login', function () {
    Route::get('/captcha', [app\backend\controller\LoginController::class, 'captcha']);
    Route::post('/login', [app\backend\controller\LoginController::class, 'login']);
});

Route::group('/backend/system', function () {
    Route::get('/test', [app\backend\controller\SystemController::class, 'test']);

    Route::get('/system/adminInfo', [app\backend\controller\SystemController::class, 'adminInfo']);
    Route::get('/system/dictData', [app\backend\controller\SystemController::class, 'dictData']);
    Route::get('/system/getResourceList', [app\backend\controller\SystemController::class, 'getResourceList']);
    Route::get('/system/clearAllCache', [app\backend\controller\SystemController::class, 'clearAllCache']);
});

Route::fallback(function () {
    throw new NotFoundException('The requested resource was not found.');
});