//
//  AAView.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/4/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAView.h"

@implementation AAView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_testAction)];
//                        self.userInteractionEnabled = YES;
//        [self addGestureRecognizer:tap];
    }
    return self;
}


-(void)_testAction{
    NSLog(@"_testAction");
}
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    CGPoint redBtnPoint = [self convertPoint:point toView:self];
    
    if ([self pointInside:redBtnPoint withEvent:event]) {
         NSLog(@"_testAction");
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
    
}

@end
