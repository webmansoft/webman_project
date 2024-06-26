<?php
declare(strict_types=1);

namespace app\command;

use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;
use Webman\Console\Util;
use app\common\library\FileHelper;
use app\common\library\DatabaseHelper;

trait TraitController
{
    /**
     * @return void
     */
    protected function configure(): void
    {
        $this->setName('make:' . self::MODULE_NAME . ':controller')
            ->addArgument('name', InputArgument::REQUIRED, self::MODULE_NAME . ' controller name')
            ->addOption('force', 'f', 4, 'forced overlay');
    }

    /**
     * 格式化输入 name
     * @param string $class
     * @return array
     */
    protected function format(string $class): array
    {
        $class = trim(trim(Util::nameToClass($class)), '/');
        if (str_contains($class, '/')) {
            $path = 'app/' . self::MODULE_NAME . '/controller';
            $path_array = explode('/', $class);
            $class = ucfirst(array_pop($path_array));
            $file = $path . '/' . join('/', $path_array) . '/' . $class . config('app.controller_suffix') . '.php';
            $namespace = str_replace('/', '\\', $path . '/' . join('/', $path_array));
        } else {
            $file = 'app/' . self::MODULE_NAME . '/controller/' . $class . config('app.controller_suffix') . '.php';
            $namespace = 'app\\' . self::MODULE_NAME . '\\controller';
        }

        return [$namespace, $class, $file];
    }

    /**
     * @param OutputInterface $output
     * @param string $namespace
     * @param string $class
     * @param string $file
     * @param bool $force
     * @return void
     */
    protected function create(OutputInterface $output, string $namespace, string $class, string $file, bool $force = false): void
    {
        $path = pathinfo($file, PATHINFO_DIRNAME);
        if (!is_dir($path)) {
            mkdir($path, 0777, true);
        }

        $table = Util::classToName($class);
        $result = DatabaseHelper::getTables($table, 'table');
        // 数据表存在就生成 否则不会生成
        if ($result) {
            $logic_use = 'use app\\common\\logic\\' . $class . 'Logic';
            $logic_name = $class . 'Logic';
            $validate_use = 'use app\\common\\validate\\' . $class . 'Validate';
            $validate_name = $class . 'Validate';
            $controller_name = $class . config('app.controller_suffix');
            $stub = file_get_contents($this->getStub());
            $data = str_replace(
                ['{%namespace%}', '{%logic_use%}', '{%validate_use%}', '{%controller_name%}', '{%logic_name%}', '{%validate_name%}', '{%current_time%}'],
                [$namespace, $logic_use, $validate_use, $controller_name, $logic_name, $validate_name, date('Y/m/d H:i:s')],
                $stub
            );
            if (is_file($file)) {
                if ($force) {
                    // 覆盖前备份一次
                    if (FileHelper::backup($file, date('Y-m-d') . '-', '.bk')) {
                        $this->make($output, $file, $data);
                    }
                } else {
                    $output->writeln($file . ' 文件已存在，请删除后生成');
                }
            } else {
                $this->make($output, $file, $data);
            }
        } else {
            $output->writeln($table . ' 数据表不存在');
        }
    }

    protected function make(OutputInterface $output, string $file, string $data): void
    {
        $result = file_put_contents($file, $data);
        if ($result) {
            $output->writeln($file . ' 文件生成成功');
        } else {
            $output->writeln($file . ' 文件生成失败');
        }

        $output->writeln("\n");
    }

    /**
     * 获取文件路径字符串
     * @return string
     */
    protected function getStub(): string
    {
        return app_path('command') . DIRECTORY_SEPARATOR . 'stubs' . DIRECTORY_SEPARATOR . self::MODULE_NAME . '_controller.stub';
    }
}