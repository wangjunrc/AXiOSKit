#!/bin/sh
set -e
set -u
set -o pipefail

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
    # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
    # resources to, so exit 0 (signalling the script phase was successful).
    exit 0
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY:-}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_ROOT}/../../AXiOSTools/00Description/AXUIWebJSDemo/UIWebViewPage.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/00Description/AXWKWebJSDemo/AXWKWebJSDemoPage.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXChoosePay/Controller/AXChoosePayStyleVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXChoosePay/Controller/AXChoosePayVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXChoosePay/View/AXChoosePayStyleCell.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXDateVC/AXDateVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXGuidePageVC/AXGuidePageCell.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXGuidePageVC/AXGuidePageVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/AXQRCodeVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_border@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_border@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_navigationbar_background@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_scan_line.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode_highlighted@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode_highlighted@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode_highlighted@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode_highlighted@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/Root.plist"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeViewController.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXSafariVC/AXSafariVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXSinglePickVC/AXSinglePickVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXWebVC/AXWebVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/04AXView/AXNumberKeyboard/AXNumberKeyboard.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/06AXResources/www/axwkWebView.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/06AXResources/www/ax_ios.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/06AXResources/www/js/axwkWebView.js"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/error.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/error@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/success.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/success@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/warning.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/warning@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/warning@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/WKWebViewController/backItemImage@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/WKWebViewController/backItemImage_hl@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/WKWebViewController/WKJSPOST.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_none.imageset/ax_checkBox_none@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_none.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_select.imageset/ax_checkBox_select@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_select.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_close.imageset/ax_close@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_close.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_to_left.imageset/ax_to_left@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_to_left.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/微信.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/微信.imageset/微信@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/支付宝.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/支付宝.imageset/支付宝@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/ax_emptyData.imageset/ax_emptyData.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/ax_emptyData.imageset/ax_emptyData@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/ax_emptyData.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack.imageset/ax_itemBack@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack_h.imageset/ax_itemBack_h@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack_h.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_delete.imageset/ax_delete@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_delete.imageset/ax_delete@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_delete.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_resign.imageset/ax_resign@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_resign.imageset/ax_resign@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_resign.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/ax_error.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/ax_error@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/ax_error@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/ax_success.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/ax_success@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/ax_success@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/ax_warning.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/ax_warning@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/ax_warning@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets"
  install_resource "${PODS_ROOT}/GKPhotoBrowser/GKPhotoBrowser/GKPhotoBrowser.bundle"
  install_resource "${PODS_ROOT}/IQKeyboardManager/IQKeyboardManager/Resources/IQKeyboardManager.bundle"
  install_resource "${PODS_ROOT}/MJRefresh/MJRefresh/MJRefresh.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_ROOT}/../../AXiOSTools/00Description/AXUIWebJSDemo/UIWebViewPage.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/00Description/AXWKWebJSDemo/AXWKWebJSDemoPage.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXChoosePay/Controller/AXChoosePayStyleVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXChoosePay/Controller/AXChoosePayVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXChoosePay/View/AXChoosePayStyleCell.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXDateVC/AXDateVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXGuidePageVC/AXGuidePageCell.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXGuidePageVC/AXGuidePageVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/AXQRCodeVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_border@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_border@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_navigationbar_background@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_scan_line.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode_highlighted@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_barcode_highlighted@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode_highlighted@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/qrcode_tabbar_icon_qrcode_highlighted@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeResource/Root.plist"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXQRCodeVC/QRCodeViewController.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXSafariVC/AXSafariVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXSinglePickVC/AXSinglePickVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/03AXController/AXWebVC/AXWebVC.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/04AXView/AXNumberKeyboard/AXNumberKeyboard.xib"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/06AXResources/www/axwkWebView.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/06AXResources/www/ax_ios.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/01AXTools/06AXResources/www/js/axwkWebView.js"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/error.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/error@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/success.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/success@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/warning.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/warning@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/MBProgressHUD@AX/MBProgressHUD_AX.bundle/warning@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/WKWebViewController/backItemImage@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/WKWebViewController/backItemImage_hl@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/02ThirdTools/WKWebViewController/WKJSPOST.html"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_none.imageset/ax_checkBox_none@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_none.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_select.imageset/ax_checkBox_select@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_checkBox_select.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_close.imageset/ax_close@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_close.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_to_left.imageset/ax_to_left@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/ax_to_left.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/微信.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/微信.imageset/微信@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/支付宝.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Base/支付宝.imageset/支付宝@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/ax_emptyData.imageset/ax_emptyData.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/ax_emptyData.imageset/ax_emptyData@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/ax_emptyData.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/emptyData/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack.imageset/ax_itemBack@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack_h.imageset/ax_itemBack_h@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/ax_itemBack_h.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/item/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_delete.imageset/ax_delete@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_delete.imageset/ax_delete@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_delete.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_resign.imageset/ax_resign@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_resign.imageset/ax_resign@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/ax_resign.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/keyboard/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/ax_error.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/ax_error@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/ax_error@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_error.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/ax_success.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/ax_success@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/ax_success@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_success.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/ax_warning.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/ax_warning@2x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/ax_warning@3x.png"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/ax_warning.imageset/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets/MBProgressHUD/Contents.json"
  install_resource "${PODS_ROOT}/../../AXiOSTools/AXiOSTools.xcassets"
  install_resource "${PODS_ROOT}/GKPhotoBrowser/GKPhotoBrowser/GKPhotoBrowser.bundle"
  install_resource "${PODS_ROOT}/IQKeyboardManager/IQKeyboardManager/Resources/IQKeyboardManager.bundle"
  install_resource "${PODS_ROOT}/MJRefresh/MJRefresh/MJRefresh.bundle"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "${XCASSET_FILES:-}" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  if [ -z ${ASSETCATALOG_COMPILER_APPICON_NAME+x} ]; then
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  else
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${TARGET_TEMP_DIR}/assetcatalog_generated_info_cocoapods.plist"
  fi
fi
