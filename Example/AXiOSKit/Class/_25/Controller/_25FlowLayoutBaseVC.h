//
//  _25FlowLayoutBaseVC.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import "_25CollectionViewCell.h"
#import "_25DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface _25FlowLayoutBaseVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray<NSMutableArray <_25DataModel *> *> *dataArray;


@end

NS_ASSUME_NONNULL_END
