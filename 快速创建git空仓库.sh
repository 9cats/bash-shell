#!/bin/bash
# 功能：在 ~/APP 下创建一个 blog 文件夹存放空的git仓库
# 执行脚本的用户最好是 ubuntu (非root)
# 添加远程仓库示例: git remote add origin ubuntu@9cats.link:~/APP/www/blog/.git

name="blog"

cd ~ #先切换到用户目录目录

# 判断是否有APP文件夹
if [ ! -d "APP" ]; then
  mkdir APP
fi

# 判断是否有www文件夹
if [ ! -d "APP/www" ]; then
  mkdir APP/www
fi

# 判断是否有blog文件夹，没有再创建该仓库
if [ ! -d "APP/www/${name}" ]; then
  mkdir APP/www/${name} && cd $_ # 创建文件夹并进入
  git init --bare .git  # 创建空的仓库
  # 写入钩子函数
  echo '#!/bin/bash'                                   > .git/hooks/post-receive #声明类型
  echo 'cd ..'                                        >> .git/hooks/post-receive #先返回上一级
  echo "git --work-tree=. --git-dir=.git checkout -f" >> .git/hooks/post-receive #签出
  
  chmod +x .git/hooks/post-receive # 赋予可执行权限
fi