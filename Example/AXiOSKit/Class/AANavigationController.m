//
//  AANavigationController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AANavigationController.h"
#import <AXiOSKit/AXiOSKit.h>
@interface AANavigationController ()

@end

@implementation AANavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 13.0, *)) {
        UIColor *bgColor =  [UIColor ax_colorWithNormalStyle:UIColor.redColor darkStyle:UIColor.systemBackgroundColor];
        
        [self.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
    } else {
        // Fallback on earlier versions
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) traitCollectionDidChange: (UITraitCollection *) previousTraitCollection {
    
    
    [super traitCollectionDidChange: previousTraitCollection];
    
    if (@available(iOS 13.0, *)) {
        
         UIColor *bgColor =  [UIColor colorWithDynamicProvider:^UIColor *(UITraitCollection *traitCollection) {
        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return UIColor.systemBackgroundColor;
        }else {
            return UIColor.redColor;
        }}];
             
        [self.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
    } else {
        
    }
    
}

@end
