<?php
declare(strict_types=1);

namespace app\backend\middleware;

use Webman\Event\Event;
use Webman\Http\Request;
use Webman\Http\Response;
use Webman\MiddlewareInterface;

class SystemToken implements MiddlewareInterface
{
    /**
     * @param Request $request
     * @param callable $handler
     * @return Response
     */
    public function process(Request $request, callable $handler): Response
    {
        $white_list = config('project.white_list', []);
        $rule = $request->path();

        if (in_array($rule, $white_list)) {
            return $handler($request);
        }

        if (request()->isPost()) {
            // 记录日志
            Event::emit('system.user.operation', null);
        }

        return $handler($request);
    }
}