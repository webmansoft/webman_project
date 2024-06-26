<?php
declare(strict_types=1);

namespace app\common\exception;

use Throwable;
use RuntimeException;

class ApiException extends RuntimeException
{
    public function __construct($message, $code = 1, Throwable $previous = null)
    {
        parent::__construct($message, $code, $previous);
    }
}