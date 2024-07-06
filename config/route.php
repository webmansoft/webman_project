<?php

use Webman\Route;
use Webman\Exception\NotFoundException;
use app\backend\controller\IndexController;
use app\backend\controller\LoginController;
use app\backend\controller\system\SystemPostController;
use app\backend\controller\system\SystemUserController;
use app\backend\controller\system\SystemUploadController;
use app\backend\controller\system\SystemNoticeController;
use app\backend\controller\system\SystemLoginLogController;
use app\backend\controller\system\SystemConfigController;
use app\backend\controller\system\SystemDictionaryController;
use app\backend\controller\system\SystemConfigGroupController;
use app\backend\controller\system\SystemOperationLogController;

Route::group('/backend', function () {
    // index
    Route::get('/index', [IndexController::class, 'index']);
    Route::get("/getServerInfo", [IndexController::class, 'getServerInfo']);
    Route::get('/clearCache', [IndexController::class, 'clearCache']);
    // login
    Route::get('/captcha', [LoginController::class, 'captcha']);
    Route::post('/login', [LoginController::class, 'login']);
});

// 系统用户
Route::group('/backend/admin', function () {
    Route::get('/getList', [SystemUserController::class, 'getList']);
    Route::get('/getUserInfo', [SystemUserController::class, 'getUserInfo']);
    Route::get('/getListByIds', [SystemUserController::class, 'getListByIds']);
    Route::post('/updateInfo', [SystemUserController::class, 'updateInfo']);
    Route::post('/modifyPassword', [SystemUserController::class, 'modifyPassword']);
    Route::post('/clearCache', [SystemUserController::class, 'clearCache']);
    Route::post('/initUserPassword', [SystemUserController::class, 'initUserPassword']);
    Route::post('/setHomePage', [SystemUserController::class, 'setHomePage']);
});

// 字典
fastRoute('backend/dictionary', SystemDictionaryController::class);
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
    Route::get('/getList', [SystemOperationLogController::class, 'getList']);
    Route::get('/getListByUsername', [SystemOperationLogController::class, 'getListByUsername']);
    Route::delete('/clearLog', [SystemOperationLogController::class, 'clearLog']);
});

// 系统公告
Route::group('/backend/notice', function () {
    Route::get('/getList', [SystemNoticeController::class, 'getList']);
    Route::get('/getRecycleList', [SystemNoticeController::class, 'getRecycleList']);
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

// 岗位
Route::group('/backend/post', function () {
//    Route::post('/downloadTemplate', [SystemPostController::class, 'downloadTemplate']);
});

// 配置
fastRoute('backend/config', SystemConfigController::class);
fastRoute('backend/configGroup', SystemConfigGroupController::class);
Route::group('/backend/config', function () {
    Route::post('/updateByKeys', [SystemConfigController::class, 'updateByKeys']);
});

// 字典
// fastRoute('backend/post', SystemPostController::class);
// fastRoute('backend/notice', SystemNoticeController::class);


Route::group('/tool', function () {
//    fastRoute('code', GenerateTablesController::class);
//    Route::post("/code/loadTable", [GenerateTablesController::class, 'loadTable']);
//    Route::get("/code/getTableColumns", [GenerateTablesController::class, 'getTableColumns']);
//    Route::get("/code/preview/{id}", [GenerateTablesController::class, 'preview']);
//    Route::post("/code/generate", [GenerateTablesController::class, 'generate']);
//    Route::post("/code/sync/{id}", [GenerateTablesController::class, 'sync']);
});

Route::fallback(function () {
    throw new NotFoundException('The requested resource was not found.');
});