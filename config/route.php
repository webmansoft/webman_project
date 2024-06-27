<?php

use Webman\Route;
use Webman\Exception\NotFoundException;

Route::group('/backend/login', function () {
    Route::get('/captcha', [app\backend\controller\LoginController::class, 'captcha']);
    Route::post('/login', [app\backend\controller\LoginController::class, 'login']);
});

Route::group('/backend/system', function () {
    Route::get('/test', [app\backend\controller\SystemController::class, 'test']);
    Route::get('/adminInfo', [app\backend\controller\SystemController::class, 'adminInfo']);
});

Route::fallback(function () {
    throw new NotFoundException('The requested resource was not found.');
});