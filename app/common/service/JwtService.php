<?php
declare(strict_types=1);

namespace app\common\service;

use Exception;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use app\common\exception\ApiException;

class JwtService
{
    /**
     * token
     * @var string
     */
    protected string $token;

    public string $key = 'webman_project';

    /**
     * 获取token
     * @param int $id
     * @param string $username
     * @param string $client
     * @param array $params
     * @return array
     */
    public function getToken(int $id, string $username, string $client, array $params = []): array
    {
        $host = request()->host();
        $time = time();
        $hour = config('project.jwt.token_expire', 6);
        $params += [
            'iss' => $host,
            'aud' => $host,
            'iat' => $time,
            'nbf' => $time,
            'exp' => strtotime('+ ' . $hour . ' hour'),
        ];
        $params['jti'] = compact('id', 'username', 'client');
        $token = JWT::encode($params, $this->key, 'HS256');
        return compact('token', 'params');
    }

    /**
     * 解析token
     * @param string $jwt
     * @return array
     */
    public function parseToken(string $jwt): array
    {
        try {
            $this->token = $jwt;
            $decoded = JWT::decode($jwt, new Key($this->key, 'HS256'));
            $json = json_decode(json_encode($decoded), true);
            return [$json['jti']['id'], $json['jti']['username'], $json['jti']['client']];
        } catch (Exception) {
            throw new ApiException('登录状态已过期，需要重新登录', 401);
        }
    }

    /**
     * 创建token
     * @param int $id
     * @param string $username
     * @param string $client
     * @param array $params
     * @return array
     */
    public function createToken(int $id, string $username, string $client, array $params = []): array
    {
        return $this->getToken($id, $username, $client, $params);
    }
}
