//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//




#import "ViewController.h"
#import "AAViewController.h"
#import "Person.h"

@interface ViewController ()

@property(nonatomic,strong)AAViewController *avc;

/**<#description#>*/
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AAViewController *vc = [[AAViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
 
    
    
}

//-(void)doText {
//
//    NSData *data = [NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"abc" ofType:nil]];
//
//
//    NSString *str =  [data ax_toString];
//
//    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//
//
//    NSArray * array2 = [temp componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"！。"]];
//
//    for (NSString *word in array2) {
//        if ([word containsString:@"射"] || [word containsString:@"头球"]) {
//            AXNoMsgLog(@"%@\n",word);
//        }
//    }
//}

- (void)ax_showAlertTF2:(NSString *(^)(NSString *name))textFBlock
     
    {
    
        NSLog(@">> %@",textFBlock(@"jim"));
        
}


- (IBAction)btnAction:(id)sender {
    
}

- (IBAction)btnAc2:(id)sender {
    
}


@end
