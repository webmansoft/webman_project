<?php
declare(strict_types=1);

namespace app\common\exception;

use Throwable;
use Webman\Http\Request;
use Webman\Http\Response;
use Webman\Exception\NotFoundException;
use support\exception\BusinessException;

class Handler extends \support\exception\Handler
{
    public $dontReport = [
        ApiException::class,
        BusinessException::class,
    ];

    /**
     * @param Throwable $exception
     * @return void
     */
    public function report(Throwable $exception): void
    {
        $logs = '';
        if ($request = request()) {
            $logs = $request->getRealIp() . ' ' . $request->method() . ' ' . trim($request->fullUrl(), '/');
        }

        if ($this->shouldntReport($exception) || $exception instanceof NotFoundException) {
            $this->logger->error($logs . PHP_EOL . $exception->getMessage());
        } else {
            $this->logger->error($logs . PHP_EOL . $exception);
        }
    }

    public function render(Request $request, Throwable $exception): Response
    {
        $debug = config('app.debug', false);
        $code = $exception->getCode();
        // $message = $debug ? $exception->getMessage() : 'Internal Server Error';
        $message = $exception->getMessage();
        if ($request->expectsJson() || str_starts_with($request->path(), '/backend/')) {
            $json = ['code' => $code ?: 500, 'message' => $message];
            $debug && $json['traces'] = $exception->getTraceAsString();
            return new Response(200, ['Content-Type' => 'application/json'],
                json_encode($json, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        }

        return new Response(200, [], $message);
    }
}
