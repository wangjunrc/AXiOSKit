//
//  MyTextView.h
//  AXTools
//
//  Created by Mole Developer on 16/8/2.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView
/**
 * 占位文字
 */
@property(nonatomic,copy) NSString *placeholder;
/**
 * 占位文字颜色
 */
@property(nonatomic,strong) UIColor *placeholderColor;

@end
