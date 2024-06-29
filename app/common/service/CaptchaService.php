<?php
declare(strict_types=1);

namespace app\common\service;

use support\Redis;
use Ramsey\Uuid\Uuid;
use Webman\Captcha\PhraseBuilder;
use Webman\Captcha\CaptchaBuilder;

class CaptchaService
{
    private string $code; // 验证码
    private string $uuid; // 验证码唯一序号
    private string $charset = 'ABCDEFGHKMNPRSTUVWXYZ23456789'; // 随机因子
    private int $width = 130; // 图片宽度
    private int $height = 50; // 图片高度
    private int $length = 4; // 验证码长度
    private string $base64;

    // debug
    private string $mode = 'session'; // 验证码模式 redis / session
    private string $prefix = 'captcha_'; // 前缀
    private int $expire = 300; // 过期时间
    private bool $debug = false;
    private string $testValue = 'abcd';

    public function __construct(array $config = [])
    {
        // 动态配置属性
        foreach ($config as $k => $v) {
            if (isset($this->$k)) {
                $this->$k = $v;
            }
        }

        $this->debug = config('project.captcha.debug', false);
        $this->testValue = config('project.captcha.value', 'abcd');
        $this->mode = config('project.captcha.mode', 'redis');
        $this->prefix = config('project.captcha.prefix', 'captcha_');

        // 生成验证码序号
        $this->uuid = Uuid::uuid4()->toString();
        $builder = new PhraseBuilder($this->length, $this->charset);
        $captcha = new CaptchaBuilder(null, $builder);
        $captcha->setBackgroundColor(242, 243, 245);
        $captcha->build($this->width, $this->height);

        $key = $this->prefix . $this->uuid;
        $this->base64 = base64_encode($captcha->get());
        $this->code = strtolower($captcha->getPhrase());
        if ($this->mode === 'redis') {
            // 检测Redis
            check_redis();
            Redis::set($key, $this->code, 'EX', $this->expire);
        } else {
            session($key, $this->code);
        }
    }

    /**
     * @param bool $code 是否返回code
     * @return array
     */
    public function getAttrs(bool $code = false): array
    {
        $data = ['uuid' => $this->uuid, 'image' => $this->getBase64()];
        if ($code) {
            $data['code'] = $this->code;
        }

        return $data;
    }

    public function getBase64(): string
    {
        return 'data:image/png;base64,' . $this->base64;
    }

    /**
     * 检查验证码是否正确
     * @param string $uuid
     * @param string $captcha
     * @return bool
     */
    public function verify(string $uuid, string $captcha): bool
    {
        // 开启debug测试
        if ($this->debug && $this->testValue === $captcha) {
            return true;
        }

        $key = $this->prefix . $uuid;
        if ($this->mode === 'redis') {
            // 检测Redis
            check_redis();
            $code = Redis::get($key);
            Redis::del($key);
        } else {
            $code = session($key);
            request()->session()->forget($key);
        }

        return strtolower($captcha) === strval($code);
    }
}