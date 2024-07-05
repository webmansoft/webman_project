<?php
declare(strict_types=1);

namespace app\common\service;

use Tinywan\Storage\Adapter\CosAdapter;
use Tinywan\Storage\Adapter\OssAdapter;
use Tinywan\Storage\Adapter\QiniuAdapter;
use Tinywan\Storage\Adapter\LocalAdapter;
use app\common\library\ArrayHelper;
use app\common\exception\ApiException;
use app\common\logic\system\SystemConfigLogic;

class UploadService
{
    /**
     * 存储磁盘
     * @param int $type
     * @param string $upload
     * @param bool $is_file_upload
     * @return mixed
     */
    public static function disk(int $type = 1, string $upload = 'image', bool $is_file_upload = true): mixed
    {
        $logic = new SystemConfigLogic();
        $uploadConfig = $logic->getGroupByCode('upload_config');
        $file = current(request()->file());
        write_log(request()->file(), 'disk request file');
        write_log($file, 'disk file');
        write_log(request(), 'disk request()');
        $ext = $file->getUploadExtension() ?: null;
        $file_size = $file->getSize();
        if ($file_size > ArrayHelper::getConfigValue($uploadConfig, 'upload_size')) {
            throw new ApiException('文件大小超过限制');
        }

        $allow_file = ArrayHelper::getConfigValue($uploadConfig, 'upload_allow_file');
        $allow_image = ArrayHelper::getConfigValue($uploadConfig, 'upload_allow_image');
        if ($upload == 'image') {
            if (!in_array($ext, explode(',', $allow_image))) {
                throw new ApiException('不支持该格式的文件上传');
            }
        } else {
            if (!in_array($ext, explode(',', $allow_file))) {
                throw new ApiException('不支持该格式的文件上传');
            }
        }

        $config = match ($type) {
            1 => [
                'adapter' => LocalAdapter::class,
                'root' => ArrayHelper::getConfigValue($uploadConfig, 'local_root'),
                'dirname' => function () {
                    return date('Ymd');
                },
                'domain' => ArrayHelper::getConfigValue($uploadConfig, 'local_domain'),
                'uri' => ArrayHelper::getConfigValue($uploadConfig, 'local_uri'),
                'algo' => 'sha1',
            ],
            2 => [
                'adapter' => OssAdapter::class,
                'accessKeyId' => ArrayHelper::getConfigValue($uploadConfig, 'oss_accessKeyId'),
                'accessKeySecret' => ArrayHelper::getConfigValue($uploadConfig, 'oss_accessKeySecret'),
                'bucket' => ArrayHelper::getConfigValue($uploadConfig, 'oss_bucket'),
                'dirname' => ArrayHelper::getConfigValue($uploadConfig, 'oss_dirname'),
                'domain' => ArrayHelper::getConfigValue($uploadConfig, 'oss_domain'),
                'endpoint' => ArrayHelper::getConfigValue($uploadConfig, 'oss_endpoint'),
                'algo' => 'sha1',
            ],
            3 => [
                'adapter' => QiniuAdapter::class,
                'accessKey' => ArrayHelper::getConfigValue($uploadConfig, 'qiniu_accessKey'),
                'secretKey' => ArrayHelper::getConfigValue($uploadConfig, 'qiniu_secretKey'),
                'bucket' => ArrayHelper::getConfigValue($uploadConfig, 'qiniu_bucket'),
                'dirname' => ArrayHelper::getConfigValue($uploadConfig, 'qiniu_dirname'),
                'domain' => ArrayHelper::getConfigValue($uploadConfig, 'qiniu_domain'),
            ],
            4 => [
                'adapter' => CosAdapter::class,
                'secretId' => ArrayHelper::getConfigValue($uploadConfig, 'cos_secretId'),
                'secretKey' => ArrayHelper::getConfigValue($uploadConfig, 'cos_secretKey'),
                'bucket' => ArrayHelper::getConfigValue($uploadConfig, 'cos_bucket'),
                'dirname' => ArrayHelper::getConfigValue($uploadConfig, 'cos_dirname'),
                'domain' => ArrayHelper::getConfigValue($uploadConfig, 'cos_domain'),
                'region' => ArrayHelper::getConfigValue($uploadConfig, 'cos_region'),
            ],
            default => throw new ApiException('该上传模式不存在'),
        };

        return new $config['adapter'](array_merge($config, ['_is_file_upload' => $is_file_upload]));
    }

    /**
     * @param $name
     * @param $arguments
     * @return mixed
     */
    public static function __callStatic($name, $arguments)
    {
        return static::disk()->{$name}(...$arguments);
    }
}
