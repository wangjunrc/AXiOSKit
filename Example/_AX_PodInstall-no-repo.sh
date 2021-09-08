#!/bin/sh

#脚本所在目录
BASEDIR=$(dirname $0)
cd $BASEDIR

echo "=========开始 pod install --no-repo-update ======="
#pod update --no-repo-update
pod install --no-repo-update
