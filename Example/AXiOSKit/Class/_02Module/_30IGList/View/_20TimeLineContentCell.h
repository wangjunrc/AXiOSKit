//
//  _20TimeLineContentCell.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListKit.h>
#import "_30TimeLineNinePhotoView.h"
#import "_30TimeLineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface _20TimeLineContentCell : UICollectionViewCell<IGListBindable>

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *contentLabel;
//@property(nonatomic,strong)_30TimeLineNinePhotoView *npv;
@property(nonatomic,assign)CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
