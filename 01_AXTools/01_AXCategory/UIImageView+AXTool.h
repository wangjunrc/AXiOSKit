//
//  UIImageView+AXTool.h
//  Financing118
//
//  Created by Mole Developer on 15/10/28.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AXTool)

/**让当前视图顺时针不停旋转,duration为旋转一圈时间*/
-(void)ax_rotateWithOneCircleDuration:(NSTimeInterval)duration ;
/**停止旋转*/
-(void)ax_stopRotate;
/**
 *  逆时针旋转
 */
- (void)ax_reverseRotateWithOneCircleDuration:(NSTimeInterval)duration;


/**
 UIImageView 初始化

 @param frame frame
 @param image image
 @return UIImageView
 */
+(instancetype)ax_imageWithFrame:(CGRect )frame imageName:(NSString *)image;

@end
