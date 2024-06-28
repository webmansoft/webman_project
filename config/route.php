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
    Route::get("/getServerInfo", [IndexController::class, 'getServerInfo']);
    Route::get('/clearCache', [IndexController::class, 'clearCache']);
});

Route::group('/backend/login', function () {
    Route::get('/captcha', [LoginController::class, 'captcha']);
    Route::post('/login', [LoginController::class, 'login']);
});

// 系统用户
Route::group('/backend/admin', function () {
    Route::get('/getList', [SystemUserController::class, 'getList']);
    Route::get('/getUserInfo', [SystemUserController::class, 'getUserInfo']);
    Route::post('/getListByIds', [SystemUserController::class, 'getListByIds']);
});

// 字典
Route::group('/backend/dictionary', function () {
    Route::get('/getList', [SystemDictionaryController::class, 'getList']);
});

// 登录日志
Route::group('/backend/loginLog', function () {
    Route::get('/getList', [SystemLoginLogController::class, 'getList']);
    Route::get('/getListByUsername', [SystemLoginLogController::class, 'getListByUsername']);
    Route::delete('/clearLog', [SystemLoginLogController::class, 'clearLog']);
});

// 操作日志
Route::group('/backend/operationLog', function () {
    Route::get('/getList', [SystemOperationLogController::class, 'getLogList']);
    Route::delete('/clearLog', [SystemOperationLogController::class, 'clearLog']);
});

// 上传
Route::group('/backend/upload', function () {
    Route::get('/getList', [SystemUploadController::class, 'getList']);
    Route::get('/downloadById/{id}', [SystemUploadController::class, 'downloadById']);
    Route::get('/downloadByHash/{hash}', [SystemUploadController::class, 'downloadByHash']);
    Route::get('/getUploadInfoById/{id}', [SystemUploadController::class, 'getUploadInfoById']);
    Route::get('/getUploadInfoByHash/{hash}', [SystemUploadController::class, 'getUploadInfoByHash']);
    Route::post('/saveNetworkImage', [SystemUploadController::class, 'saveNetworkImage']);
    Route::post('/uploadImage', [SystemUploadController::class, 'uploadImage']);
    Route::post('/uploadFile', [SystemUploadController::class, 'uploadFile']);
});

Route::fallback(function () {
    throw new NotFoundException('The requested resource was not found.');
});