//
//  DLCompanyNewsMoreSmallPictureCell.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import "DLCompanyNewsMoreSmallPictureCell.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
@implementation DLCompanyNewsMoreSmallPictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _initUI];
    }
    return self;
}

-(void)_initUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.imgViewBgView];
    [self.bgView addSubview:self.dateLabel];
    self.bgView.backgroundColor = UIColor.grayColor;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView);
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
    }];
    
    
        
        NSMutableArray<UIImageView *> *imgViewBgViewArray = [NSMutableArray array];
        for(int i=0;i<3;i++){
            UIImageView *imgView = [UIImageView.alloc initWithImage:[UIImage imageNamed:@"exporte"]];
            imgView.backgroundColor = UIColor.orangeColor;
            imgView.contentMode =0;
            [self.imgViewBgView addSubview:imgView];
            [imgViewBgViewArray addObject:imgView];
        }
        
        [self.imgViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(15);
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.height.mas_lessThanOrEqualTo(120);
        }];
        
        
//        [imgViewBgViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:0 tailSpacing:0];

    [imgViewBgViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    
    
        [imgViewBgViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.bottom.mas_offset(-10);
//            make.height.mas_equalTo(60);
        }];
        
        
        
//        [self.imgViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(imgViewBgViewArray.firstObject.mas_bottom);
////            make.height.mas_equalTo(60);
//        }];
   
    
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgViewBgView.mas_bottom).mas_offset(10);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.equalTo(self.bgView.mas_bottom);
    }];
    
    
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView.alloc init];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel.alloc init];
        _dateLabel.font = [UIFont systemFontOfSize:11];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.alpha = 0.4;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.numberOfLines = 1;
    }
    return _dateLabel;
}

- (UIView *)imgViewBgView {
    if (!_imgViewBgView) {
        _imgViewBgView = [UIView.alloc init];
        _imgViewBgView.layer.cornerRadius = 6;
    }
    return _imgViewBgView;
}


+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
