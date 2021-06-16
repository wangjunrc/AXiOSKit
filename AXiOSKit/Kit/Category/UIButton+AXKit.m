//
//  UIButton+AXKit.m
//
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UIButton+AXKit.h"
#import <objc/runtime.h>

typedef void(^ButtonBlock)(UIButton *button);

@interface UIButton ()

@property (nonatomic, copy)ButtonBlock buttonBlock;

@end

@implementation UIButton (AXKit)

#pragma mark - 点击事件
///**
// 不需要定义属性写法,没区别,就是触发 objc_setAssociatedObject 一下而已
// */
//- (void)ax_addActionBlock:(void (^)(UIButton *))block{
//    [self addActionBlock:block];
//    [self addTarget:self action:@selector(__buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//-(void)addActionBlock:(ButtonBlock )block {
//    if (block) {
//        objc_setAssociatedObject(self, @selector(__buttonAction), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//}
//
//- (void)buttonEvents:(UIButton *)button{
//    ButtonBlock block = objc_getAssociatedObject(self, @selector(__buttonAction));
//    if (block) {
//        block(button);
//    }
//}

/**
 需要定义属性写法
 */
- (void)ax_addTargetBlock:(void (^)(UIButton *))block{
    
    self.buttonBlock = block;
    [self addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)buttonEvents:(UIButton *)button{
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


#pragma mark - 图片文字位置

- (void)ax_setImagePosition:(AXButtonImagePosition)postion spacing:(CGFloat)spacing{
//    [self setTitle:self.currentTitle forState:UIControlStateNormal];
//    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat labelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    
    if (postion == AXButtonImagePositionRight && labelWidth >= self.frame.size.width - imageWidth) {
        labelWidth = self.frame.size.width - imageWidth;
    }
    
    CGFloat labelHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2; //image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2; //image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2; //label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2; //label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (postion) {
        case AXButtonImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2, 0, spacing / 2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, -spacing / 2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
            break;
            
        case AXButtonImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing / 2, 0, -(labelWidth + spacing / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing / 2), 0, imageWidth + spacing / 2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
            break;
            
        case AXButtonImagePositionTop:
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth / 2, changedHeight - imageOffsetY, -changedWidth / 2);
            break;
            
        case AXButtonImagePositionBottom:
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight - imageOffsetY, -changedWidth / 2, imageOffsetY, -changedWidth / 2);
            break;
            
        default:
            break;
    }
}

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

- (void)setAx_pointOutside:(UIEdgeInsets)ax_pointOutside {
//    NSValue *value = [NSValue value:&ax_pointOutside withObjCType:@encode(UIEdgeInsets)];
    NSValue *value =  [NSValue valueWithUIEdgeInsets:ax_pointOutside];
//    objc_setAssociatedObject(self, @selector(ax_pointOutside),value, OBJC_ASSOCIATION_COPY);
//
//    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(ax_pointOutside), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIEdgeInsets)ax_pointOutside {
//    NSValue *value = objc_getAssociatedObject(self, @selector(ax_pointOutside));
    NSValue *value = objc_getAssociatedObject(self, @selector(ax_pointOutside));
    if(value) {
//        UIEdgeInsets edgeInsets;
//        [value getValue:&edgeInsets];
//        return edgeInsets;
        return [value UIEdgeInsetsValue];
        
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if(UIEdgeInsetsEqualToEdgeInsets(self.ax_pointOutside, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.ax_pointOutside);
    return CGRectContainsPoint(hitFrame, point);
}



/**
 UIControlStateNormal 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateNormal:(nullable NSString *)title{
    
    [self setTitle:title forState:UIControlStateNormal];
    
}

/**
 UIControlStateDisabled 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateDisabled:(nullable NSString *)title{
    
    [self setTitle:title forState:UIControlStateDisabled];
    
}


/**
 UIControlStateSelected 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateSelected:(nullable NSString *)title{
    
    [self setTitle:title forState:UIControlStateSelected];
    
}

/**
 UIControlStateHighlighted 状态文字
 
 @param title title
 */
- (void)ax_setTitleStateHighlighted:(nullable NSString *)title{
    
    [self setTitle:title forState:UIControlStateHighlighted];
    
}


/**
 UIControlStateNormal 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateNormal:(nullable UIColor *)color{
    
    [self setTitleColor:color forState:UIControlStateNormal];
    
}

/**
 UIControlStateHighlighted 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateHighlighted:(nullable UIColor *)color{
    
    [self setTitleColor:color forState:UIControlStateHighlighted];
    
}

/**
 UIControlStateDisabled 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateDisabled:(nullable UIColor *)color{
    
    [self setTitleColor:color forState:UIControlStateDisabled];
    
}

/**
 UIControlStateSelected 文字颜色
 
 @param color color
 */
- (void)ax_setTitleColorStateSelected:(nullable UIColor *)color{
    
    [self setTitleColor:color forState:UIControlStateSelected];
    
}


/**
 ax_setImageStateNormal image
 
 @param image image
 */
- (void)ax_setImageStateNormal:(NSString *)image{
    
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
}

/**
 UIControlStateHighlighted image
 
 @param image image
 */
- (void)ax_setImageColorStateHighlighted:(NSString *)image{
    
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    
}

/**
 UIControlStateDisabled image
 
 @param image image
 */
- (void)ax_setImageStateDisabled:(NSString *)image{
    
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateDisabled];
    
}

/**
 UIControlStateSelected image
 
 @param image image
 */
- (void)ax_setImageColorStateSelected:(NSString *)image{
    
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
}


@end
