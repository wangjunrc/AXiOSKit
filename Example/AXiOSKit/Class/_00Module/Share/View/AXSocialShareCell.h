//
//  DLSharePopCell.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXShareOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXSocialShareCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) AXShareOption *action;

@end

NS_ASSUME_NONNULL_END
