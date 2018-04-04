//
//  UISlider+AXTool.m
//  ZBP2P
//
//  Created by liuweixing on 2016/12/16.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UISlider+AXTool.h"
#import <objc/runtime.h>

typedef void(^ButtonBlock)(UISlider *button);



@interface UISlider ()

@property(nonatomic,copy)ButtonBlock buttonBlock;

@end
@implementation UISlider (AXTool)

-(void)ax_addTargetBlock:(void (^)(UISlider *))block{
    [self addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventValueChanged];
    self.buttonBlock = block;
}
-(void)buttonEvents:(UISlider *)button{
    if (self.buttonBlock) {
        self.buttonBlock(button);
    }
}

/**
 * cameraBlock set方法
 */
- (void)setButtonBlock:(ButtonBlock)buttonBlock{
    objc_setAssociatedObject(self, @selector(buttonBlock),buttonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 * cameraBlock get方法
 */
- (ButtonBlock)buttonBlock{
    return objc_getAssociatedObject(self, @selector(buttonBlock));
}
@end
