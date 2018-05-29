//
//  AXSinglePickVC.h
//  BigApple
//
//  Created by liuweixing on 2016/10/21.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXBaseAlertVC.h"
@interface AXSinglePickVC : AXBaseAlertVC

/**
 单选
 
 @param dataArray 内容
 @param row 当前显示的row
 @param block 回调
 */
-(void)didSelected:(NSArray <NSString *>*)dataArray showRow:(NSInteger )row block:(void(^)(NSInteger index))block;

@end
