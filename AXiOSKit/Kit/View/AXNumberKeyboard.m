//
//  AXNumberKeyboard.m
//  AXNumberKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "AXNumberKeyboard.h"
#import "UIKit+AXAssistant.h"
#import "UIImage+AXBundle.h"
#import "NSBundle+AXBundle.h"
@interface AXNumberKeyboard ()

@property (strong, nonatomic)UIView *contentView;

@end

@implementation AXNumberKeyboard

- (instancetype)initWithInputType:(AXNumberKeyboardType)inputType{
    
    if([super init]){
        
        self.contentView = [[NSBundle  ax_mainBundle] loadNibNamed:@"AXNumberKeyboard" owner:self options:nil].firstObject;
        self.frame = CGRectMake(0, 0, ax_screen_width(), 216+ax_safe_area_insets_bottom());
        self.backgroundColor = self.contentView.backgroundColor;
        self.contentView.frame = self.frame;
        [self addSubview:self.contentView];
        
        self.inputType = inputType;
        [self.deleteBtn setImage:[UIImage axBundle_imageNamed:@"ax_delete"] forState:UIControlStateNormal];
        [self.doneBtn setImage:[UIImage axBundle_imageNamed:@"ax_resign"] forState:UIControlStateNormal];
        
        
    }
    
    return self;
}

- (void)setInterval:(NSNumber *)interval{
    _interval = interval;
}


- (void)setInputType:(AXNumberKeyboardType)inputType{
    
    // 小数点 或者 x
    UIButton *pointBtn = [self viewWithTag:1010];
    
    _inputType = inputType;
    
    switch (inputType)
    {
            // 浮点数键盘
        case AXNumberKeyboardTypeFloat:
        {
            pointBtn.hidden = NO;
            [pointBtn setTitle:@"." forState:UIControlStateNormal];
            
            break;
        }
            // 身份证键盘
        case AXNumberKeyboardTypeIDCard:
        {
            pointBtn.hidden = NO;
            [pointBtn setTitle:@"X" forState:UIControlStateNormal];
            break;
        }
            // 数字键盘
        default:
        {
            pointBtn.hidden = YES;
            break;
        }
    }
}

- (IBAction)keyboardViewAction:(UIButton *)sender{
    NSInteger tag = sender.tag;
    
    /*
     AXNumberKeyboardTypeInteger,        // 整数键盘
     AXNumberKeyboardTypeFloat,      // 浮点数键盘
     AXNumberKeyboardTypeIDCard,     // 身份证键盘
     */
    switch (tag)
    {
        case 1010:{
            
            if (self.inputType == AXNumberKeyboardTypeFloat) {
                
                if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"."]){
                    [self.textInput insertText:@"."];
                }
                
                
            }else if (self.inputType == AXNumberKeyboardTypeIDCard){
                
                // 身份证X
                if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"X"]){
                    [self.textInput insertText:@"X"];
                }
            }
        }
            break;
        case 1011: {
            [self endEditing];
        }
            break;
        case 1012:{
            // 删除
            if(self.textInput.text.length > 0)
                [self.textInput deleteBackward];
        }
            break;
        case 1013:{
            // 确认
            [self endEditing];
        }
            break;
            
        default:{
            
            // 数字
            NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
            
            if(self.interval && (self.textInput.text.length+1) % ([self.interval integerValue] + 1) == 0){
                [self.textInput insertText:@" "];
            }
            
            
            if (self.textInput.delegate && [self.textInput.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                
                NSRange range = NSMakeRange(self.textInput.text.length, 0);
                BOOL aBool = [self.textInput.delegate textField:self.textInput shouldChangeCharactersInRange:range replacementString:text];
                
                if (aBool) {
                    [self.textInput insertText:text];
                }
                
            }else{
                [self.textInput insertText:text];
            }
            
            
        }
            break;
    }
}

-(void)endEditing{
    
    [self.textInput resignFirstResponder];
    if (self.textInput.delegate && [self.textInput.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.textInput.delegate textFieldDidEndEditing:self.textInput];
    }
}
@end
