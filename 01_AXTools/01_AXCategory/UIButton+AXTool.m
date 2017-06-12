//
//  UIButton+AXTool.m
//  Financing118
//
//  Created by Mole Developer on 15/10/28.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import "UIButton+AXTool.h"
#import <objc/runtime.h>

typedef void(^ButtonBlock)(UIButton *button);

@interface UIButton ()
@property(nonatomic,copy)ButtonBlock buttonBlock;
@end

@implementation UIButton (AXTool)

-(void)ax_addTargetBlock:(void (^)(UIButton *))block{
    [self addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonBlock = block;
}
-(void)buttonEvents:(UIButton *)button{
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
