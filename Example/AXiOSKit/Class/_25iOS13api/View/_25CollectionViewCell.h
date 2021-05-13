//
//  _25CollectionViewCell.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "_25DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface _25CollectionViewCell : UICollectionViewCell<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UIButton *addBtn;


@property(nonatomic,copy) void(^btnHandler)(UIButton *addBtn);

@property(nonatomic, strong) _25DataModel *model;



@end

NS_ASSUME_NONNULL_END
