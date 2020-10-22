//
//  _14TFViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_14TFViewController.h"
#import <AXiOSKit/AXiOSKit.h>
@interface _14TFViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myTF;

@end

@implementation _14TFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.myTF.delegate = self;
    self.myTF.ax_delegateHandler.banBlankSpace = YES;;
    self.myTF.ax_delegateHandler.maxCharacterCount = 5;
//    self.myTF.ax_delegateHandler.onlyPositiveNumber = YES;
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{

 

    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];

    if (![string isEqualToString:tem]) {

        return NO;

    }

    return YES;

}
@end
