<?php
declare(strict_types=1);

namespace app\common\base;

use Webmansoft\Jwt\JwtToken;
use app\common\exception\ApiException;

abstract class BaseLogic extends LogicCrud
{
    /**
     * @param int $id
     * @param int $pid
     * @return void
     */
    public function checkEditChildren(int $id, int $pid): void
    {
        if ($id == $pid) {
            throw new ApiException('父级菜单不能是自身');
        }

        if ($pid) {
            $childrenIds = $this->getChildrenPath($id);
            if (in_array($pid, $childrenIds)) {
                throw new ApiException('自身的子菜单不能作为父级菜单');
            }
        }
    }

    /**
     * 获取当前ID的所有子类
     * @param int $pid
     * @return array
     */
    public function getChildrenPath(int $pid): array
    {
        $ids = $this->model->where('parent_id', $pid)->pluck('id')->toArray();
        foreach ($ids as $id) {
            if ($child = $this->getChildrenPath($id)) {
                $ids = array_merge($ids, $child);
            }
        }

        return $ids;
    }

    /**
     * 获取token
     * @param int $uid
     * @param string $username
     * @param string $client
     * @param string $module
     * @return array
     */
    public function getToken(int $uid, string $username, string $client = JwtToken::TOKEN_CLIENT_WEB, string $module = 'backend'): array
    {
        $extend = [
            'id' => $uid,
            'username' => $username,
            'client' => $client,
            'module' => $module,
        ];
        return JwtToken::generateToken($extend);
    }

    /**
     * 真实删除 30之前日志
     * @param int $day
     * @return mixed
     */
    public function clearLog(int $day = 30): mixed
    {
        $time = date('Y-m-d', strtotime('-' . $day . ' day'));
        return $this->model->where($this->model::CREATED_AT, '<', $time)->forceDelete();
    }
}