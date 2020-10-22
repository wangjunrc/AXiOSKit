//
//  AXButton.m
//  Example
//
//  Created by AXing on 2019/1/17.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXButton.h"
#import "UIButton+AXKit.h"

@implementation AXButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

///**文字位置*/
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//
//    CGRect orgRect = [super titleRectForContentRect:contentRect];
//
//    switch (self.imagePosition) {
//        case AXButtonImagePositionLeft:
//            return orgRect;
//            break;
//        case AXButtonImagePositionRight:
//            return CGRectMake(0, orgRect.origin.y, orgRect.size.width, orgRect.size.height);
//            break;
//        case AXButtonImagePositionTop:{
//            //文字下
//            CGFloat titleY = self.currentImage.size.height;
//
//            CGFloat titleX = (self.size.width - [self.currentTitle ax_sizeWithaFont:[UIFont systemFontOfSize:17]].width)*0.5;
//
//            return CGRectMake(titleX, titleY, orgRect.size.width, orgRect.size.height);
//        }
//            break;
//        case AXButtonImagePositionBottom:{
//
//            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            //文字上
//              CGFloat titleX = (self.size.width - [self.currentTitle ax_sizeWithaFont:[UIFont systemFontOfSize:17]].width)*0.5;
//            return CGRectMake(0, titleX, orgRect.size.width, orgRect.size.height);;
//        }
//            break;
//        default:
//            return orgRect;
//            break;
//    }
//
//}
//
///**图片位置*/
//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//
//    CGRect orgRect =  [super imageRectForContentRect:contentRect];
//
//    switch (self.imagePosition) {
//        case AXButtonImagePositionLeft:
//            return orgRect;
//            break;
//        case AXButtonImagePositionRight:{
//            CGFloat imageX = contentRect.size.width-self.currentImage.size.width;
//            return CGRectMake(imageX, orgRect.origin.y, orgRect.size.width, orgRect.size.height);
//        }
//            break;
//        case AXButtonImagePositionTop:{
//            // 图片上
//            CGFloat imageX = (self.size.width - self.currentImage.size.width)*0.5;
//            return CGRectMake(imageX, 0, orgRect.size.width, orgRect.size.height);
//        }
//            break;
//        case AXButtonImagePositionBottom:{
//            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            // 图片下
//             CGFloat imageY = orgRect.size.height-self.currentImage.size.height;
//            return CGRectMake(0, imageY, orgRect.size.width, orgRect.size.height);;
//        }
//        default:
//            return orgRect;
//            break;
//    }
//}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self __setImagePosition:self.imagePosition spacing:0];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    
    [super setImage:image forState:state];
    [self __setImagePosition:self.imagePosition spacing:0];
}

- (void)setImagePosition:(AXButtonImagePosition)postion {
    _imagePosition = postion;
//    [self titleRectForContentRect:self.bounds];
//    [self imageRectForContentRect:self.bounds];
    [self __setImagePosition:postion spacing:0];
}

-(void)__setImagePosition:(AXButtonImagePosition)postion spacing:(CGFloat)spacing{
    [self ax_setImagePosition:postion spacing:0];
}

@end
