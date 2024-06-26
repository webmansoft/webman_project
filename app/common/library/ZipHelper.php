<?php
declare(strict_types=1);

namespace app\common\library;

use ZipArchive;

class ZipHelper
{
    /**
     * 单文件压缩
     * @param string $file
     * @param string $name
     * @param string $ext
     * @return bool|array  路径 和 文件名
     */
    public static function zipFile(string $file, string $name, string $ext): bool|array
    {
        $zip = new ZipArchive;
        $zip_time = date('Y-m-d-H-i-s') . '.zip'; // 压缩的目录名
        $zip_filename = runtime_path('download') . DIRECTORY_SEPARATOR . $zip_time; // 指定一个压缩包地址
        FileHelper::mkDirs(runtime_path('download'));
        $zip->open($zip_filename, ZIPARCHIVE::CREATE); // 打开压缩包,没有则创建

        // 参数1是要压缩的文件
        // 参数2为压缩后,在压缩包中的文件名「这里我们把 demo1.php 文件压缩,压缩后的文件为 dd.php」,如果需要的压缩后的文件跟原文件名一样 addFile() 的第二个参数可以改为 basename("../alg/demo1.php"),也就是原文件所在的路径
        // $zip->addFile("../alg/demo1.php", basename("dd.php"));
        $path = explode('/storage/', $file);
        $download = realpath(public_path('storage') . DIRECTORY_SEPARATOR . $path[1]);
        $zip->addFile($download, $name . '.' . $ext);

        if ($zip->close()) {
            return [$zip_filename, $zip_time];
        }

        return false;
    }

    /**
     * 多文件压缩
     * @param array $files
     * @return bool|array 路径 和 文件名
     */
    public static function zipFiles(array $files): bool|array
    {
        $zip_time = date('Y-m-d-H-i-s') . '.zip'; // 压缩的目录名
        $zip_filename = runtime_path('download') . DIRECTORY_SEPARATOR . $zip_time; // 指定一个压缩包地址
        FileHelper::mkDirs(runtime_path('download'));
        $zip = new ZipArchive();
        $zip->open($zip_filename, ZipArchive::CREATE); // 打开压缩包
        foreach ($files as $file) {
            $path = explode('/storage/', $file['file_path']);
            $file_path = realpath(public_path('storage') . DIRECTORY_SEPARATOR . $path[1]);
            $zip->addFile($file_path, $file['title'] . '.' . $file['file_ext']); // 向压缩包中添加文件
        }

        if ($zip->close()) {
            return [$zip_filename, $zip_time];
        }

        return false;
    }
}