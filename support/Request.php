<?php
declare(strict_types=1);

namespace support;

class Request extends \Webman\Http\Request
{
    /**
     * 获取格式化条件参数
     * [['test1','test2'], 'in' => ['test1','test2'], 'like' => ['origin_name','name'], 'between' => ['created_at']]
     * @param array $data
     * @return array
     */
    public function formatInput(array $data): array
    {
        $where = [];
        $rules = ['>', '>=', '=', '<', '<=', '<>', 'like', 'notLike', 'in', 'notIn', 'null', 'notNull', 'betweenDate', 'between'];
        foreach ($data as $rule => $fields) {
            if (in_array($rule, $rules)) {
                foreach ($fields as $field) {
                    $value = $this->input($field, '');
                    if (is_string($value)) {
                        $value = trim($value);
                    }

                    if ($value) {
                        $where[$rule][$field] = $value;
                    }
                }
            } else {
                foreach ($fields as $field) {
                    $value = $this->input($field, '');
                    if (is_string($value)) {
                        $value = trim($value);
                    }

                    if ($value) {
                        $where['='][$field] = $value;
                    }
                }
            }
        }

        return $where;
    }

    /**
     * 等于 =
     * @param array $fields
     * @return array
     */
    public function inputEqual(array $fields): array
    {
        return $this->formatInput([$fields]);
    }

    /**
     * 大于 >
     * @param array $fields
     * @return array
     */
    public function inputGreaterThan(array $fields): array
    {
        return $this->formatInput(['>' => $fields]);
    }

    /**
     * 大于等于 >=
     * @param array $fields
     * @return array
     */
    public function inputGreaterThanOrEqual(array $fields): array
    {
        return $this->formatInput(['>=' => $fields]);
    }

    /**
     * 小于 <
     * @param array $fields
     * @return array
     */
    public function inputLessThan(array $fields): array
    {
        return $this->formatInput(['<' => $fields]);
    }

    /**
     * 小于等于 <=
     * @param array $fields
     * @return array
     */
    public function inputLessThanOrEqual(array $fields): array
    {
        return $this->formatInput(['<=' => $fields]);
    }

    /**
     * 不等于 <>
     * @param array $fields
     * @return array
     */
    public function inputNotEqual(array $fields): array
    {
        return $this->formatInput(['<>' => $fields]);
    }

    public function inputIn(array $fields): array
    {
        return $this->formatInput(['in' => $fields]);
    }

    public function inputNotIn(array $fields): array
    {
        return $this->formatInput(['notIn' => $fields]);
    }

    public function inputLike(array $fields): array
    {
        return $this->formatInput(['like' => $fields]);
    }

    public function inputNotLike(array $fields): array
    {
        return $this->formatInput(['notLike' => $fields]);
    }

    public function inputBetween(array $fields): array
    {
        return $this->formatInput(['between' => $fields]);
    }

    public function inputBetweenDate(array $fields): array
    {
        return $this->formatInput(['betweenDate' => $fields]);
    }

    /**
     * 去除POST左右空格
     * @param string|null $name
     * @param mixed $default
     * @return mixed
     */
    public function post($name = null, $default = null): mixed
    {
        if (!isset($this->_data['post'])) {
            $this->parsePost();
        }

        if (null === $name) {
            $postData = [];
            foreach ($this->_data['post'] as $item => $value) {
                if (is_string($value)) {
                    $value = trim($value);
                }

                $postData[$item] = $value;
            }

            return $postData;
        }

        if (isset($this->_data['post'][$name])) {
            $value = $this->_data['post'][$name];
            if (is_string($value)) {
                return trim($value);
            }

            return $value;
        } else {
            return $default;
        }
    }

    /**
     * 是否为POST请求
     * @return bool
     */
    public function isPost(): bool
    {
        return $this->method() == 'POST';
    }

    /**
     * 是否为PUT请求
     * @return bool
     */
    public function isPut(): bool
    {
        return $this->method() == 'PUT';
    }

    /**
     * 检测是否使用手机访问
     * @return bool
     */
    public function isMobile(): bool
    {
        if (request()->header('HTTP_VIA') && stristr(request()->header('HTTP_VIA'), 'wap')) {
            return true;
        }

        if (request()->header('accept') && strpos(strtoupper(request()->header('accept')), 'VND.WAP.WML')) {
            return true;
        }

        if (request()->header('HTTP_X_WAP_PROFILE') || request()->header('HTTP_PROFILE')) {
            return true;
        }

        if (request()->header('user-agent') && preg_match('/(blackberry|configuration\/cldc|hp |hp-|htc |htc_|htc-|iemobile|kindle|midp|mmp|motorola|mobile|nokia|opera mini|opera |Googlebot-Mobile|YahooSeeker\/M1A1-R2D2|android|iphone|ipod|mobi|palm|palmos|pocket|portalmmm|ppc;|smartphone|sonyericsson|sqh|spv|symbian|treo|up.browser|up.link|vodafone|windows ce|xda |xda_)/i', request()->header('user-agent'))) {
            return true;
        }

        return false;
    }

    public function server($name = null)
    {
        return $name ? ($_SERVER[$name] ?? null) : $_SERVER;
    }

    /**
     * 当前是否ssl
     * @return bool
     */
    public function isSsl(): bool
    {
        if ($this->server('HTTPS') && ('1' == $this->server('HTTPS') || 'on' == strtolower($this->server('HTTPS')))) {
            return true;
        } elseif ('https' == $this->server('REQUEST_SCHEME')) {
            return true;
        } elseif ('443' == $this->server('SERVER_PORT')) {
            return true;
        } elseif ('https' == $this->server('HTTP_X_FORWARDED_PROTO')) {
            return true;
        }

        return false;
    }

    /**
     * 当前URL地址中的scheme参数
     * @return string
     */
    public function scheme(): string
    {
        return $this->isSsl() ? 'https' : 'http';
    }

    /**
     * 获取当前包含协议的域名
     * @param bool $port 是否需要去除端口号
     * @return string
     */
    public function domain(bool $port = false): string
    {
        return $this->scheme() . '://' . $this->host($port);
    }

    /**
     * 获取当前根域名
     * @return string
     */
    public function rootDomain(): string
    {
        $item = explode('.', request()->host());
        $count = count($item);
        return $count > 1 ? $item[$count - 2] . '.' . $item[$count - 1] : $item[0];
    }

    /**
     * 获取当前子域名
     * @return string
     */
    public function subDomain(): string
    {
        $rootDomain = request()->rootDomain();
        if ($rootDomain) {
            $sub = stristr(request()->host(), $rootDomain, true);
            $subDomain = $sub ? rtrim($sub, '.') : '';
        } else {
            $subDomain = '';
        }

        return $subDomain;
    }
}