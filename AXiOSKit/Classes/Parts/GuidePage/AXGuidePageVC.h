//
//  AXGuidePageVC.h
//  AXiOSKitDemo
//
//  Created by liuweixing 2018/6/21.
//  Copyright © 2018年 liuweixing. All rights reserved.
//


#import "AXKitViewController.h"

@interface AXGuidePageVC : AXKitViewController

+ (instancetype )guidePageWithImage:(NSArray <NSString *>*)imageArray passBlock:(void(^)(void))passBlock;

- (instancetype )initWithImage:(NSArray <NSString *>*)imageArray passBlock:(void(^)(void))passBlock;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) UIImage *passImage;

@end
