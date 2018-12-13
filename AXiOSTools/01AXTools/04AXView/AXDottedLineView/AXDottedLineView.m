//
//  AXDottedLineView.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXDottedLineView.h"

@implementation AXDottedLineView



- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsLayout];
}

- (void)setLineLength:(int)lineLength{
    _lineLength = lineLength;
    [self setNeedsLayout];
}

- (void)setLineSpacing:(int)lineSpacing{
    _lineSpacing = lineSpacing;
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect {
   
   
    if (self.lineSpacing>0 && self.lineLength>0 && self.lineColor) {
        
        [self ax_addDottedLineWithLineLength:self.lineLength lineSpacing:self.lineSpacing lineColor:self.lineColor];
    }
    
    
}


/**
 layer 层 添加虚线
 
 @param lineLength 虚线每个长
 @param lineSpacing 虚线间隔
 @param lineColor 虚线颜色
 */
- (void)ax_addDottedLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    
    UIView *lineView = self;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
