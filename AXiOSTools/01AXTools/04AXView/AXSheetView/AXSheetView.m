//
//  AXSheetView.m
//  AXiOSTools
//
//  Created by AXing on 2019/2/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXSheetView.h"
#import "AXiOSTools.h"
#import <Masonry/Masonry.h>
@interface AXSheetView ()

/**背景色,为了旋转时,空隙*/
@property(nonatomic,strong)UIView *coverView;

@end


@implementation AXSheetView

- (instancetype)initWithFrame:(CGRect)frame{
    frame = UIScreen.mainScreen.bounds;
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView = [[UIView alloc]initWithFrame:frame];
        self.contentView.center = self.center;
        CGFloat maxWH = MAX(self.contentView.width, self.contentView.height);
        self.contentView.width=maxWH;
        self.contentView.height=maxWH;
        self.contentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        [self addSubview:self.contentView];
        
        
        self.contentView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
            [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        }
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(___deviceOrientationNote:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)howSheetView {
    
    UIWindow *rootWindow =  UIApplication.sharedApplication.delegate.window;
    
    [rootWindow addSubview:self];
    
    CGRect temp = self.contentView.frame;
    temp.origin.y += temp.size.height;
    self.contentView.frame = temp;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect temp = self.contentView.frame;
        temp.origin.y = 0;
        self.contentView.frame = temp;
    }];
}


- (void)dismissSheetView {
    [self removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self.contentView || hitView == self) {
        [self removeFromSuperview];
    }
    return hitView;
}

- (void)___deviceOrientationNote:(NSNotification *)notification{
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}
