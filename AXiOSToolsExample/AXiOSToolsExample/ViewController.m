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

+(NSString *)function:(NSString*)value,...{
    va_list argumentList;
    va_start(argumentList, value);
    NSString *tmp = nil;
    
    while ((tmp = va_arg(argumentList, NSString *))) {
        NSLog(@"%@",tmp);
    }
    
    va_end(argumentList);
    
    return @"A";
}

- (void)viewDidLoad {
  [super viewDidLoad];
    NSLog(@"person %@",self.person.nickname);
    NSLog(@"dog %@",self.dog.nickname);
    
    self.label.text = [NSString ax_stringWithFormat:@"%@>>>%@",@"A",2,nil];
    
//    [self.class function:@"1",@"2",@"3",nil];
    [NSString stringWithFormat:@"%ld",3];
    
    
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
