<?php
declare(strict_types=1);

namespace app\common\library;

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
     * @param string $dir
     * @return void
     */
    public static function recursiveDelete(string $dir): void
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
     * @param string $dir 文件夹路径
     * @param bool $bool 是否递归
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
     * @param string $dir
     * @return void
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
     * 遍历目录
     * @param string $dir
     * @return array
     */
    public static function getDir(string $dir): array
    {
        $dir = base_path($dir);
        $file_dir = [];
        if (is_dir($dir)) {
            if ($handle = opendir($dir)) {
                while (($file = readdir($handle)) !== false) {
                    if ($file != '.' && $file != '..') {
                        $file_dir[] = $file;
                    }
                }

                closedir($handle);
            }
        }

        return $file_dir;
    }
}