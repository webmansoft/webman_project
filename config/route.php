<?php

use Webman\Route;
use Webman\Exception\NotFoundException;

Route::group('/backend', function () {
    Route::get('/test', [app\backend\controller\SystemController::class, 'test']);
    Route::get('/clearAllCache', [app\backend\controller\SystemController::class, 'clearAllCache']);
});

Route::group('/backend/login', function () {
    Route::get('/captcha', [app\backend\controller\LoginController::class, 'captcha']);
    Route::post('/login', [app\backend\controller\LoginController::class, 'login']);
});

Route::group('/backend/system', function () {
    Route::get('/adminInfo', [app\backend\controller\system\SystemUserController::class, 'adminInfo']);
    Route::get('/getSystemUserList', [app\backend\controller\system\SystemUserController::class, 'getSystemUserList']);

    Route::get('/getDictionaryList', [app\backend\controller\system\SystemDictionaryController::class, 'getDictionaryList']);

    Route::get('/getSystemUploadList', [app\backend\controller\system\SystemUploadController::class, 'getSystemUploadList']);
});

Route::fallback(function () {
    throw new NotFoundException('The requested resource was not found.');
});