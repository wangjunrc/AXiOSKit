//
//  DLSharePopView.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "DLSharePopView.h"
#import "NSString+Utility.h"
#import "NSString+Additions.h"
#import "UIView+DLUI.h"
#import "DLUIAssistant.h"
#import "Masonry.h"
#import "DLSharePopCell.h"
#import "UIView+DLUI.h"
@implementation DLSharePopView

- (instancetype)initWithFrame:(CGRect)frame
{
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
    [self.contentView addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:DLSharePopCell.class forCellWithReuseIdentifier:@"DLSharePopCell"];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.titleLabel.mas_top).mas_equalTo(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collectionView.mas_top).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cancelButton.mas_top).mas_equalTo(-10);
        make.left.right.mas_equalTo(0);
        make.height.equalTo(self.collectionView.superview.mas_width).multipliedBy(0.5);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).mas_equalTo(-dl_safe_area_insets_bottom_offset(0));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    [self.cancelButton dl_addLineDirection:LineDirectionTop color:[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1] height:1];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLSharePopCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"DLSharePopCell" forIndexPath:indexPath];
    
    cell.action = self.dataArray[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AXShareOption *action = self.dataArray[indexPath.item];
    if (action.didBlock) {
        action.didBlock(action.type);
    }
}

///1、设置格子的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellW = self.bounds.size.width*0.25;
    return  CGSizeMake(cellW, cellW);
}

- (void)setDataArray:(NSArray<AXShareOption *> *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
///2、设置collectionView的四周边距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

///3、设置最小行间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

/// 4、设置最小列间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

/// 5、设置段头的尺寸

//       - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

/// 6、设置段尾的尺寸

//      - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;





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
        _titleLabel.font =dl_systemFont(15);
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
        _cancelButton.titleLabel.font = dl_boldFont(15);
    }
    return _cancelButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
    }
    return _collectionView;
}


@end
