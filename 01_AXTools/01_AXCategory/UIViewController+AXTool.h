//
//  UIViewController+AXTool.h
//  AXTools
//
//  Created by Mole Developer on 16/6/15.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXConstant.h"

@interface UIViewController (AXTool)

/**
 * 保存图片到系统相册
 */
- (void)ax_saveImageToPhotos:(UIImage*)image;

/**
 * 导航栏 push 到vc
 */
-(void)ax_navigationControllerPush:(Class)aClass block:(void(^)(id vc))blockVC;

/**
 * 当前控制器是否在显示,也可以直接使用
 */
-(BOOL)ax_isViewShow;

/**
 * 当前控制器
 */
+(UIViewController *)ax_currentViewController;

/**
 * AFN 中的 pageIndex
 */
@property (nonatomic, assign) NSInteger pageIndex;

/**
 *
 */
@property (nonatomic, copy) AXBackBlock  backBlock;
/**
 * 回调方法
 */
-(void)ax_backObjBlock:(void(^)(id obj))backBlock;

/**
 *
 */
@property (nonatomic, copy) AXBackBlockDict  ax_backBlockDict;

/**
 * 回调一个字典
 */
-(void)ax_backDictBlock:(void(^)(NSDictionary *dict))backBlock;

/**
 * <#注释#>
 */
@property (nonatomic, strong)UIViewController  *ax_popVC;

@end
