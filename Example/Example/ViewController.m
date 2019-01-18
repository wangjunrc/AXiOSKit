//
//  ViewController.m
//  Example
//
//  Created by AXing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import "AXiOSTools.h"

#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <SDWebImage/FLAnimatedImageView+WebCache.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *aTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    
    FLAnimatedImageView *FLView = [[FLAnimatedImageView alloc]init];
    FLView.frame = CGRectMake(0, 100, 100, 280);
    [FLView sd_setImageWithURL:[NSURL URLWithString:@"https://img.soogif.com/7lMNouzYDdKupikZNTDJLGHz74PdmEg2.gif"] placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:FLView];
    
}

@end
