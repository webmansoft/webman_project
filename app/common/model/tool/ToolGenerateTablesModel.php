<?php
declare(strict_types=1);

namespace app\common\model\tool;

use app\common\base\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;

class ToolGenerateTablesModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'tool_generate_tables';
}