//
//  AXMultiSelectViewController.m
//  AXiOSKit
//
//  Created by axing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXMultiSelectViewController.h"
#import "AXNavigationBar.h"
#import "AXMultiSelectViewModel.h"
#import "AXMultiSelectConfig.h"
#import <Masonry/Masonry.h>
#import "AXMultiSelectCell.h"
#import "AXMultiSelectSectionHeaderView.h"
#import "AXiOSKit.h"
#import <AXViewControllerTransitioning/AXViewControllerTransitioning.h>
@interface AXMultiSelectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) AXNavigationBar *myNavigationBar;
@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) UIBarButtonItem *completelItem;

@property(nonatomic, strong) NSArray <AXMultiSelectViewModel *> *viewModelArray;
@property(nonatomic, strong) AXMultiSelectConfig *config;

@property(nonatomic, copy)void (^didSelectRowBlock)(NSArray<NSIndexPath *> *indexPathsForSelectedItems);

@end

@implementation AXMultiSelectViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self ax_alertObserver:^(AXAlertTransitioningObserver *observer) {
            observer.alertControllerStyle = AXAlertControllerStyleUpward;
        }];
    }
    return self;
}

-(instancetype)initWithConfig:(AXMultiSelectConfig *)config
                   viewModels:(NSArray <AXMultiSelectViewModel *>*)viewModelArray
                 didSelectRow:(void(^)(NSArray<NSIndexPath *> *selectedItems))didSelectRow {
    
    if (self = [self init]) {
        self.config = config;
        self.viewModelArray = viewModelArray;
        self.didSelectRowBlock = didSelectRow;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ax_colorFromHexString:@"#202020"];
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    
    self.myNavigationBar.title = self.title;
    
    [self.view addSubview:self.myNavigationBar];
    [self.myNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myNavigationBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.viewModelArray enumerateObjectsUsingBlock:^(AXMultiSelectViewModel * _Nonnull obj1, NSUInteger section, BOOL * _Nonnull stop) {
        
        [obj1.rowArray enumerateObjectsUsingBlock:^(AXMultiSelectRowViewModel * _Nonnull obj, NSUInteger row, BOOL * _Nonnull stop2) {
            
            if (obj.selected) {
                
                NSIndexPath *path = [NSIndexPath indexPathForItem:row inSection:section];
                [weakSelf.collectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionNone];
                
                /// Section 区 是否多选 默认NO
                if (!self.config.isAllowsSectionSelection) {
                    *stop2 = YES;
                }
            }
        }];
        
        //         *stop = YES;
        
    }];
    
    [self __completelItemEnabled];
    
}

-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.viewModelArray.count;
}
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.viewModelArray[section].rowArray.count;
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AXMultiSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AXMultiSelectCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.viewModel = self.viewModelArray[indexPath.section].rowArray[indexPath.item];
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    AXMultiSelectSectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:AXMultiSelectSectionHeaderView.reuseIdentifier forIndexPath:indexPath];
    
    view.titleLabel.text =  self.viewModelArray[indexPath.section].sectionTitle;;
   
    
    return view;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat column = self.config.column*1.0;
    if (column == 0.0) {
        column = 1.0;
    }
    
    CGFloat w  = (self.view.width-(column+1)*10.0)/column;
    return CGSizeMake(w, 40);
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView.indexPathsForSelectedItems enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        if (obj.section == indexPath.section) {
            
            NSUInteger item = obj.item;
            
            if (obj.item == indexPath.item) {
                
                [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            }else {
                [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:indexPath.section] animated:YES];
            }
            
        }
        
    }];
    
    [self __completelItemEnabled];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    [self __completelItemEnabled];
}

#pragma mark - action
-(void)cancelAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)completelAction:(id)sender {
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock([self.collectionView indexPathsForSelectedItems]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)__completelItemEnabled {
    
    if (!self.config.isAllowsSelectionEmpty) {
        self.completelItem.enabled = self.collectionView.indexPathsForSelectedItems.count;
    }
    
}

#pragma mark - sizeForAlert
- (CGSize)sizeForAlert {

    CGFloat column = self.config.column*1.0;
    if (column == 0.0) {
        column = 1.0;
    }

    NSInteger num = 0;

    for (AXMultiSelectViewModel *obj in self.viewModelArray) {
        num += ceil(obj.rowArray.count/column);
    }

    // 最多7行
    num = MIN(num, 4);
    // 行最少 2hang
    num = MAX(num, 2);

    // (10+10+40) cell 高度, 44 bar 高度,20为了看见一半cell效果
    return CGSizeMake(self.view.width-40, num *(10+10+40+50)+44+20);
}

#pragma mark - set and get


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        if (self.config.isNeedSectionHeader) {
            layout.headerReferenceSize = CGSizeMake(0, 50);
        }
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.allowsMultipleSelection = self.config.isAllowsMultipleSelection;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:AXMultiSelectCell.class forCellWithReuseIdentifier:AXMultiSelectCell.reuseIdentifier];
        
        [_collectionView registerClass:AXMultiSelectSectionHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:AXMultiSelectSectionHeaderView.reuseIdentifier];
        
    }
    return _collectionView;
}
- (AXNavigationBar *)myNavigationBar {
    if (!_myNavigationBar) {
        
        AXNavigationBar *bar = [[AXNavigationBar alloc]init];
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
        bar.navigationItem.leftBarButtonItems = @[cancelItem];
        
        self.completelItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completelAction:)];
        bar.navigationItem.rightBarButtonItems = @[self.completelItem];
        
        _myNavigationBar = bar;
    }
    return _myNavigationBar;
}


@end

