//
//  _25CollectionViewCell.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_25CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation _25CollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self buidUI];
        
    }
    return self;
}


- (void)buidUI {
    self.contentView.backgroundColor = UIColor.orangeColor;
    CGFloat leftMargin = 10;
   
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.addBtn];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(leftMargin);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.nameLabel);
        make.right.mas_equalTo(-10);
        
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.nameLabel);
        make.right.mas_equalTo(-10);
    }];
    
    

    self.contentLabel.backgroundColor = UIColor.greenColor;
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(ax_keyWindow().width);
//    }];
    
    
}

- (void)setModel:(_25DataModel *)model {
    _model = model;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUri] placeholderImage:[UIImage imageNamed:@"AppIcon"]];
    
    self.nameLabel.text = model.title;
    self.contentLabel.text = @"内容";
    
    if (model.isEditing) {
        [self.contentView addGestureRecognizer:self.longGesture];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        [animation setDuration:0.1];
        animation.fromValue = @(-M_1_PI/6);
        animation.toValue = @(M_1_PI/6);
        animation.repeatCount = HUGE_VAL;
        animation.autoreverses = YES;
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.layer addAnimation:animation forKey:@"rotation"];
        
    }else {
        [self.contentView removeGestureRecognizer:self.longGesture];
        CABasicAnimation *animation = (CABasicAnimation *)[self.layer animationForKey:@"rotation"];
        if (animation) {
            [self.layer removeAnimationForKey:@"rotation"];
        }
        
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isDescendantOfView:self.addBtn]){
        return NO;
    }
    return YES;
}

-(void)handlelongGesture:(UILongPressGestureRecognizer *)sender{
    if (self.gestureHandler) {
        self.gestureHandler(sender);
    }
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColor.blackColor;
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = UIColor.blackColor;
    }
    return _contentLabel;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn setTitle:@"按钮" forState:UIControlStateNormal];
        _addBtn.backgroundColor = UIColor.blueColor;
        [_addBtn ax_addTargetBlock:^(UIButton * _Nullable button) {
            NSLog(@"cell - 按钮");
        }];
    }
    return _addBtn;
}

- (UILongPressGestureRecognizer *)longGesture {
    if (!_longGesture) {
        
//        _longGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        
        UILongPressGestureRecognizer    *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        gesture.minimumPressDuration = 0.05;
        gesture.delegate = self;
        
        _longGesture = gesture;
    }
    return _longGesture;
}
@end
