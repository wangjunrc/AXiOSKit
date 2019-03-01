//
//  UIView+AXSheet.m
//  AXiOSTools
//
//  Created by AXing on 2019/3/1.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "UIView+AXSheet.h"
#import <Masonry/Masonry.h>

/**
 为了遍历父视图 class
 */
@interface AXSheetCoverView : UIView

@end

@implementation AXSheetCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDismiss)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)didDismiss {
    [self removeFromSuperview];
}

@end


@implementation UIView (AXSheet)

- (void)ax_showSheet {
    
    UIWindow *rootWindow =  UIApplication.sharedApplication.delegate.window;
    
    AXSheetCoverView *coverView = [[AXSheetCoverView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    [rootWindow addSubview:coverView];
    [coverView addSubview:self];
    
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(coverView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.equalTo(coverView);
    }];
    
    /**显示动画*/
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverView.mas_top);
            make.left.right.mas_equalTo(0);
            make.height.equalTo(coverView);
        }];
        [self.superview layoutIfNeeded];
    }];
    
}


- (void)ax_dismissSheet {
    
    UIView *view = self;
    while (![view.superview isKindOfClass:AXSheetCoverView.class]) {
        view = view.superview;
    }
    [view removeFromSuperview];
    
}


@end

