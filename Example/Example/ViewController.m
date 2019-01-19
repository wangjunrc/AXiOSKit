//
//  ViewController.m
//  Example
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "AXiOSTools.h"
//#import "ABViewController.h"

#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <SDWebImage/FLAnimatedImageView+WebCache.h>
#import "UIImageView+AXCircle.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *aTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    ABViewController *VC = [ABViewController ax_init];
//
////    NSString *bundlePath = [NSBundle.mainBundle pathForResource:@"AXHTML.bundle/wk_index.html" ofType:nil];
//
//    VC.loadHTMLFilePath = [[NSBundle ax_currentBundleWithName:@"AXHTML"]pathForResource:@"index.html" ofType:nil];
//
//    [self.navigationController pushViewController:VC animated:YES];
}

@end
