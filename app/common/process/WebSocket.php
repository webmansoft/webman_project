<?php
declare(strict_types=1);

namespace app\common\process;

use app\common\service\JwtService;
use Workerman\Connection\TcpConnection;

class WebSocket
{
    public array $connectionArray = [];

    public function onConnect(TcpConnection $connection): void
    {
        // websocket连接
        $connection->onWebSocketConnect = function ($connection, $http_buffer) {
            // 可以在这里判断连接来源是否合法，不合法就关掉连接
            $domain = $_SERVER['HTTP_ORIGIN'];

            // 通过token进行用户认证
            try {
                $token = $_GET['token'];
                $jwt = new JwtService();
                $user = $jwt->parseToken($token);
            } catch (\Exception $e) {
                var_dump($e->getMessage());
                $connection->close();
            }
        };

        // 消息处理
        $connection->onMessage = function ($connection, $data) {
            // 收到客户端消息
            $data = json_decode($data, true);

            // 向客户端发送消息
            $return_ret = [
                'event' => 'ev_new_message',
                'message' => '新消息通知',
                'data' => [
                    [
                        'id' => 1,
                        'title' => '系统消息',
                        'content' => '欢迎使用框架',
                        'create_time' => date('Y-m-d H:i:s'),
                        'send_user' => [
                            'nickname' => '系统管理员',
                            'avatar' => ''
                        ]
                    ]
                ]
            ];
            $connection->send(json_encode($return_ret));
        };

        // 连接关闭
        $connection->onClose = function ($connection) {
            $connection->close();
        };
    }

    public function onClose(TcpConnection $connection): void
    {
        // 关闭websocket
        $connection->close();
    }
}