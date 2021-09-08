#!/bin/sh

#脚本所在目录
BASEDIR=$(dirname $0)
cd $BASEDIR

echo "=========开始 pod install --repo-update ======="
pod install --repo-update
