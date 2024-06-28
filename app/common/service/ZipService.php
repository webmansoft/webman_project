<?php
declare(strict_types=1);

namespace app\common\service;

use Throwable;
use ZipArchive;
use RecursiveIteratorIterator;
use RecursiveDirectoryIterator;
use app\common\exception\ApiException;

class ZipService
{
    private array $config = [
        'suffix' => '.zip', // 文件后缀
        'compileDir' => 'zip', // 生成目录
        'fromDir' => 'saiadmin', // 目标目录
        'cache_time' => 7200, // 设置多长时间自动更新
        'cache' => true, // 是否需要缓存
    ];

    public function __construct()
    {
        $runPath = runtime_path();
        $this->config['compileDir'] = $runPath . DIRECTORY_SEPARATOR . $this->config['compileDir'];
        $this->config['fromDir'] = $runPath . DIRECTORY_SEPARATOR . $this->config['fromDir'];
        // 创建压缩目录
        if (!is_dir($this->config['compileDir'])) {
            if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
                mkdir($this->config['compileDir']);
            } else {
                mkdir($this->config['compileDir'], 0770, true);
            }
        }

        // 清理源目录
        if (is_dir($this->config['fromDir'])) {
            $this->recursiveDelete($this->config['fromDir']);
        }
    }

    /**
     * 文件压缩
     * @param string $fileName
     * @param bool $isDownload
     * @return string
     */
    public function compress(string $fileName, bool $isDownload = false): string
    {
        $zipArc = new ZipArchive;
        $zipName = $this->config['compileDir'] . DIRECTORY_SEPARATOR . $fileName;
        $dirPath = $this->config['fromDir'];
        if ($zipArc->open($zipName, ZipArchive::OVERWRITE | ZipArchive::CREATE) !== true) {
            throw new ApiException('无法打开文件，或者文件创建失败');
        }

        $this->addFileToZip($dirPath, $zipArc);
        $zipArc->close();
        // 是否下载
        if ($isDownload) {
            $this->toBinary($zipName);
        }

        return $zipName;
    }

    /**
     * 文件解压
     * @param string $file
     * @param string $dirName
     * @return bool
     */
    public function deCompress(string $file, string $dirName): bool
    {
        if (!file_exists($file)) {
            return false;
        }
        // zip实例化对象
        $zipArc = new ZipArchive();
        // 打开文件
        if (!$zipArc->open($file)) {
            return false;
        }
        // 解压文件
        if (!$zipArc->extractTo($dirName)) {
            $zipArc->close();
            return false;
        }

        return $zipArc->close();
    }

    /**
     * 将文件加入到压缩包
     * @param $rootPath
     * @param $zip
     * @return void
     */
    public function addFileToZip($rootPath, $zip): void
    {
        $files = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($rootPath),
            RecursiveIteratorIterator::LEAVES_ONLY
        );
        foreach ($files as $file) {
            // Skip directories (they would be added automatically)
            if (!$file->isDir()) {
                // Get real and relative path for current file
                $filePath = $file->getRealPath();
                $relativePath = substr($filePath, strlen($rootPath) + 1);

                // Add current file to archive
                $zip->addFile($filePath, $relativePath);
            }
        }
    }

    /**
     * 递归删除目录下所有文件和文件夹
     */
    public function recursiveDelete($dir): void
    {
        // 打开指定目录
        if ($handle = @opendir($dir)) {
            while (($file = readdir($handle)) !== false) {
                if (($file == ".") || ($file == "..")) {
                    continue;
                }

                if (is_dir($dir . '/' . $file)) {
                    // 递归
                    self::recursiveDelete($dir . '/' . $file);
                } else {
                    unlink($dir . '/' . $file); // 删除文件
                }
            }
            @closedir($handle);
        }

        rmdir($dir);
    }

    /**
     * 下载二进制流文件
     */
    public function toBinary(string $fileName): void
    {
        try {
            header('Cache-Control: public');
            header('Content-Description: File Transfer');
            header('Content-disposition: attachment; filename=' . basename($fileName)); // 文件名
            header('Content-Type: application/zip'); // zip格式
            header('Content-Transfer-Encoding: binary'); // 二进制文件
            header('Content-Length: ' . filesize($fileName)); // 文件大小
            if (ob_get_length() > 0) {
                ob_clean();
            }

            flush();
            @readfile($fileName);
            @unlink($fileName);
        } catch (Throwable $e) {
            throw new ApiException('系统生成文件错误：' . $e->getMessage());
        }
    }
}