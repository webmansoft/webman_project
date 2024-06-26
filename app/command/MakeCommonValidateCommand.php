<?php
declare(strict_types=1);

namespace app\command;

use Symfony\Component\Console\Command\Command;

class MakeCommonValidateCommand extends Command
{
    use TraitCommon, TraitMake;

    protected static $defaultName = 'make:common:validate';
    protected static $defaultDescription = 'make common validate';
    const TYPE_NAME = 'validate';
}
