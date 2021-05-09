//
//  DLSharePopView.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXShareOption.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXSocialShareView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

/// 白色背景
@property(nonatomic,strong)UIView *contentView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSArray<AXShareOption*> *dataArray;

@property(nonatomic, strong) UIButton *cancelButton;

/// 列数,一排中的个数
@property(nonatomic, assign) int column;


@end

NS_ASSUME_NONNULL_END
