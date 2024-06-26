<?php
declare(strict_types=1);

namespace app\common\library;

use Closure;
use Generator;
use SplFileInfo;
use FilesystemIterator;

class FileHelper
{
    /**
     * 获取文件内容
     * @param string $file 文件路径
     * @return bool|string content
     */
    public static function readFile(string $file): bool|string
    {
        return is_file($file) ? @file_get_contents($file) : '';
    }

    /**
     * 数据写入文件
     * @param string $file
     * @param mixed $content
     * @return bool|int
     */
    public static function writeFile(string $file, mixed $content): bool|int
    {
        $dir = dirname($file);
        if (!is_dir($dir)) {
            self::mkDirs($dir);
        }

        return @file_put_contents($file, $content);
    }

    /**
     * 复制文件
     * @param string $src 当前文件
     * @param string $destination 目标文件
     * @return bool
     */
    public static function copyFile(string $src, string $destination): bool
    {
        $dir = dirname($destination);
        if (!is_dir($dir)) {
            self::mkDirs($dir);
        }

        return @copy($src, $destination);
    }

    /**
     * 复制文件
     * @param string $file 文件
     * @param string $suffix 前缀
     * @param string $prefix 后缀
     * @return bool
     */
    public static function backup(string $file, string $suffix = '', string $prefix = ''): bool
    {
        $dir = dirname($file);
        $name = $suffix . basename($file) . $prefix;
        $new = $dir . DIRECTORY_SEPARATOR . $name;
        return @copy($file, $new);
    }

    /**
     * 递归删除目录
     */
    public static function recursiveDelete($dir): void
    {
        // 打开指定目录
        if ($handle = @opendir($dir)) {
            while (($file = @readdir($handle)) !== false) {
                if (($file == '.') || ($file == '..')) {
                    continue;
                }
                if (is_dir($dir . '/' . $file)) { // 递归
                    self::recursiveDelete($dir . '/' . $file);
                } else {
                    @unlink($dir . '/' . $file); // 删除文件
                }
            }

            @closedir($handle);
            @rmdir($dir);
        }
    }

    /**
     * 复制文件夹
     * @param string $source 源文件夹
     * @param string $dest 目标文件夹
     */
    public static function copyDirs(string $source, string $dest): void
    {
        if (!is_dir($dest)) {
            @mkdir($dest, 0755, true);
        }

        $handle = @opendir($source);
        while (($file = @readdir($handle)) !== false) {
            if ($file != '.' && $file != '..') {
                if (is_dir($source . "/" . $file)) {
                    self::copyDirs($source . '/' . $file, $dest . '/' . $file);
                } else {
                    copy($source . '/' . $file, $dest . '/' . $file);
                }
            }
        }

        @closedir($handle);
    }

    /**
     * 递归遍历文件夹
     * @param bool $bool 是否递归
     * @param string $dir 文件夹路径
     * @return array
     */
    public static function traverseScanDir(string $dir, bool $bool = true): array
    {
        $array = [];
        $handle = @opendir($dir);
        while (($file = @readdir($handle)) !== false) {
            if ($file != '.' && $file != '..') {
                $child = $dir . '/' . $file;
                if (is_dir($child) && $bool) {
                    $array[$file] = self::traverseScanDir($child);
                } else {
                    $array[] = $file;
                }
            }
        }

        return $array;
    }

    /**
     * 删除空目录
     * @param string $dir 目录
     */
    public static function removeEmptyDir(string $dir): void
    {
        if (is_dir($dir)) {
            $handle = @opendir($dir);
            while (($file = @readdir($handle)) !== false) {
                if ($file != '.' && $file != '..') {
                    self::removeEmptyDir($dir . '/' . $file);
                }
            }

            if (!readdir($handle)) {
                @rmdir($dir);
            }

            @closedir($handle);
        }
    }

    /**
     * 递归创建文件夹
     * @param $path
     * @param int $mode 文件夹权限
     * @return bool
     */
    public static function mkDirs($path, int $mode = 0777): bool
    {
        if (!is_dir(dirname($path))) {
            self::mkDirs(dirname($path));
        }

        if (!file_exists($path)) {
            return mkdir($path, $mode);
        }

        return true;
    }

    /**
     * 扫描目录列表
     * @param string $path 扫描目录
     * @param string $filterExt 筛选后缀
     * @param boolean $shortPath 相对路径
     * @return array
     */
    public static function scanDirectory(string $path, string $filterExt = '', bool $shortPath = true): array
    {
        return static::findFilesArray($path, static function (SplFileInfo $info) use ($filterExt) {
            return empty($filterExt) || $info->getExtension() === $filterExt;
        }, static function (SplFileInfo $info) {
            return !str_starts_with($info->getBasename(), '.');
        }, $shortPath);
    }

    /**
     * 扫描指定目录
     * @param string $path
     * @param ?Closure $filterFile
     * @param ?Closure $filterPath
     * @param boolean $shortPath
     * @return array
     */
    public static function findFilesArray(string $path, ?Closure $filterFile = null, ?Closure $filterPath = null, bool $shortPath = true): array
    {
        $items = [];
        if (file_exists($path)) {
            $files = static::findFilesYield($path, $filterFile, $filterPath);
            foreach ($files as $file) $items[] = $file->getRealPath();
            if ($shortPath && ($offset = strlen(realpath($path)) + 1)) {
                foreach ($items as &$item) $item = substr($item, $offset);
            }
        }

        return $items;
    }

    /**
     * 扫描指定目录
     * @param string $path
     * @param Closure|null $filterFile
     * @param Closure|null $filterPath
     * @param boolean $fullDirectory
     * @return Generator
     */
    public static function findFilesYield(string $path, ?Closure $filterFile = null, ?Closure $filterPath = null, bool $fullDirectory = false): Generator
    {
        if (file_exists($path)) {
            $items = is_file($path) ? [new SplFileInfo($path)] : new FilesystemIterator($path);
            foreach ($items as $item) if ($item->isDir() && !$item->isLink()) {
                if (is_null($filterPath) || $filterPath($item)) {
                    yield from static::findFilesYield($item->getPathname(), $filterFile, $filterPath, $fullDirectory);
                }
                $fullDirectory && yield $item;
            } elseif (is_null($filterFile) || $filterFile($item)) {
                yield $item;
            }
        }
    }
}