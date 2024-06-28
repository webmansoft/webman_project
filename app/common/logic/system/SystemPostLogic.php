<?php
declare(strict_types=1);

namespace app\common\logic\system;

use PhpOffice\PhpSpreadsheet\Exception;
use PhpOffice\PhpSpreadsheet\IOFactory;
use support\Response;
use app\common\base\BaseLogic;
use app\common\service\ExcelService;
use app\common\exception\ApiException;
use app\common\model\system\SystemPostModel;

class SystemPostLogic extends BaseLogic
{
    public function __construct()
    {
        $this->model = new SystemPostModel();
    }

    /**
     * 导入数据
     */
    public function import($file): void
    {
        $path = $this->getImport($file);
        $spreadsheet = IOFactory::load($path);
        try {
            $sheet = $spreadsheet->getSheet(0);
            $highest_row = $sheet->getHighestRow(); // 取得总行数
            $data = [];
            for ($i = 2; $i <= $highest_row; $i++) {
                $data[] = [
                    'name' => $sheet->getCellByColumnAndRow(1, $i)->getValue(),
                    'code' => $sheet->getCellByColumnAndRow(2, $i)->getValue(),
                    'sort' => $sheet->getCellByColumnAndRow(3, $i)->getValue(),
                    'status' => $sheet->getCellByColumnAndRow(4, $i)->getValue(),
                ];
            }
            $this->insert($data);
        } catch (Exception $e) {
            throw new ApiException('导入文件错误：' . $e->getMessage());
        }
    }

    /**
     * 导出数据
     * @throws Exception
     */
    public function export($where = []): Response
    {
        $query = $this->search($where, ['id', 'name', 'code', 'sort', 'status', 'create_time']);
        $data = $this->getQueryList($query);
        $file_name = '岗位数据.xlsx';
        $header = ['编号', '岗位名称', '岗位标识', '排序', '状态', '创建时间'];
        $title = pathinfo($file_name, PATHINFO_FILENAME);
        $instance = new ExcelService();
        $file_path = $instance->setTitle($title)
            ->setContent($header, $data)
            ->saveFile($file_name, true);
        return response()->download($file_path, urlencode($file_name));
    }
}