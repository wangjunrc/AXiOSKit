//
//  AXDebugViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/22.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AXDebugViewController.h"
#import "AXDebugManager.h"
@interface AXDebugViewController ()

@end

@implementation AXDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"环境";
    self.view.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *item = nil;
    ///ios Symbol Image
    if (@available(iOS 13.0, *)) {
        UIImage *image = [UIImage systemImageNamed:@"clear"];
        item = [UIBarButtonItem.alloc initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
        item.tintColor = UIColor.redColor;
    } else {
        item = [UIBarButtonItem.alloc initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    }
    
    self.navigationItem.rightBarButtonItem = item;
}


-(void)rightBarButtonItemAction:(UIBarButtonItem *)sender {
    
    [AXDebugManager.sharedManager.config.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
