<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use Tinywan\Storage\Storage;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemUploadLogic;

class SystemUploadController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemUploadLogic();
        parent::__construct();
    }

    /**
     * 获取资源列表
     * @param Request $request
     * @return Response
     */
    public function getUploadList(Request $request): Response
    {
        $condition = [
            ['mime_type', 'storage_mode'],
            'like' => ['origin_name']
        ];
        $where = $request->more($condition);
        $query = $this->logic->search($where);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }

    /**
     * 下载网络图片
     * @param Request $request
     * @return Response
     */
    public function saveNetworkImage(Request $request): Response
    {
        $url = trim($request->input('url', ''));
        if ($url) {
            $config = Storage::getConfig('local');
            $logic = new SystemUploadLogic();
            $data = $logic->saveNetworkImage($url, $config);
            return $this->successData($data);
        }

        return $this->fail('URL 参数错误');
    }

    /**
     * 上传图片
     * @param Request $request
     * @return Response
     */
    public function uploadImage(Request $request): Response
    {
        $type = $request->input('mode', 'local');
        if ($type == 'local') {
            return $this->successData($this->logic->uploadBase('image', true));
        }

        return $this->successData($this->logic->uploadBase());
    }

    /**
     * 上传文件
     * @param Request $request
     * @return Response
     */
    public function uploadFile(Request $request): Response
    {
        $type = $request->input('mode', 'local');
        if ($type == 'local') {
            return $this->successData($this->logic->uploadBase('file', true));
        }

        return $this->successData($this->logic->uploadBase('file'));
    }

    /**
     * 根据id下载资源
     * @param int|string $id
     * @return Response
     */
    public function downloadById(int|string $id): Response
    {
        $model = $this->logic->checkModel($id)->toArray();
        return response()->download($model['storage_path'], $model['object_name']);
    }

    /**
     * 根据hash下载资源
     * @param string $hash
     * @return Response
     */
    public function downloadByHash(string $hash): Response
    {
        $model = $this->logic->checkModel($hash, 'hash')->toArray();
        return response()->download($model['storage_path'], $model['object_name']);
    }

    /**
     * 根据id获取文件信息
     * @param int|string $id
     * @return Response
     */
    public function getUploadInfoById(int|string $id): Response
    {
        $model = $this->logic->checkModel($id)->toArray();
        return $this->successData($model);
    }

    /**
     * 根据hash获取文件信息
     * @param string $hash
     * @return Response
     */
    public function getUploadInfoByHash(string $hash): Response
    {
        $model = $this->logic->checkModel($hash, 'hash')->toArray();
        return $this->successData($model);
    }
}