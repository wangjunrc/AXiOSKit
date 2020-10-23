#!/bin/bash
if [ ${CONFIGURATION} = "Release" ]; then
cp -r ${PROJECT_DIR}/${PROJECT_NAME}/Settings.bundle ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app
#cp -r ${PROJECT_DIR}/Settings.bundle ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app
fi
 
if [ ${CONFIGURATION} = "Debug" ]; then
cp -r ${PROJECT_DIR}/${PROJECT_NAME}/Settings.bundle ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app
fi
