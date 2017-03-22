//
//  UIButton+WebImage.m
//  Xile
//
//  Created by Mole Developer on 16/8/24.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "UIButton+WebImage.h"

@implementation UIButton (WebImage)

/**
 * 按钮的普通转态背景图
 */
-(void)setWebImageUrl:(NSString *)suffix{
    if (suffix.length==0) {
        [self setBackgroundImage:HHeadImage forState:UIControlStateNormal];
        return;
    }
    NSURL *url = URLPhoth(suffix);
    [self sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:HHeadImage];
}

@end
