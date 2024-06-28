<?php
declare(strict_types=1);

namespace app\common\base;

use support\Model;
use app\common\exception\ApiException;
use app\common\library\DatabaseHelper;
use app\common\trait\TableFieldsTrait;
use Illuminate\Database\Eloquent\Builder;

abstract class LogicCrud
{
    use TableFieldsTrait;

    protected Model $model; // 模型
    protected int $admin_id = 0; // 当前管理员编号
    protected array $admin = []; // 当前管理员信息
    public array $admin_ids = []; // 管理员编号集合
    protected bool $scope = false; // 数据边界启用状态

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
        $fields = $this->getCacheTableField($this->model->getTable());
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
            $fields = $this->getCacheTableField($this->model->getTable());
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
        $fields = $this->getCacheTableField($this->model->getTable());
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
        $fields = $this->getCacheTableField($this->model->getTable());
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
     * @param array $hidden_fields
     * @param array $display_fields
     * @return Model
     */
    public function checkModel(int|string $id, string|bool $primary_key = true, array $hidden_fields = ['*'], array $display_fields = ['*']): Model
    {
        $pk = $this->model->getKeyName();
        $field = $primary_key === true ? $pk : $primary_key;
        $model = $this->findOne($id, $field, $hidden_fields, $display_fields);
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

    public function selectByWhere(array $where, array $select_fields = ['*']): array
    {
        return $this->search($where, $select_fields)->get()->toArray();
    }

    public function countByWhere(array $where, array $select_fields = ['*']): int
    {
        return $this->search($where, $select_fields)->count();
    }

    public function sumByWhere(array $where, string $field, array $select_fields = ['*']): int
    {
        return $this->search($where, $select_fields)->sum($field);
    }

    public function columnByWhere(array $where, string $field, string|null $key = null, array $select_fields = ['*']): array
    {
        return $this->search($where, $select_fields)->pluck($field, $key)->toArray();
    }

    public function findAll(array $where, array $select_fields = ['*']): array
    {
        return $this->search($where, $select_fields)->get()->toArray();
    }

    /**
     * 获取模型
     * @param int|string $id
     * @param string $primary_key
     * @param array $hidden_fields
     * @param array $display_fields
     * @return Model|bool
     */
    public function findOne(int|string $id, string $primary_key = 'id', array $hidden_fields = ['*'], array $display_fields = ['*']): Model|bool
    {
        if ($id) {
            $pk = $this->model->getKeyName();
            if ($pk === $primary_key) {
                $model = $this->model->newQuery()->select($display_fields)->find(intval($id))->makeHidden($hidden_fields);
            } else {
                $model = $this->model->newQuery()->select($display_fields)->where($primary_key, $id)->first()->makeHidden($hidden_fields);
            }

            if ($model) {
                return $model;
            }
        }

        return false;
    }

    /**
     * ['in' => ['file_ext' => [1,2,3]],'like' => ['origin_name' => 'name'],'between' => ['created_at' => '2024-11-11 - 2024-11-12']]
     * 字段已定义规则和对应值
     * @param array $data
     * @param array $select_fields
     * @return Builder
     */
    public function search(array $data, array $select_fields = ['*']): Builder
    {
        $query = $this->model->newQuery()->select($select_fields);
        $rules = ['>', '>=', '=', '<', '<=', '<>', 'like', 'not like', 'in', 'not in', 'null', 'not null', 'betweenDate', 'between'];
        foreach ($data as $rule => $condition) {
            foreach ($condition as $field => $value) {
                if (is_string($value)) {
                    $value = trim($value);
                }

                if (is_string($value) || is_array($value)) {
                    if (in_array($rule, $rules)) {
                        if ($rule === 'like' || $rule === 'not like') {
                            $query = $query->where($field, $rule, "%$value%");
                        } elseif (in_array($rule, ['>', '>=', '=', '<', '<=', '<>'])) {
                            $query = $query->where($field, $rule, $value);
                        } elseif ($rule === 'in' && $value) {
                            if (is_string($value)) {
                                $query = $query->whereIn($field, explode(',', $value));
                            } else {
                                $query = $query->whereIn($field, $value);
                            }
                        } elseif ($rule === 'not in' && $value) {
                            if (is_string($value)) {
                                $query = $query->whereNotIn($field, explode(',', $value));
                            } else {
                                $query = $query->whereNotIn($field, $value);
                            }
                        } elseif ($rule === 'null') {
                            $query = $query->whereNull($field);
                        } elseif ($rule === 'not null') {
                            $query = $query->whereNotNull($field);
                        } elseif ($rule === 'betweenDate') {
                            $between = $value;
                            if (is_string($value) && str_contains($value, ' - ')) {
                                $between = explode(' - ', $value);
                            }

                            $between[1] = $between[1] . ' 23:59:59';
                            $query = $query->whereBetween($field, $between);
                        } elseif ($rule === 'between') {
                            $between = $value;
                            if (is_string($value) && str_contains($value, ' - ')) {
                                $between = explode(' - ', $value);
                            }

                            $query = $query->whereBetween($field, $between);
                        }
                    } else {
                        $query = $query->where($field, $value);
                    }
                }
            }
        }

        if (config('app.debug')) {
            write_log($query->toSql(), 'search toSql');
        }

        return $query;
    }

    public function equalSearch(array $data, array $select_fields = ['*']): Builder
    {
        return $this->search([$data], $select_fields);
    }

    public function inSearch(array $data, array $select_fields = ['*']): Builder
    {
        return $this->search(['in' => $data], $select_fields);
    }

    public function likeSearch(array $data, array $select_fields = ['*']): Builder
    {
        return $this->search(['like' => $data], $select_fields);
    }

    public function betweenSearch(array $data, array $select_fields = ['*']): Builder
    {
        return $this->search(['between' => $data], $select_fields);
    }

    public function betweenDateSearch(array $data, array $select_fields = ['*']): Builder
    {
        return $this->search(['betweenDate' => $data], $select_fields);
    }

    /**
     * 分页查询数据
     * @param Builder $query
     * @return array
     */
    public function getQueryList(Builder $query): array
    {
        $limit = request()->input('limit') ?: 10;
        $orderBy = request()->input('orderBy') ?: $this->model->getKeyName();
        $orderType = request()->input('orderType') ?: 'ASC';
        if ($this->scope) {
            $query = $this->adminDataScope($query);
        }

        $query->orderBy($orderBy, $orderType);
        $data = $query->paginate($limit)->toArray();
        return [
            // 获取当前页的所有项
            'items' => $data['data'],
            // 数据总数
            'total' => $data['total'],
            // 每页的数据条数
            'limit' => $data['per_page'],
            // 获取当前页页码
            'page' => $data['current_page'],
        ];
    }

    /**
     * 获取全部数据
     * @param Builder $query
     * @param array $select_fields
     * @return array
     */
    public function getQueryAll(Builder $query, array $select_fields = ['*']): array
    {
        $order_by = request()->input('orderBy') ?: $this->model->getKeyName();
        $order_type = request()->input('orderType') ?: 'asc';
        if ($this->scope) {
            $query = $this->adminDataScope($query);
        }

        $query->orderBy($order_by, $order_type);
        return $query->get($select_fields)->toArray();
    }

    /**
     * 数据权限处理
     * @param Builder $query
     * @return Builder
     */
    public function adminDataScope(Builder $query): Builder
    {
        if (!$this->admin) {
            throw new ApiException('数据权限读取失败');
        }

        // todo
        return $query->where('created_by', 'in', array_unique($this->admin_ids));
    }
}