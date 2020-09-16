#!/bin/bash

echo "✅  ==========APPicon添加版本号开始=========="
#######################################################
# 1、检查是否安装了ImageMagick
#######################################################
echo "🐛 Checking installed ImageMagick"

convertPath=`which convert`

if [[ ! -f ${convertPath} || -z ${convertPath} ]]; then
    convertValidation=true;
else
    convertValidation=false;
fi

# 未安装 提示并退出
if [ "$convertValidation" == true ]; then
    echo "❌ ImageMagick 未安装,请使用命令安装\n brew  install  imagemagick"
    exit 0;
else
    echo "✅ ImageMagick 已安装"
fi

 
######################################################
# 2. 全局字段
######################################################

echo "😀Product Name: ${PRODUCT_NAME}"
echo "😀Bundle Identifier: ${BUNDLE_IDENTIFIER}"
echo "😀Version: ${MARKETING_VERSION}"
echo "😀Build: ${CURRENT_PROJECT_VERSION}"


# Assets中的appIcon文件名
APPICON_NAME="AppIcon"

# Assets中Debug环境的appIcon文件名
DEBUG_APPICON_NAME="${APPICON_NAME}-Debug"

# # 获取app版本号
# APP_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "${INFOPLIST_FILE}")

# # 获取build号
# APP_BUILD_NUM=$(/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' "${INFOPLIST_FILE}")

# xcode11 最新写法
# 获取app版本号
APP_VERSION="$MARKETING_VERSION"

# 获取build号
APP_BUILD_NUM="$CURRENT_PROJECT_VERSION"

# Icon上显示的文字内容, 你可以在这里修改标题格式
CAPTION="$APP_VERSION\n($APP_BUILD_NUM)"


echo "😀 DEBUG_APPICON_NAME=$DEBUG_APPICON_NAME"
echo "😀 版本号=$APP_VERSION"
echo "😀 编译号=$APP_BUILD_NUM"


######################################################
# 3. 复制AppIcon到AppIcon-Debug
######################################################
echo "🐛 Begin copy icon files"

# appicon路径
APPICON_SET_PATH=`find $SRCROOT -name "${APPICON_NAME}.appiconset"`

echo "🐛 APPICON_SET_PATH=$APPICON_SET_PATH"
if [ "$APPICON_SET_PATH" = "" ]; then
    exitWithMessage "❌  Get APPICON_SET_PATH failed." 0
fi

# appicon_debug路径
ASSET_PATH=`echo $(dirname ${APPICON_SET_PATH})`
DEBUG_APPICON_SET_PATH="${ASSET_PATH}/${DEBUG_APPICON_NAME}.appiconset"
echo "🐛 DEBUG_APPICON_SET_PATH=$DEBUG_APPICON_SET_PATH"
if [ "$DEBUG_APPICON_SET_PATH" = "" ]; then
    exitWithMessage "❌  Get DEBUG_APPICON_SET_PATH failed." 0
fi


# 删除appicon_debug里的文件
rm -rf $DEBUG_APPICON_SET_PATH
if [ $? != 0 ];then
    exitWithMessage "❌  Remove ${DEBUG_APPICON_SET_PATH} failed." 0
fi

# 复制appicon到appicon_debug
cp -rf $APPICON_SET_PATH $DEBUG_APPICON_SET_PATH
if [ $? != 0 ];then
    exitWithMessage "❌  Copy ${APPICON_NAME} to ${DEBUG_APPICON_NAME} failed." 0
fi


echo "✅  Finish copy icon files."



# # 处理icon,添加水印
# # Processing icon
function processIcon() {

BASE_IMAGE_PATH=$1
echo "BASE_IMAGE_PATH=$BASE_IMAGE_PATH"

BASE_FLODER_PATH=`dirname $BASE_IMAGE_PATH`
cd "$BASE_FLODER_PATH"

# 获取图片宽度
WIDTH=$(identify -format %w ${BASE_IMAGE_PATH})
echo "width $WIDTH"

FONT_SIZE=$(echo "$WIDTH * .15" | bc -l)
echo "font size $FONT_SIZE"

convert ${BASE_IMAGE_PATH}  -font Arial  -pointsize ${FONT_SIZE} \
-draw "gravity south \
fill white  text 0,12 '$APP_VERSION($APP_BUILD_NUM)'" \
${BASE_IMAGE_PATH}


}



#######################################################
# 4. 处理AppIcon-Debug
#######################################################
find "$DEBUG_APPICON_SET_PATH" -type f -name "*.png" -print0 |

while IFS= read -r -d '' file; do

echo "🐛🐛 ${file}"
# 调用 processIcon 方法
processIcon "${file}"

done

echo "✅  ==========APPicon添加版本号结束=========="



