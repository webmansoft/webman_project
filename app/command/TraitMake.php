<?php
declare(strict_types=1);

namespace app\command;

use app\common\library\DatabaseHelper;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

trait TraitMake
{
    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $name = $input->getArgument('name');
        $force = false;
        if ($input->hasOption('force')) {
            $force = boolval($input->getOption('force'));
        }

        if ($name === 'all') {
            $this->makeAll($output, $force);
        } else {
            $tables = explode(',', $name);
            foreach ($tables as $table) {
                list($namespace, $class, $file) = $this->format($table);
                $this->create($output, $namespace, $class, $file, $force);
            }
        }

        return self::SUCCESS;
    }

    protected function makeAll(OutputInterface $output, bool $force = false): void
    {
        $prefix = config('database.connections.mysql.prefix') ?? '';
        $tables = DatabaseHelper::getTables();
        foreach ($tables as $table) {
            $table = $prefix ? str_replace($prefix, '', $table) : $table;
            list($namespace, $class, $file) = $this->format($table);
            $this->create($output, $namespace, $class, $file, $force);
        }
    }
}