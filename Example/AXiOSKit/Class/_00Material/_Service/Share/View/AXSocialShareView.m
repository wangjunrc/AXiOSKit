//
//  DLSharePopView.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXSocialShareView.h"

#import <AXiOSKit/UIKit+AXAssistant.h>
#import <Masonry/Masonry.h>
#import "AXSocialShareCell.h"

static CGFloat const itemW = 80;
static CGFloat const itemH = 80;

@implementation AXSocialShareView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self _initUI];
    }
    return self;
}

-(void)_initUI {
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.collBgView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.titleLabel.mas_top).mas_equalTo(0);
        make.bottom.equalTo(self.cancelButton.mas_bottom).mas_equalTo(ax_safe_area_insets_bottom_offset(0));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.collBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self _collectionViewLayout:make];
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collBgView.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    [self.cancelButton ax_addLineDirection:AXLineDirectionTop color:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1] height:1];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray[collectionView.tag].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AXSocialShareCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"DLSharePopCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.ax_randomColor;
    cell.action = self.dataArray[collectionView.tag][indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AXShareOption *action = self.dataArray[collectionView.tag][indexPath.item];
    if (action.didBlock) {
        action.didBlock(action.type);
    }
}

///1、设置格子的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    CGFloat cellW = self.bounds.size.width*0.25;
    //    CGFloat cellW = self.bounds.size.width/(1.0*self.column);
    return  CGSizeMake(itemW, itemH);
}

///2、设置collectionView的四周边距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

///3、设置最小行间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 40;
}

/// 4、设置最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

/// 5、设置段头的尺寸

//       - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

/// 6、设置段尾的尺寸

//      - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;


#pragma mark - set

- (void)setDataArray:(NSArray<NSArray<AXShareOption *> *> *)dataArray{
    _dataArray = dataArray;
    
    [self.collBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        [self _collectionViewLayout:make];
    }];
    
    __block NSMutableArray<UICollectionView *> *temp = [NSMutableArray arrayWithCapacity:dataArray.count];
//    @weakify(temp);
    [dataArray enumerateObjectsUsingBlock:^(NSArray<AXShareOption *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionView *view =  [self creaCollectionView];
        view.backgroundColor = UIColor.ax_randomColor;
        view.tag = idx;
//        @strongify(temp);
        [temp addObject:view];
        [self.collBgView addSubview:view];
    }];
    self.collViewArray = temp.copy;
    
    [temp mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:20 leadSpacing:0 tailSpacing:0];
    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(itemH);
    }];
    
}

-(void)_collectionViewLayout:(MASConstraintMaker *)make{
    make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(0);
    make.left.right.mas_equalTo(0);
    make.height.mas_equalTo(itemH*self.dataArray.count+20);
}

#pragma mark - get
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = UIColor.whiteColor;
        _contentView.layer.cornerRadius = 10;
    }
    return _contentView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"- 分享至 -";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.alpha = 0.6;
    }
    return _titleLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = UIButton.alloc.init;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cancelButton;
}



- (UIView *)collBgView {
    if (!_collBgView) {
        _collBgView = [UIView.alloc init];
        _collBgView.backgroundColor = UIColor.purpleColor;
    }
    return _collBgView;
}

- (UICollectionView *)creaCollectionView {
    
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.alloc.init;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.sectionInset = UIEdgeInsetsZero;
//    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = UIColor.whiteColor;
    [collectionView registerClass:AXSocialShareCell.class forCellWithReuseIdentifier:@"DLSharePopCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    return collectionView;
}



@end
