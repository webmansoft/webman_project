<?php
declare(strict_types=1);

namespace app\backend\controller\system;

use support\Request;
use support\Response;
use PhpOffice\PhpSpreadsheet\Exception;
use app\common\base\BaseApiController;
use app\common\logic\system\SystemPostLogic;

class SystemPostController extends BaseApiController
{
    public function __construct()
    {
        $this->logic = new SystemPostLogic();
        parent::__construct();
    }

    /**
     * 数据列表
     * @param Request $request
     * @return Response
     */
    public function index(Request $request) : Response
    {
        $condition = [
            ['status'],
            'like' => ['name','code'],
            'betweenDate' => ['create_time']
        ];
        $query = $this->logic->search($condition);
        $data = $this->logic->getQueryList($query);
        return $this->successData($data);
    }

    /**
     * 下载导入模板
     * @return Response
     */
    public function downloadTemplate(): Response
    {
        $file_name = 'template.xls';
        return download_file($file_name);
    }

    /**
     * 导入数据
     * @param Request $request
     * @return Response
     */
    public function import(Request $request) : Response
    {
        $file = current($request->file());
        if ($file && $file->isValid()) {
            $this->logic->import($file);
            return $this->success('导入成功');
        }

        return $this->fail('未找到上传文件');
    }

    /**
     * 导出数据
     * @param Request $request
     * @return Response
     * @throws Exception
     */
    public function export(Request $request) : Response
    {
        $condition = [
            ['status'],
            'like' => ['name','code']
        ];
        return $this->logic->export($condition);
    }
}