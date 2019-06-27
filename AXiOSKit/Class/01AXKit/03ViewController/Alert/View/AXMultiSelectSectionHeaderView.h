//
//  AXMultiSelectSectionHeaderView.h
//  AXiOSKit
//
//  Created by AXing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMultiSelectSectionHeaderView : UICollectionReusableView

@property(nonatomic, strong) UILabel *titleLabel;


@property(class,nonatomic, copy,readonly) NSString *reuseIdentifier;


@end

NS_ASSUME_NONNULL_END
