//
//  AXNavigationBar.m
//  AXiOSKit
//
//  Created by AXing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXNavigationBar.h"
#import "UIImage+AXKit.h"
#import "UIColor+AXKit.h"

@implementation AXNavigationBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.barTintColor = [UIColor whiteColor];
        self.tintColor = [UIColor whiteColor];
        
        UIImage *backgroundImage =  [UIImage ax_imageSquareWithColor:[UIColor ax_colorFromHexString:@"#202020"]];
        [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        
        UIImage *shadowImage =  [UIImage ax_imageSquareWithColor:[UIColor ax_colorFromHexString:@"#363636"]];
        [self setShadowImage:shadowImage];
        
        NSDictionary *dic = @{ NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:16] };
        self.titleTextAttributes = dic;
        
        self.navigationItem = [[UINavigationItem alloc] init];
        [self setItems:@[self.navigationItem]];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.topItem.title = title;
}

@end
