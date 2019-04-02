//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//
#import "ViewController.h"
#import "AAViewController.h"
#import "AXiOSTools.h"

@interface ViewController ()

@property(nonatomic, strong) AAViewController* avc;

@property(weak, nonatomic) IBOutlet UILabel* label;

@property(weak, nonatomic) IBOutlet UITextField* tf;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    NSLog(@">> %@",[@"http//:www.baidu.com/?age=12&"  ax_pathAppendingWithParameter:@{@"name":@"jim"}]);
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
  //  AAViewController *vc = [[AAViewController alloc] init];
  //  [self.navigationController pushViewController:vc animated:YES];

  AXWKWebVC* vc = [[AXWKWebVC alloc] init];
  vc.loadHTMLFilePath =
      [NSBundle.mainBundle pathForResource:@"HTML/home.html" ofType:nil];

  NSLog(@"%@", vc.loadHTMLFilePath);
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnAction:(id)sender {
}

- (IBAction)btnAc2:(id)sender {
}
@end
