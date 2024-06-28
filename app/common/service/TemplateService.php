<?php
declare(strict_types=1);

namespace app\common\service;

use app\common\exception\ApiException;

class TemplateService
{
    private array $config = [
        'templateDir' => 'template', // 模板所在的文件夹
        'compileDir' => 'template', // 编译后存放的目录
        'genDir' => 'saiadmin', // 编译后存放的目录
        'cache_time' => 7200, // 设置多长时间自动更新
        'cache' => true, // 是否需要缓存
    ];

    public string $file; // 模板文件名,不带路径
    private array $value = []; // 值栈
    private CompileService $compileTool; // 编译器


    /**
     * 构造函数
     * @param string $path
     * @throws ApiException
     */
    public function __construct(string $path = 'template')
    {
        // 获取模板文件夹
        $this->config['templateDir'] = base_path($path);
        if (!is_dir($this->config['templateDir'])) {
            // 抛出异常
            throw new ApiException('模板目录不存在');
        }

        // 运行时目录
        $runPath = runtime_path();
        $this->config['compileDir'] = $runPath . DIRECTORY_SEPARATOR . $this->config['compileDir'];
        // 创建模板缓存目录
        if (!is_dir($this->config['compileDir'])) {
            if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
                mkdir($this->config['compileDir']);
            } else {
                mkdir($this->config['compileDir'], 0770, true);
            }
        }

        $this->config['genDir'] = $runPath . DIRECTORY_SEPARATOR . $this->config['genDir'];
        // 创建文件生成目录
        if (!is_dir($this->config['genDir'])) {
            if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
                mkdir($this->config['genDir']);
            } else {
                mkdir($this->config['genDir'], 0770, true);
            }
        }
    }

    /**
     * 单独设置引擎参数
     * 也支持一次性设置多个参数
     */
    public function setConfig($key, $value = null): void
    {
        $this->config[$key] = $value;
    }

    /**
     * 注入单个变量
     */
    public function assign($key, $value): void
    {
        $this->value[$key] = $value;
    }

    /**
     * 注入数组变量
     */
    public function assignArray($array): void
    {
        if (is_array($array)) {
            foreach ($array as $k => $v) {
                $this->value[$k] = $v;
            }
        }
    }

    /**
     * 预览文件
     * @throws ApiException
     */
    public function show($file): bool|string
    {
        $this->file = $this->config['templateDir'] . DIRECTORY_SEPARATOR . $file;
        if (!is_file($this->file)) {
            // 抛出异常
            throw new ApiException('找不到对应模板文件');
        }

        $compileFile = $this->config['compileDir'] . DIRECTORY_SEPARATOR . md5($file) . '.php';
        $this->compileTool = new CompileService($this->file, $compileFile, $this->config['genDir']);
        extract($this->value);
        $this->compileTool->setValue($this->value);
        return $this->compileTool->compile();
    }

    /**
     * 生成文件
     * @throws ApiException
     */
    public function gen($file, $outFile): void
    {
        $this->file = $this->config['templateDir'] . DIRECTORY_SEPARATOR . $file;
        if (!is_file($this->file)) {
            // 抛出异常
            throw new ApiException('找不到对应模板文件!');
        }

        $compileFile = $this->config['compileDir'] . DIRECTORY_SEPARATOR . md5($file) . '.php';
        $this->compileTool = new CompileService($this->file, $compileFile, $this->config['genDir']);
        extract($this->value);
        $this->compileTool->setValue($this->value);
        $this->compileTool->gen($outFile);
    }
}
