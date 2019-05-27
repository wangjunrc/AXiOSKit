//
//  HistogramView.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/5/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "HistogramView.h"

@implementation HistogramView

- (void)drawRect:(CGRect)rect {
    
    //数据数组
    NSArray *arr = @[@20, @15, @70];
    
    //颜色数组
    NSArray *colorArr = @[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor]];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    
    NSUInteger count = arr.count;
    CGFloat w = viewW / (count * 2 - 1);
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat h = 0;
    
    for (int i = 0; i < count; i ++) {
        
        x = i * w * 2;
        h = ([arr[i] integerValue] / 100.0) * viewH;
        y = viewH - h;
        
        //画矩形柱体
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        //填充对应颜色
        [(UIColor *)colorArr[i] set];
        
        CGContextAddPath(ctx, path.CGPath);
        
        //注意是Fill, 而不是Stroke, 这样才可以填充矩形区域
        CGContextFillPath(ctx);
        
        //文本绘制
        NSString *str = [NSString stringWithFormat:@"%ld", [arr[i] longValue]];
        
        //创建文字属性字典
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        dic[NSForegroundColorAttributeName] = [UIColor blackColor];
        //设置笔触宽度
        dic[NSStrokeWidthAttributeName] = @1;
        
        //设置文字矩形的左上角位置,并且不会自动换行
        CGPoint p = CGPointMake(x + w * 0.25, y - 20);
        
        //drawInRect:会自动换行
        //drawAtPoint:不会自动换行
        [str drawAtPoint:p withAttributes:dic];
    }
}
@end
