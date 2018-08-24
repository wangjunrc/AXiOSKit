//
//  AXWKWebVC.h
//  AXiOSTools
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXWKWebVC : UIViewController

/**
  加载纯外部链接网页
 */
@property (nonatomic, copy) NSString *urlString;


/**
 * 加载本地网页 不需要带.html 后缀
 */
@property (nonatomic, copy) NSString *htmlSring;



@end
