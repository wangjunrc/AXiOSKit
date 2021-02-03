//
//  AXXSwitch.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/2/3.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXXSwitch.h"

@implementation AXXSwitch

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake(0, (bounds.size.height - 5)/2.0, bounds.size.width, 200);
}


@end
