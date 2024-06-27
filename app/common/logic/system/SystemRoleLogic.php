<?php
declare(strict_types=1);

namespace app\common\logic\system;

use app\common\base\BaseLogic;
use app\common\base\BaseModel;
use app\common\model\system\SystemRoleModel;

class SystemRoleLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemRoleModel();
    }

    public function getMenuIdsByRoleIds(array $ids): array
    {
        if (empty($ids)) {
            return [];
        }

        return $this->model->newQuery()
            ->whereIn('id', $ids)
            ->with(['menu' => function ($query) {
                $query->where('status', 1)->orderBy('sort', 'desc');
            }])->get()->toArray();
    }

    public function getMenuByRole(int $id): array|bool
    {
        $role = $this->model->find($id);
        if ($role) {
            return [
                'id' => $id,
                'menu' => $role->menu() ?? []
            ];
        }

        return false;
    }

    public function saveMenuPermission(int $id, array $menu_ids): BaseModel
    {
        $role = $this->model->find($id);
        if ($role) {
            $role->menu()->detach();
            $role->menu()->insert($menu_ids);
        }

        return $role;
    }

    public function getDepartmentByRole(int $id): array|bool
    {
        $role = $this->model->find($id);
        if ($role) {
            return [
                'id' => $id,
                'department' => $role->department() ?? []
            ];
        }

        return false;
    }

    public function saveDepartmentPermission(int $id, array $data): BaseModel
    {
        $role = $this->model->find($id);
        if ($role) {
            $role->setAttribute('data_scope', $data['data_scope']);
            $role->save();
            $role->department()->detach();
            $role->department()->insert($data['department_ids']);
        }

        return $role;
    }
}