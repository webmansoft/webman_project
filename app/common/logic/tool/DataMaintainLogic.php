<?php
declare(strict_types=1);

namespace app\common\logic\tool;

use app\common\base\BaseLogic;

class DataMaintainLogic extends BaseLogic
{
    public function getList($query): void
    {
        $page = request()->input('page') ? request()->input('page') : 1;
        $limit = request()->input('limit') ? request()->input('limit') : 10;
        // return $this->getTableList($query, $page, $limit);
    }

    /**
     * 获取数据库表数据
     */
    public function getTableList(array $query, int $current_page = 1, int $per_page = 10)
    {

    }

    /**
     * 获取列信息
     */
    public function getColumnList(string $table, string $source)
    {

    }

    /**
     * 优化表
     */
    public function optimizeTable(array $tables)
    {

    }

    /**
     * 清理表碎片
     */
    public function fragmentTable(array $tables)
    {

    }
}