//
//  AXWKWebVC.h
//  AXTools
//
//  Created by Mole Developer on 16/10/13.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXWKWebVC : UIViewController

/**
 正常网页
 */
@property(nonatomic,copy) NSString *webURLSring;

/**
 * 本地网页,网页不存在时,直接显示内容
 */
@property(nonatomic,copy) NSString *webHTMLSring;

@end