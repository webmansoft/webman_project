<?php
/**
 * @desc ArticleCategoryLogic
 * @date 2024/06/25 16:16:37
 */

declare(strict_types=1);

namespace app\common\logic\article;

use Illuminate\Database\Eloquent\Builder;
use app\common\base\BaseLogic;
use app\common\model\article\ArticleCategoryModel;

class ArticleCategoryLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new ArticleCategoryModel();
    }

//    /**
//     * 搜索
//     * @param array $params
//     * @param bool $return_query
//     * @return array|Builder
//     */
//    public function search(array $params = [], bool $return_query = false): Builder|array
//    {
//        $query = $this->model->query();
//        if (!empty($params['name'])) {
//            $query->where('name', 'like', '%' . $params['name'] . '%');
//        }
//
//        if (isset($params['status']) && $params['status'] !== '') {
//            $query->where('status', intval($params['status']));
//        }
//
//        if (!empty($params['created_at'])) {
//            $query->where('created_at', '>=', $params['created_at'] . ' 00:00:00');
//            $query->where('created_at', '<=', $params['created_at'] . ' 23:59:59');
//        }
//
//        if (!empty($params['is_deleted'])) {
//            $query->whereNotNull('deleted_at');
//        }
//
//        if ($return_query) {
//            return $query;
//        }
//
//        return $this->getPaginateData($query, $params['limit'] ?? 10, $params['page'] ?? 1);
//    }
}