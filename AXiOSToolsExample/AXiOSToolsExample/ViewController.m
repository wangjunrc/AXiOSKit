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
#import "Person.h"
#import "Dog.h"
#import "NSString+AXTool.h"

@interface ViewController ()

@property(nonatomic, strong) Person* person;

@property(nonatomic, strong) Dog* dog;

@property(weak, nonatomic) IBOutlet UILabel* label;

@property(weak, nonatomic) IBOutlet UITextField* tf;


@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
}


- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
  //  AAViewController *vc = [[AAViewController alloc] init];
  //  [self.navigationController pushViewController:vc animated:YES];


}

- (IBAction)btnAction:(id)sender {
}

- (IBAction)btnAc2:(id)sender {
}
@end
