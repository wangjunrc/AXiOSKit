//
//  TextFViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/3/23.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "_10TextFViewController.h"
#import <AXiOSKit/NSString+AXKit.h>
#import <Masonry/Masonry.h>
@interface _10TextFViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *certainBtn;

@end

@implementation _10TextFViewController

/// <#Description#>
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.myTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);//textview内边距，上，左，下，右
    
    NSLog(@"textContainerInset = %@",NSStringFromUIEdgeInsets(self.textView.textContainerInset));
    
    
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.cancelBtn.backgroundColor = UIColor.blackColor;
    self.certainBtn.backgroundColor = UIColor.blackColor;
    self.textView.backgroundColor = UIColor.darkGrayColor;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.6);
        //        make.height.equalTo(self.view).multipliedBy(0.6);
        make.center.equalTo(self.view);
        
        make.topMargin.equalTo(self.titleLabel.mas_topMargin).mas_offset(-10);
    }];
    
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.bgView).multipliedBy(0.5).mas_offset(-0.5);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.bgView).multipliedBy(0.5).mas_offset(-0.5);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
//    NSString *str = @"文字";
//    CGFloat h =[str ax_sizeWithaFont:self.textView.font].height+16;
//
//    self.textView.text = str;
    //
    //    NSLog(@"h== %lf",h);
    //      NSLog(@"self.textView.contentSize.height== %lf",self.textView.contentSize.height);
    //     NSLog(@"self.textView.contentSize.height== %@",NSStringFromUIEdgeInsets(self.textView.textContainerInset));
    

    NSString *str = @"字";
    CGFloat textView_height =[str ax_sizeWithaFont:self.textView.font].height+self.textView.textContainerInset.top+self.textView.textContainerInset.bottom;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(textView_height);
        make.bottom.equalTo(self.cancelBtn.mas_top).mas_equalTo(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.textView.mas_top).mas_equalTo(-10);
        make.centerX.mas_offset(0);
        make.left.mas_greaterThanOrEqualTo(5);
        make.right.mas_lessThanOrEqualTo(-5);
    }];
    
    self.textView .delegate = self;
//    self.textView .pagingEnabled = YES;
//    self.textView.layoutManager.allowsNonContiguousLayout = YES;
    
    
    
    //       self.textView.textContainer.maximumNumberOfLines = 3;
    //
    //    self.textView.showsVerticalScrollIndicator = YES;
    //    self.textView.showsHorizontalScrollIndicator = YES;
    
    //    self.textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
}


- (void)textViewDidChange:(UITextView *)textView{
    
    
    //    CGRect textViewFrame = textView.frame;
    //    CGSize textSize = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 100.0f)];
    //
    //
    //    NSLog(@"textSize %lf",textSize.height);
    //     NSLog(@"textView.contentSize.height %lf",textView.contentSize.height);
    //
    
    CGFloat updataHegiht = textView.contentSize.height;
    
    if (textView.contentSize.height>=67) {
        updataHegiht = 67;
    }
    
    
    //    [textView scrollRangeToVisible:NSMakeRange(textView.text.length, 1)];
    
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(updataHegiht);
    }];
    
    
    [textView scrollRectToVisible:CGRectMake(0, 0, textView.contentSize.width, textView.contentSize.height) animated:NO];
    
    [self.bgView updateConstraints];
    
}


- (AXAlertControllerStyle )axAlertControllerStyle {
    return   AXAlertControllerStyleCentre;
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)certainBtn:(id)sender {
}
@end
