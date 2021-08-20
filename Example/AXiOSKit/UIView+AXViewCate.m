//
//  UIView+AXViewCate.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/18.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "UIView+AXViewCate.h"

@implementation UIView (AXViewCate)

-(void)ax_test {
    self.axName = @"jim";
    
    AXLog(@"self.view.axName=%@",self.axName);
}
@end
