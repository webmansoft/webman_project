php webman config:mysql

生成模型
php webman make:common:model

生成验证器
php webman make:common:validate

生成逻辑器
php webman make:common:logic

生成admin控制器
php webman make:admin:controller

生成api控制器
php webman make:api:controller

单个生成
php webman make:common:model user
php webman make:common:validate user
php webman make:common:logic user
php webman make:admin:controller user
php webman make:api:controller user

多个生成 用英文逗号隔开
php webman make:common:model article,user,system_user
php webman make:common:validate article,user,system_user
php webman make:common:logic article,user,system_user
php webman make:admin:controller article,user,system_user
php webman make:api:controller article,user,system_user

全部生成
php webman make:common:model all
php webman make:common:validate all
php webman make:common:logic all
php webman make:admin:controller all
php webman make:api:controller all

文件已存在 强制覆盖
-f 1
--force 1
php webman make:common:model all -f 1
php webman make:common:validate all -f 1
php webman make:common:logic all -f 1
php webman make:admin:controller all -f 1
php webman make:api:controller all -f 1

测试不存在数据表
php webman make:common:model articles
php webman make:common:validate articles
php webman make:common:logic articles
php webman make:admin:controller articles
php webman make:api:controller articles

php webman make:common:model article/article,article/article_category

php webman make:common:validate article/article,article/article_category

php webman make:common:logic article/article,article/article_category

php webman make:admin:controller article/article,article/article_category

php webman make:api:controller article/article,article/article_category
