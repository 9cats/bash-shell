#!/bin/bash
#--------------------------------------------
# 参考文章:  https://www.jb51.net/article/216148.htm
#--------------------------------------------

sudo groupadd docker          #添加docker用户组
sudo gpasswd -a $USER docker  #将当前用户添加至docker用户组
newgrp docker                 #更新docker用户组