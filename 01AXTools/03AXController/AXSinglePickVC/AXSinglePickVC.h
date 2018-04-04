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

-(void)didSelected:(NSArray <NSString *>*)dataArray block:(void(^)(NSInteger index))block;


@end
