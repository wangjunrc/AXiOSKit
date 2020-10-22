//
//  AXChoosePayModel.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@interface AXChoosePayModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)UIImage *iconImage;

@property(nonatomic,assign,getter=isSelect)BOOL select;


@end
