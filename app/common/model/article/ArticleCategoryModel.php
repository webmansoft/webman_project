<?php
/**
 * @desc ArticleCategoryModel
 * @date 2024/06/25 15:43:52
 */

declare(strict_types=1);

namespace app\common\model\article;

use Illuminate\Database\Eloquent\SoftDeletes;
use app\common\base\BaseModel;

class ArticleCategoryModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'article_category';
}