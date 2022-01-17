#!/bin/bash
# 功能：在 ~ 下创建一个 APP 目录用于存放docker部署的项目
# 添加远程仓库示例: git remote add origin ubuntu@9cats.link:~/APP/.git
# 注意：部署后还需要手动再更新容器（防止又运行了不改运行的）

cd ~ #先切换到用户目录目录

# 判断是否有APP文件夹
if [ ! -d "APP" ]; then
  mkdir APP && cd $_ # 新建文件夹并加入
  git init --bare .git  # 创建空的仓库
  echo '#!/bin/bash'                                   > .git/hooks/post-receive #声明类型
  echo 'cd ..'                                        >> .git/hooks/post-receive #先返回上一级
  echo "git --work-tree=. --git-dir=.git checkout -f" >> .git/hooks/post-receive #签出

  chmod +x .git/hooks/post-receive # 赋予可执行权限
fi