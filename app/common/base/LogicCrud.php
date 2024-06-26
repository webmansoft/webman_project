<?php
declare(strict_types=1);

namespace app\common\base;

use support\Model;
use Illuminate\Database\Eloquent\Builder;
use app\common\exception\ApiException;
use app\common\library\DatabaseHelper;
use app\common\trait\TableFieldsTrait;

abstract class LogicCrud
{
    use TableFieldsTrait;

    protected Model $model;                // 模型
    protected int $admin_id = 0;           // 当前管理员编号
    protected array $admin = [];           // 当前管理员信息
    protected bool $scope = false;      // 数据边界启用状态

    /**
     * 初始化
     * @param int $admin_id
     * @param array $admin
     * @return void
     */
    public function init(int $admin_id, array $admin): void
    {
        $this->admin = $admin;
        $this->admin_id = $admin_id;
    }

    /**
     * 插入
     * @param array $data
     * @param string $password_field
     * @return int|bool
     */
    public function insert(array $data, string $password_field = 'password'): int|bool
    {
        $pk = $this->model->getKeyName();
        $model = new (get_class($this->model));
        $fields = $this->getCacheTableField();
        foreach ($data as $field => $value) {
            if (isset($fields[$field])) {
                if (isset($data[$password_field])) {
                    $model->{$passwordField} = DatabaseHelper::passwordHash($data[$password_field]);
                } else {
                    $model->{$field} = $value;
                }
            }
        }

        if (isset($fields['created_by'])) {
            $model->created_by = $this->admin_id;
        }

        if (isset($fields[$this->model::CREATED_AT])) {
            $model->{$this->model::CREATED_AT} = date('Y-m-d H:i:s');
        }

        if (isset($fields[$this->model::UPDATED_AT])) {
            $model->{$this->model::UPDATED_AT} = date('Y-m-d H:i:s');
        }

        return $model->save() ? $model->{$pk} : false;
    }

    /**
     * 批量插入
     * @param array $data
     * @return bool
     */
    public function insertBatch(array $data): bool
    {
        if ($data) {
            $fields = $this->getCacheTableField();
            foreach ($data as &$row) {
                if (isset($fields['created_by'])) {
                    $row['created_by'] = $this->admin_id;
                }

                if (isset($fields[$this->model::CREATED_AT])) {
                    $row[$this->model::CREATED_AT] = date('Y-m-d H:i:s');
                }

                if (isset($fields[$this->model::UPDATED_AT])) {
                    $row[$this->model::UPDATED_AT] = date('Y-m-d H:i:s');
                }
            }

            return $this->model->insert($data);
        }

        return false;
    }

    /**
     * 按主键更新
     * @param array $data
     * @param string $password_field
     * @return int
     */
    public function update(array $data = [], string $password_field = 'password'): int
    {
        $data = $data ?: Request()->post();
        return $this->updateBatch($data, true, $password_field);
    }

    /**
     * 批量更新
     * @param array $data
     * @param bool $batch
     * @param string $password_field
     * @return int
     */
    public function updateBatch(array $data, bool $batch = true, string $password_field = 'password'): int
    {
        $pk = $this->model->getKeyName();
        $ids = $this->getIds($batch);
        $fields = $this->getCacheTableField();
        foreach ($data as $field => $value) {
            if (!isset($fields[$field])) {
                unset($data[$field]);
            }

            if (isset($data[$password_field])) {
                // 密码长度小于6，则不更新密码
                if (strlen($data[$password_field]) < 6) {
                    unset($data[$password_field]);
                } else {
                    $data[$password_field] = DatabaseHelper::passwordHash($data[$password_field]);
                }
            }
        }

        if (isset($fields['updated_by'])) {
            $data['updated_by'] = $this->admin_id;
        }

        if (isset($fields[$this->model::UPDATED_AT])) {
            $data[$this->model::UPDATED_AT] = date('Y-m-d H:i:s');
        }

        unset($data[$pk]);
        return $this->model->whereIn($pk, $ids)->update($data);
    }

    /**
     * 按条件更新
     * @param array $data
     * @param array $where
     * @return int
     */
    public function updateByWhere(array $data, array $where): int
    {
        $fields = $this->getCacheTableField();
        if (isset($fields['updated_by'])) {
            $data['updated_by'] = $this->admin_id;
        }

        if (isset($fields[$this->model::UPDATED_AT])) {
            $data[$this->model::UPDATED_AT] = date('Y-m-d H:i:s');
        }

        return $this->model->where($where)->update($data);
    }

    /**
     * 软删除
     * @param array $where
     * @return int
     */
    public function delete(array $where = []): int
    {
        return $this->deleteBatch($where);
    }

    /**
     * 批量软删除
     * @param array $where
     * @param bool $batch
     * @return int
     */
    public function deleteBatch(array $where = [], bool $batch = true): int
    {
        $ids = $this->getIds($batch);
        $pk = $this->model->getKeyName();
        return $this->model->whereIn($pk, $ids)
            ->when($where, function ($query, $where) {
                $query->where($where);
            })->delete();
    }

