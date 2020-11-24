//
//  _30IGListViewController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_30IGListViewController.h"
#import <IGListKit/IGListKit.h>
#import "_30TimeLineModel.h"
#import <MJExtension/MJExtension.h>
#import "_20TimeLineContentCell.h"
#import "_30TimeLinetContentController.h"
@interface _30IGListViewController ()<IGListAdapterDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray<_30TimeLineModel *>* dataArray;

@property(nonatomic,assign) CGFloat contentOffsetY;

@end

@implementation _30IGListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"IGList";
    self.view.backgroundColor = UIColor.whiteColor;
    //     主列表
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
    self.adapter.scrollViewDelegate = self;
    [self.view addSubview:_collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self prepareListData];
    
}
- (void)prepareListData {
    
    //初始化数据
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"time_line_list" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    [self.dataArray addObjectsFromArray:[_30TimeLineModel mj_objectArrayWithKeyValuesArray:array]];
    /// 更新数据
    [self.adapter performUpdatesAnimated:YES completion:nil];
}


/// 滑动改变导航栏状态
/// @param scrollView scrollView description
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.contentOffsetY = scrollView.contentOffset.y;
//
//    self.navView.navV.alpha = self.contentOffsetY / 150;
//    self.navView.navLabel.alpha = self.contentOffsetY / 150;
//
//    if (self.contentOffsetY / 150 > 0.6) {
//
//        self.navView.isScrollUp = YES;
//
//    } else {
//
//        self.navView.isScrollUp = NO;
//
//    }
    
}
-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
        
        UIView *emptyV = [UIView new];
        emptyV.backgroundColor = [UIColor blueColor];
        return nil;
}
    
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
        return self.dataArray;
}
    
-(IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(_30TimeLineModel *)object{
    
    NSLog(@"object = %@",[object mj_JSONObject]);
    
    
//    NSArray *temp = @[_30TimeLinetContentController.alloc.init];
//
//
//
//    IGListStackedSectionController *stack = [[IGListStackedSectionController alloc] initWithSectionControllers:temp];
//
//
//        stack.inset = UIEdgeInsetsMake(-60, 0, 0, 0);
//        return stack;
//    NSInteger index = [self.dataArray indexOfObject:object];
//    
//    return [IGListSingleSectionController.alloc initWithCellClass:_20TimeLineContentCell.class configureBlock:^(id  _Nonnull item, __kindof _20TimeLineContentCell * _Nonnull cell) {
//        [cell bindViewModel:object];
//        if (index==1) {
//            cell.backgroundColor = UIColor.orangeColor;
//        }
//    } sizeBlock:^CGSize(id  _Nonnull item, id<IGListCollectionContext>  _Nullable collectionContext) {
//        if (index==1) {
//            return CGSizeMake(self.view.size.width/4.0, 120);
//        }
//        return CGSizeMake(self.view.size.width/3.0, 60);
////        UICollectionViewFlowLayout.automaticSize
////        return UICollectionViewFlowLayoutAutomaticSize;
//    }];
    return _30TimeLinetContentController.alloc.init;
}


#pragma mark IG

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectionView;
}
- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self];
    }
    return _adapter;
    
}

- (NSMutableArray<_30TimeLineModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
@end
