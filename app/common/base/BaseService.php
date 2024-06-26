<?php
declare(strict_types=1);

namespace app\common\base;

use Webman\Container;
use Webman\Exception\NotFoundException;

abstract class BaseService
{
    /**
     * 静态实例对象
     * @param array $var
     * @return static
     * @throws NotFoundException
     */
    public static function mk(array $var = []): static
    {
        return (new Container())->make(static::class, $var);
    }
}