//
//  _25LayoutViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/16.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_25LayoutViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>

@interface SSCollectionViewLayout : UICollectionViewFlowLayout

/** cell height arrays */
@property(nonatomic,strong)NSArray *cellHeightArrays;

/** attributes arrays */
@property(nonatomic,strong)NSMutableArray *attributesArrays;

/** cell array */
@property(nonatomic,strong)NSMutableArray *tempAttributesArrays;
-(instancetype)initWithArrays:(NSArray *)cellHeightArrays;

@end

@implementation SSCollectionViewLayout

-(instancetype)initWithArrays:(NSArray *)cellHeightArrays
{
    if (self = [super init]) {
    
        self.cellHeightArrays = cellHeightArrays;
    }

    return self;
}

- (void)invalidateLayout{
    [super invalidateLayout];
    [self setupLayout];
}

- (void)setupLayout{
//    CGFloat space = 20;
//    self.sectionInset = UIEdgeInsetsMake(0,space,0,space);//分区间的内边距
//    //minimumLineSpacing = 0;这个是水平的间距 minimumInteritemSpacing
//    self.minimumInteritemSpacing = 0;//列间距
//    self.minimumLineSpacing = 0;//行间距
//    self.estimatedItemSize = CGSizeMake(ax_screen_width()-space*2, ax_screen_height()-64-10);
//    self.itemSize = CGSizeMake(ax_screen_width()-space*2, ax_screen_height()-64-10); //item尺寸
//    self.scrollDirection =UICollectionViewScrollDirectionHorizontal;//滚动方向


    self.sectionInset = UIEdgeInsetsMake(0,0,0,0);//分区间的内边距
    //minimumLineSpacing = 0;这个是水平的间距 minimumInteritemSpacing
    self.minimumInteritemSpacing = 10;//列间距
    self.minimumLineSpacing = 10;//行间距
    
    NSLog(@"width == %lf",self.collectionView.bounds.size.width);
        NSLog(@"width == %lf",self.collectionView.bounds.size.width/4.0);
    
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width/4.0-40, 50); //item尺寸
    self.scrollDirection =UICollectionViewScrollDirectionVertical;//滚动方向

}

//自定义layout需要重写这些方法
//-(void)prepareLayout
//{
//    [super prepareLayout];
////
////    [self.attributesArrays  removeAllObjects];
////    [self.tempAttributesArrays removeAllObjects];
////    //获取当前collectionView对应区的item
////    //获取senction全部个数
////    NSInteger count = [self.collectionView numberOfItemsInSection:0];
////    for (int i=0; i < count; i++) {
////        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow: i inSection:0]];
////
////        [self.attributesArrays addObject:attributes];
////    }
//
//}

//返回collectionView的内容的尺寸
//-(CGSize)collectionViewContentSize
//{
//    CGFloat maxContentHeight = CGRectGetMaxY([[self.tempAttributesArrays firstObject] frame]);
//    for (UICollectionViewLayoutAttributes *attributes in self.tempAttributesArrays) {
//        if (maxContentHeight  < attributes.frame.size.height) {
//            maxContentHeight = CGRectGetMaxY(attributes.frame);
//        }
//    }
//    NSLog(@"width == %lf",self.collectionView.bounds.size.width);
//    return CGSizeMake(self.collectionView.bounds.size.width, 50);
//}

//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    return self.attributesArrays;
//}
///返回对应于indexPath的位置的cell的布局属性,返回指定indexPath的item的布局信息。子类必须重载该方法,该方法只能为cell提供布局信息，不能为补充视图和装饰视图提供。
//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    CGFloat itemWidth = (self.collectionView.bounds.size.width  - (10 + 10 + 10 * 2))/3;
//    CGFloat itemHeight = [self.cellHeightArrays[indexPath.row] floatValue];
//    //在这里用上cellArrays了,横排最多显示3个
//    if (self.tempAttributesArrays.count < 3) {//设置第一排rect
//        [self.tempAttributesArrays addObject:attributes];
//        NSLog(@"%ld",self.tempAttributesArrays.count);
//        CGRect rect  = CGRectMake(10 +( itemWidth + 10) * (self.tempAttributesArrays.count - 1), 10, itemWidth, itemHeight);
//        attributes.frame = rect;
//    }else{
//
//        UICollectionViewLayoutAttributes *fristAttributes = [self.tempAttributesArrays firstObject];
//        CGFloat minY = CGRectGetMaxY(fristAttributes.frame);
//        CGFloat Y = minY;
//        NSInteger index = 0;
//        CGRect itemFrame = CGRectMake(fristAttributes.frame.origin.x, CGRectGetMaxY(fristAttributes.frame) + 10, itemWidth, itemHeight);
//        for (UICollectionViewLayoutAttributes *attri in self.tempAttributesArrays) {
//            if (minY > CGRectGetMaxY(attri.frame)) {
//                minY = CGRectGetMaxY(attri.frame);
//                Y = minY;
//                itemFrame = CGRectMake(attri.frame.origin.x, Y + 10, itemWidth, itemHeight);
//                NSInteger currentIndex = [self.tempAttributesArrays indexOfObject:attri];
//                index = currentIndex;
//            }
//        }
//
//        attributes.frame = itemFrame;
//        [self.tempAttributesArrays replaceObjectAtIndex:index withObject:attributes];
//
//    }
//
//    return attributes;
//}

@end



@interface _25LayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation _25LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
    self.collectionView.backgroundColor = UIColor.redColor;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  30;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.orangeColor;
  
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        SSCollectionViewLayout *layout = [[SSCollectionViewLayout alloc]initWithArrays:@[@"1",@"2",@"3"]];
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}
@end
