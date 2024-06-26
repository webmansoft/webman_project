<?php
declare(strict_types=1);

namespace app\command;

use Symfony\Component\Console\Command\Command;

class MakeCommonLogicCommand extends Command
{
    use TraitCommon, TraitMake;

    protected static $defaultName = 'make:common:logic';
    protected static $defaultDescription = 'make common logic';
    const TYPE_NAME = 'logic';
}
