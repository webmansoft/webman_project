<?php
declare(strict_types=1);

namespace app\command;

use Symfony\Component\Console\Command\Command;

class MakeBackendControllerCommand extends Command
{
    use TraitController, TraitMake;

    protected static $defaultName = 'make:backend:controller';
    protected static $defaultDescription = 'make backend controller';
    const MODULE_NAME = 'backend';
}