    /**
     * 恢复软删除
     * @param array $where
     * @return bool
     */
    public function restore(array $where = []): bool
    {
        return $this->restoreBatch($where);
    }

    /**
     * 批量 恢复软删除
     * @param array $where
     * @param bool $batch
     * @return bool
     */
    public function restoreBatch(array $where = [], bool $batch = true): bool
    {
        $pk = $this->model->getKeyName();
        $ids = $this->getIds($batch);
        $data = $this->model->whereIn($pk, $ids)
            ->when($where, function ($query, $where) {
                $query->where($where);
            })->get();

        foreach ($data as $item) {
            $item->restore();
        }

        return true;
    }

    /**
     * 真实删除
     * @param array $where
     * @return bool
     */
    public function forceDelete(array $where = []): bool
    {
        return $this->forceDeleteBatch($where);
    }

    /**
     * 批量真实删除
     * @param array $where
     * @param bool $batch
     * @return bool
     */
    public function forceDeleteBatch(array $where = [], bool $batch = true): bool
    {
        $ids = $this->getIds($batch);
        $pk = $this->model->getKeyName();
        $data = $this->model->whereIn($pk, $ids)
            ->when($where, function ($query, $where) {
                $query->where($where);
            })->get();

        foreach ($data as $item) {
            $item->forceDelete();
        }

        return true;
    }

    /**
     * 获取主键参数
     * @param bool $batch
     * @param string $request_method
     * @return array|int
     */
    protected function getIds(bool $batch = true, string $request_method = 'post'): array|int
    {
        $pk = $this->model->getKeyName();
        if (in_array($request_method, ['get', 'post', 'all'])) {
            $data = Request()->{$request_method}();
            if (!isset($data[$pk])) {
                throw new ApiException('参数错误，没有找到主键字段');
            }

            if ($batch) {
                return explode(',', $data[$pk]);
            }

            return intval($data[$pk]);
        } else {
            throw new ApiException('参数错误，请求方法错误');
        }
    }

    /**
     * 检测模型是否存在
     * @param int|string $id 编号
     * @param string|bool $primary_key
     * @param array $fields
     * @return Model
     */
    public function checkModel(int|string $id, string|bool $primary_key = true, array $fields = ['*']): Model
    {
        $pk = $this->model->getKeyName();
        $field = $primary_key === true ? $pk : $primary_key;
        $model = $this->findOne($id, $field, $fields);
        if ($model) {
            return $model;
        }

        $table = $this->model->getTable();
        throw new ApiException('【数据表】' . $table . '【主键】' . $pk . '【数据】' . $id . ' 不存在');
    }

    /**
     * 检测模型是否存在
     * @param string $primary_key
     * @param string $request_method
     * @return Model
     */
    public function checkModelByRequest(string $primary_key = 'id', string $request_method = 'get'): Model
    {
        $id = $this->getIds(false, $request_method);
        return $this->checkModel($id, $primary_key);
    }

    /**
     * 检测当前用户模型
     * @return array
     */
    public function checkSelfByRequest(): array
    {
        return $this->checkModel($this->admin_id)->toArray();
    }

    public function selectByWhere(array $where, array $fields = ['*']): array
    {
        return $this->model->select($fields)->where($where)->get()->toArray();
    }

    public function countByWhere(array $where): int
    {
        return $this->model->where($where)->count();
    }

    public function sumByWhere(array $where, string $field): int
    {
        return $this->model->where($where)->sum($field);
    }

    public function columnByWhere(array $where, string $field, string|null $key = null): array
    {
        return $this->model->where($where)->pluck($field, $key)->toArray();
    }

    public function findAll(array $where, array $fields = ['*']): array
    {
        return $this->model->select($fields)->where($where)->get()->toArray();
    }

    /**
     * 获取模型
     * @param int|string $id
     * @param string $primary_key
     * @param array $fields
     * @return Model|bool
     */
    public function findOne(int|string $id, string $primary_key = 'id', array $fields = ['*']): Model|bool
    {
        if ($id) {
            $pk = $this->model->getKeyName();
            if ($pk === $primary_key) {
                $model = $this->model->select($fields)->find(intval($id));
            } else {
                $model = $this->model->select($fields)->where($primary_key, $id)->first();
            }

            if ($model) {
                return $model;
            }
        }

        return false;
    }

    /**
     * 获取查询分页数据
     * @param Builder $query
     * @param int $limit
     * @param int $page
     * @return array
     */
    public function getPaginateData(Builder $query, int $limit = 10, int $page = 1): array
    {
        $paginate = $query->paginate($limit, ['*'], 'page', $page)->toArray();
        return [
            // 获取当前页的所有项
            'items' => $paginate['data'],
            // 数据总数
            'total' => $paginate['total'],
            // 每页的数据条数
            'limit' => $paginate['per_page'],
            // 获取当前页页码
            'page' => $paginate['current_page'],
        ];
    }
}