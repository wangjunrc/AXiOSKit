//
//  AXMultiSelectCell.h
//  AXiOSKit
//
//  Created by axing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXMultiSelectViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMultiSelectCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *titleLabel;

@property(class,nonatomic, copy,readonly) NSString *reuseIdentifier;

@property(nonatomic, strong) AXMultiSelectRowViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
