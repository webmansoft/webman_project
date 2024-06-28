<?php

use Webman\Route;
use Webman\Exception\NotFoundException;
use app\backend\controller\IndexController;
use app\backend\controller\LoginController;
use app\backend\controller\system\SystemUserController;
use app\backend\controller\system\SystemUploadController;
use app\backend\controller\system\SystemLoginLogController;
use app\backend\controller\system\SystemDictionaryController;
use app\backend\controller\system\SystemOperationLogController;

Route::group('/backend', function () {
    Route::get('/index', [IndexController::class, 'index']);
    Route::get("/getServerInfo",[IndexController::class, 'getServerInfo']);
    Route::get('/clearCache', [IndexController::class, 'clearCache']);
});

Route::group('/backend/login', function () {
    Route::get('/captcha', [LoginController::class, 'captcha']);
    Route::post('/login', [LoginController::class, 'login']);
});

Route::group('/backend/system', function () {
    // 系统用户
    Route::get('/getAdminInfo', [SystemUserController::class, 'getAdminInfo']);
    Route::get('/getUserList', [SystemUserController::class, 'getUserList']);
    // 字典
    Route::get('/getDictionaryList', [SystemDictionaryController::class, 'getDictionaryList']);
    // 登录日志
    Route::get('/getLoginLogList', [SystemLoginLogController::class, 'getLoginLogList']);
    // 操作日志
    Route::get('/getOperationLogList', [SystemOperationLogController::class, 'getOperationLogList']);
    // 上传
    Route::get('/downloadById/{id}', [SystemUploadController::class, 'downloadById']);
    Route::get('/downloadByHash/{hash}', [SystemUploadController::class, 'downloadByHash']);
    Route::get('/getUploadInfoById/{id}', [SystemUploadController::class, 'getUploadInfoById']);
    Route::get('/getUploadInfoByHash/{hash}', [SystemUploadController::class, 'getUploadInfoByHash']);
    Route::get('/getUploadList', [SystemUploadController::class, 'getUploadList']);
    Route::post('/saveNetworkImage', [SystemUploadController::class, 'saveNetworkImage']);
    Route::post('/uploadImage', [SystemUploadController::class, 'uploadImage']);
    Route::post('/uploadFile', [SystemUploadController::class, 'uploadFile']);
});

Route::fallback(function () {
    throw new NotFoundException('The requested resource was not found.');
});