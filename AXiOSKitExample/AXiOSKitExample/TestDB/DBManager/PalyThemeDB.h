//
//  PalyThemeDB.h
//  BigApple
//
//  Created by liuweixing on 2018/1/17.
//  Copyright © 2018年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAThemeListModel.h"
#import "DBFunctionProtocol.h"
#import <AXiOSKit/AXiOSKit.h>

/**
 * 播放记录 数据保存
 */
@interface PalyThemeDB : NSObject<DBFunctionProtocol>

axShared_H(PalyThemeDB);

@end

