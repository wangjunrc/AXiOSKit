//
//  _30TimeLineModel.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
//#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface _30TimeLineModel : NSObject<IGListDiffable>


/// 模型id
@property (nonatomic,copy) NSString *modelid;

/// 背景图
@property (nonatomic,copy) NSString *headImage;

/// 用户头像
@property (nonatomic,copy) NSString *headAvatar;

/// 用户名称
@property (nonatomic,copy) NSString *headUserName;

/// 列表图片
@property (nonatomic,copy) NSString *limage;

/// 列表用户头像
@property (nonatomic,copy) NSString *lavatar;

/// 列表用户名
@property (nonatomic,copy) NSString *luserName;

/// 列表内容
@property (nonatomic,copy) NSString *lcontent;

/// 列表位置
@property (nonatomic,copy) NSString *llocation;

/// 列表时间
@property (nonatomic,copy) NSString *lpublicTime;


@end

NS_ASSUME_NONNULL_END
