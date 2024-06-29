<?php
declare(strict_types=1);

namespace app\common\logic\article;

use app\common\base\BaseLogic;
use app\common\model\article\ArticleCategoryModel;

class ArticleCategoryLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new ArticleCategoryModel();
    }
}