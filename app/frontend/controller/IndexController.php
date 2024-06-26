<?php
declare(strict_types=1);

namespace app\frontend\controller;

use support\Request;
use support\Response;

class IndexController
{
    public function index(Request $request): Response
    {
        return view('index.index', ['name' => 'webman']);
    }
}
