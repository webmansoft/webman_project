<?php
declare(strict_types=1);

namespace app\common\library;

use support\Db;
use Illuminate\Database\Connection;
use Illuminate\Database\Schema\Builder;

class DatabaseHelper
{
    /**
     * 密码哈希
     * @param string $password 密码
     * @return string
     */
    public static function passwordHash(string $password): string
    {
        return md5($password);
    }

    /**
     * 验证密码哈希
     * @param string $password 提交密码
     * @param string $dbPassword 数据库用户密码
     * @return bool
     */
    public static function passwordVerify(string $password, string $dbPassword): bool
    {
        return $dbPassword === md5($password);
    }

    /**
     * 登录验证密码哈希
     * @param string $password 提交密码
     * @param string $dbPassword 数据库用户密码
     * @param string $uniqid 验证码为唯一值
     * @return bool
     */
    public static function loginPasswordVerify(string $password, string $dbPassword, string $uniqid): bool
    {
        return md5($dbPassword . $uniqid) === $password;
    }

    /**
     * 获取表信息 默认全部表名
     * @param string $table_name
     * @param string $mode table 查询表名 tables 查询所有表信息 默认 查询所有表名
     * @return array
     */
    public static function getTables(string $table_name = '', string $mode = ''): array
    {
        if ($mode === 'table' && $table_name) {
            // 查询指定表信息
            $prefix = config('database.connections.mysql.prefix') ?? '';
            return Db::select('SHOW TABLE STATUS LIKE ' . "'" . $prefix . $table_name . "'");
        }
        if ($mode === 'tables') {
            // 查询所有表信息
            return Db::select('SHOW TABLE STATUS');
        }
        // 查询所有表名
        $result = Db::select('SHOW TABLES');
        $database = config('database.connections.mysql.database');
        return array_column($result, 'Tables_in_' . $database);
    }

    /**
     * 获取webman-admin数据库连接
     * @return Connection
     */
    public static function db(): Connection
    {
        return Db::connection('mysql');
    }

    /**
     * 获取SchemaBuilder
     * @return Builder
     */
    public static function schema(): Builder
    {
        return Db::schema('mysql');
    }
}