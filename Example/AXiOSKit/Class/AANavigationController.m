//
//  AANavigationController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AANavigationController.h"
#import <AXiOSKit/AXiOSKit.h>
@interface AANavigationController ()<UINavigationControllerDelegate>

@end

@implementation AANavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if (@available(iOS 13.0, *)) {
//        UIColor *bgColor =  [UIColor ax_colorWithNormalStyle:UIColor.redColor darkStyle:UIColor.systemBackgroundColor];
//
//        [self.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
//    } else {
//        // Fallback on earlier versions
//    }
    
//    UIColor *bgColor =  [UIColor redColor];
//
//    [self.navigationBar setBackgroundImage:[UIImage ax_imageSquareWithColor:bgColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationBar.tintColor = [UIColor greenColor];
    
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
   
//    if (@available(iOS 11.0, *)) {
//        self.navigationItem.backButtonTitle  = @"";
//    } else {
//        // Fallback on earlier versions
//    }
//    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
//        backButtonItem.title = @"返回";
//        self.navigationItem.backBarButtonItem = backButtonItem;
    
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
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
