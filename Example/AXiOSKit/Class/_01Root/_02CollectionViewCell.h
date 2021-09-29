//
//  _02CollectionViewCell.h
//  AXiOSKit
//
//  Created by axinger on 2021/9/26.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface _02CollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *detaLabel;

@end

NS_ASSUME_NONNULL_END
