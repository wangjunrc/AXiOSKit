//
//  AXIBudyButton.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/2/20.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXIBudyButton.h"
#import <AXiOSKit/UIImage+AXKit.h>


@implementation AXIBudyButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    //    CGPoint point = [touch locationInView:self];
    
    if(!CGRectContainsPoint(CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height), point)){
        
        return NO;
    }
    
    UIColor *aColor = [self.currentBackgroundImage ax_pixelColorFromPoint:point scale:1];
    NSLog(@"aColor %@",aColor);
    if (!aColor || [aColor isEqual:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]]) {
        NSLog(@"白色 不触发事件");
        return NO;
    }
    
    NSLog(@"触发事件");
    return YES;
}




@end
