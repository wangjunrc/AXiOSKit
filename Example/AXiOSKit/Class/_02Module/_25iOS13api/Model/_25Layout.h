//
//  _25Layout.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/12/7.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface _25Layout : UICollectionViewFlowLayout

/** cell height arrays */
@property(nonatomic,strong)NSArray *cellHeightArrays;

/** attributes arrays */
@property(nonatomic,strong)NSMutableArray *attributesArrays;

/** cell array */
@property(nonatomic,strong)NSMutableArray *tempAttributesArrays;

-(instancetype)initWithArrays:(NSArray *)cellHeightArrays;

@end

NS_ASSUME_NONNULL_END
