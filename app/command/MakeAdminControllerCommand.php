<?php
declare(strict_types=1);

namespace app\command;

use Symfony\Component\Console\Command\Command;

class MakeAdminControllerCommand extends Command
{
    use TraitController, TraitMake;

    protected static $defaultName = 'make:admin:controller';
    protected static $defaultDescription = 'make admin controller';
    const MODULE_NAME = 'admin';
}