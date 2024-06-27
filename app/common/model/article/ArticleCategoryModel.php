<?php
declare(strict_types=1);

namespace app\common\model\article;

use app\common\base\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;

class ArticleCategoryModel extends BaseModel
{
    use SoftDeletes;

    /**
     * 数据表名称
     * @var string
     */
    protected $table = 'article_category';
}