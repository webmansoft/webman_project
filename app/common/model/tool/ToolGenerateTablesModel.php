<?php
/**
 * @desc ToolGenerateTablesModel
 * @date 2024/06/25 15:44:08
 */

declare(strict_types=1);

namespace app\common\model\tool;

use Illuminate\Database\Eloquent\SoftDeletes;
use app\common\base\BaseModel;

class ToolGenerateTablesModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'tool_generate_tables';
}