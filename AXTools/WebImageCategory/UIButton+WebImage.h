//
//  UIButton+WebImage.h
//  Xile
//
//  Created by Mole Developer on 16/8/24.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WebImage)
/**
 * 按钮的普通转态背景图,此项目url需要拼接 suffix为图片后缀
 */
-(void)setWebImageUrl:(NSString *)suffix;

@end
