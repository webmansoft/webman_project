<?php
declare(strict_types=1);

namespace app\common\logic\system;

use app\common\base\BaseLogic;
use app\common\library\ArcoHelper;
use app\common\exception\ApiException;
use app\common\model\system\SystemMenuModel;

class SystemMenuLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemMenuModel();
        parent::__construct();
    }

    /**
     * 数据保存
     */
    public function save(array $data): bool
    {
        $data = $this->handleData($data);
        return $this->insert($data);
    }

    /**
     * 数据修改
     */
    public function edit(array $data): int
    {
        $data = $this->handleData($data);
        $this->checkEditChildren($data['id'], $data['parent_id']);
        return $this->update($data);
    }

    /**
     * 数据删除
     */
    public function destroy(array $ids, bool $force = false): int
    {
        $num = $this->model->where('parent_id', 'in', $ids)->count();
        if ($num) {
            throw new ApiException('该菜单下存在子菜单，请先删除子菜单');
        } else {
            return $this->model->destroy($ids, $force);
        }
    }

    /**
     * 数据处理
     */
    protected function handleData(array $data): array
    {
        if (empty($data['parent_id'])) {
            $data['level'] = '0';
            $data['parent_id'] = 0;
            $data['type'] = $data['type'] === 'B' ? 'M' : $data['type'];
        } else {
            $parentMenu = $this->checkModel($data['parent_id']);
            $data['level'] = $parentMenu['level'] . ',' . $parentMenu['id'];
        }

        return $data;
    }

    /**
     * 数据树形化
     * @param array $where
     * @return array
     */
    public function tree(array $where = []): array
    {
//        $query = $this->search($where);
//        if (request()->input('tree', 'false') === 'true') {
//            $query->field('id, id as value, name as label, parent_id');
//        }
//        $data = $this->getAll($query);
//        return Helper::makeTree($data);
    }

    /**
     * 获取全部菜单
     */
    public function getAllMenus(): array
    {
        $query = $this->inSearch(['type' => ['M', 'I', 'L']])->orderBy('sort', 'desc');
        $data = $this->getQueryAll($query);
        return ArcoHelper::makeArcoMenus($data);
    }

    /**
     * 获取全部操作code
     */
    public function getAllCode(): array
    {
        return $this->columnByWhere(['type' => 'B'], 'code');
    }

    /**
     * 根据$ids获取权限
     * @param array $ids
     * @return array
     */
    public function getMenuCodeById(array $ids): array
    {
        $where = [
            ['type' => 'B'],
            'in' => ['id' => $ids],
        ];
        return $this->columnByWhere($where, 'code');
    }

    /**
     * 根据ids获取路由菜单
     * @param array $ids
     * @return array
     */
    public function getRoutersByIds(array $ids): array
    {
        $where = [
            ['status' => 1],
            'in' => ['id' => $ids],
        ];

        $data = $this->search($where)
            ->orderBy('sort', 'desc')
            ->get()
            ->toArray();

        return ArcoHelper::makeArcoMenus($data);
    }

    /**
     * 过滤通过角色查询出来的菜单id列表，并去重
     * @param array $role_data
     * @return array
     */
    public function filterMenuIds(array $role_data): array
    {
        $ids = [];
        foreach ($role_data as $val) {
            foreach ($val['menu'] as $menu) {
                $ids[] = $menu['id'];
            }
        }

        unset($role_data);
        return array_unique($ids);
    }
}