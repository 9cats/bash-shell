#!/bin/bash
# 功能：在 ~/APP 下创建一个 blog 文件夹存放空的git仓库
# 执行脚本的用户最好是 ubuntu (非root)

dirName="blog"

cd ~ #先切换到用户目录目录

# 判断是否有APP文件夹
if [ ! -d "APP" ]; then
  mkdir APP
fi

# 判断是否有blog文件夹，没有再创建该仓库
if [ ! -d "APP/${dirName}" ]; then
  mkdir APP/${dirName} && cd $_ # 创建文件夹并进入
  git init --bare ./${dirName}.git  # 创建空的仓库
  # 写入钩子函数
  echo '#!/bin/bash'                                               > ${dirName}.git/hooks/post-receive #声明类型
  echo 'cd ..'                                                    >> ${dirName}.git/hooks/post-receive #先返回上一级
  echo "git --work-tree=. --git-dir=./${dirName}.git checkout -f" >> ${dirName}.git/hooks/post-receive #签出
  
  chmod +x ${dirName}.git/hooks/post-receive # 赋予可执行权限
fi