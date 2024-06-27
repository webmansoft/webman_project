<?php
declare(strict_types=1);

namespace app\command;

use Webman\Console\Util;
use app\common\library\FileHelper;
use app\common\library\DatabaseHelper;
use app\common\trait\TableFieldsTrait;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;

trait TraitCommon
{
    use TableFieldsTrait;

    /**
     * @return void
     */
    protected function configure(): void
    {
        $this->setName('make:common:' . self::TYPE_NAME)
            ->addArgument('name', InputArgument::REQUIRED, self::TYPE_NAME . ' name')
            ->addOption('force', 'f', 4, 'forced overlay');
    }

    /**
     * 格式化输入 name
     * @param string $table
     * @return array
     */
    protected function format(string $table): array
    {
        $class = trim($table);
        $path = 'app/common/' . self::TYPE_NAME;
        if (str_contains($class, '/')) {
            // 获取最后一个元素
            $dir_array = explode('/', $class);
            $class = array_pop($dir_array);
        }

        $dir = $this->getFirstDir($class);
        $file = $path . '/' . $dir . '/' . Util::nameToClass($class) . ucfirst(self::TYPE_NAME) . '.php';
        $namespace = 'app\\common\\' . self::TYPE_NAME . '\\' . $dir;
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
            $table_name = $table;
            $model_dir = $this->getFirstDir($class);
            $model_name = Util::nameToClass($class) . 'Model';
            $logic_name = Util::nameToClass($class) . 'Logic';
            $validate_name = Util::nameToClass($class) . 'Validate';
            $stub = file_get_contents($this->getStub($table_name));
            $data = str_replace(
                ['{%namespace%}', '{%model_dir%}', '{%model_name%}', '{%logic_name%}', '{%table_name%}', '{%validate_name%}', '{%current_time%}'],
                [$namespace, $model_dir, $model_name, $logic_name, $table_name, $validate_name, date('Y/m/d H:i:s')],
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
     * @param string $table_name
     * @return string
     */
    protected function getStub(string $table_name): string
    {
        $fields = $this->getCacheTableField($table_name);
        if (self::TYPE_NAME === 'model' && (isset($fields['delete_time']) || isset($fields['deleted_at']))) {
            return app_path('command') . DIRECTORY_SEPARATOR . 'stubs' . DIRECTORY_SEPARATOR . self::TYPE_NAME . '_soft_delete.stub';
        }

        return app_path('command') . DIRECTORY_SEPARATOR . 'stubs' . DIRECTORY_SEPARATOR . self::TYPE_NAME . '.stub';
    }

    /**
     * 获取第一个目录
     * @param string $class
     * @return string
     */
    protected function getFirstDir(string $class): string
    {
        // 获取表中第一个词
        $dir = $class;
        if (str_contains($class, '_')) {
            $path_array = explode('_', $class);
            $dir = $path_array[0];
        }

        return $dir;
    }
}