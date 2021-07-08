//
//  _30TimeLinetContentController.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import "_30TimeLineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface _30TimeLinetContentController : IGListSectionController

@property(nonatomic,strong)_30TimeLineModel *model;

@end

NS_ASSUME_NONNULL_END
