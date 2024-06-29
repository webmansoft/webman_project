<?php
declare(strict_types=1);

namespace app\common\logic\system;

use app\common\base\BaseLogic;
use app\common\library\ToolHelper;
use app\common\library\ArrayHelper;
use app\common\service\UploadService;
use app\common\exception\ApiException;
use app\common\model\system\SystemUploadModel;

class SystemUploadLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemUploadModel();
        parent::__construct();
    }

    /**
     * 保存网络图片
     * @param string $url
     * @param array $config
     * @return array
     */
    public function saveNetworkImage(string $url, array $config): array
    {
        $image_data = file_get_contents($url);
        if ($image_data === false) {
            throw new ApiException('获取文件资源失败');
        }

        $image_resource = imagecreatefromstring($image_data);
        if (!$image_resource) {
            throw new ApiException('创建图片资源失败');
        }

        $filename = basename($url);
        $file_extension = pathinfo($filename, PATHINFO_EXTENSION);
        $full_dir = runtime_path() . '/resource/';
        if (!is_dir($full_dir)) {
            @mkdir($full_dir, 0777, true);
        }

        $save_path = $full_dir . $filename;
        switch ($file_extension) {
            case 'jpg':
            case 'jpeg':
                $mime_type = 'image/jpeg';
                $result = @imagejpeg($image_resource, $save_path);
                break;
            case 'png':
                $mime_type = 'image/png';
                $result = @imagepng($image_resource, $save_path);
                break;
            case 'gif':
                $mime_type = 'image/gif';
                $result = @imagegif($image_resource, $save_path);
                break;
            default:
                @imagedestroy($image_resource);
                throw new ApiException('文件格式错误');
        }

        @imagedestroy($image_resource);
        if (!$result) {
            throw new ApiException('文件保存失败');
        }

        $hash = md5_file($save_path);
        $size = filesize($save_path);
        $model = $this->findOne($hash, 'hash');
        if ($model) {
            @unlink($save_path);
            return $model->toArray();
        } else {
            $full_dir = $config['root'] . date('Ymd') . DIRECTORY_SEPARATOR;
            if (!is_dir($full_dir)) {
                @mkdir($full_dir, 0777, true);
            }

            $object_name = bin2hex(pack('Nn', time(), mt_rand(1, 65535))) . ".$file_extension";
            $newPath = $full_dir . $object_name;
            @copy($save_path, $newPath);
            @unlink($save_path);
            $baseUrl = $config['domain'] . $config['uri'] . str_replace(DIRECTORY_SEPARATOR, '/', date('Ymd')) . DIRECTORY_SEPARATOR;
            $info['storage_mode'] = 1;
            $info['origin_name'] = $filename;
            $info['object_name'] = $object_name;
            $info['hash'] = $hash;
            $info['mime_type'] = $mime_type;
            $info['storage_path'] = $newPath;
            $info['suffix'] = $file_extension;
            $info['size_byte'] = $size;
            $info['size_info'] = ToolHelper::formatBytes($size);
            $info['url'] = $baseUrl . $object_name;
            $this->model->save($info);
            return $info;
        }
    }

    /**
     * 文件上传
     * @param string $upload
     * @param bool $local
     * @return array
     */
    public function uploadBase(string $upload = 'image', bool $local = false): array
    {
        $logic = new SystemConfigLogic();
        $uploadConfig = $logic->getGroupByCode('upload_config');
        $type = ArrayHelper::getConfigValue($uploadConfig, 'upload_mode');
        if ($local === true) {
            $type = 1;
        }

        $result = UploadService::disk($type, $upload)->uploadFile();
        $data = $result[0];
        $hash = $data['unique_id'];
        $model = $this->findOne($hash, 'hash');
        if ($model) {
            return $model->toArray();
        } else {
            $url = str_replace('\\', '/', $data['url']);
            $savePath = str_replace('\\', '/', $data['save_path']);
            $info['storage_mode'] = $type;
            $info['origin_name'] = $data['origin_name'];
            $info['object_name'] = $data['save_name'];
            $info['hash'] = $data['unique_id'];
            $info['mime_type'] = $data['mime_type'];
            $info['storage_path'] = $savePath;
            $info['suffix'] = $data['extension'];
            $info['size_byte'] = $data['size'];
            $info['size_info'] = ToolHelper::formatBytes($data['size']);
            $info['url'] = $url;
            $this->model->save($info);
            return $info;
        }
    }
}