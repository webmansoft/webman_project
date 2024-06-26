<?php
declare(strict_types=1);

namespace app\command;

use Symfony\Component\Console\Command\Command;

class MakeCommonModelCommand extends Command
{
    use TraitCommon, TraitMake;

    protected static $defaultName = 'make:common:model';
    protected static $defaultDescription = 'make common model';
    const TYPE_NAME = 'model';
}
