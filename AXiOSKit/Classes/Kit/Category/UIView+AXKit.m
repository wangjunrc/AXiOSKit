//
//  UIView+AXKit.m
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UIView+AXKit.h"

#import "AXMacros_addProperty.h"
#import <Masonry/Masonry.h>
#import "UIImage+AXKit.h"
typedef void(^DidViewBlock)(UIView *view);

@interface UIView ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy)DidViewBlock didViewBlock;

@end
@implementation UIView (AXKit)

/**
 * 指定 角 进行圆角
 */
- (void)ax_roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat )cornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

/**
 * 左右颤动一下
 */
- (void)ax_shakeByLeftAndRight{
    
    UIView * view = self;
    
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    [animation setAutoreverses:YES];
    
    // 设置时间
    [animation setDuration:.06];
    
    // 设置次数
    [animation setRepeatCount:3];
    
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}

/**
 渐变色
 
 @param colorArray UIColor 数组
 */
- (void)ax_gradientColors:(NSArray <UIColor*>*)colorArray{
    /**
     colors    渐变的颜色
     locations    渐变颜色的分割点
     
     startPoint&endPoint    颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，
     
     如(0,0)(1.0,0)代表水平方向渐变,
     
     (0,0)(0,1.0)代表竖直方向渐变
     */
    [self layoutIfNeeded];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    NSMutableArray *array = [NSMutableArray array];
    for (UIColor *color in colorArray) {
        [array addObject:(id)color.CGColor];
        
    }
    gradient.colors = array.copy;
    [self.layer insertSublayer:gradient atIndex:0];
}

/// 设置背景渐变色
/// @param colorArray 颜色
/// @param orientation 方法
- (void)ax_setBackgroundGradientColors:(NSArray <UIColor*>*)colorArray
                           orientation:(AXOrientation )orientation {
    
    UIView *view = self;
    [view layoutIfNeeded];
    UIImage *image = [UIImage ax_imageWithColors:colorArray
                                     orientation:orientation
                                            size:view.bounds.size];
    view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
}

/**
 为UIView的某个方向添加边框
 
 @param direction 边框方向
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)ax_addBorder:(AXBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width{
    
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    switch (direction) {
        case AXBorderDirectionTop:
        {
            border.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, width);
        }
            break;
        case AXBorderDirectionLeft:
        {
            border.frame = CGRectMake(0.0f, 0.0f, width, self.bounds.size.height);
        }
            break;
        case AXBorderDirectionBottom:
        {
            border.frame = CGRectMake(0.0f, self.bounds.size.height - width, self.bounds.size.width, width);
        }
            break;
        case AXBorderDirectionRight:
        {
            border.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.bounds.size.height);
        }
            break;
            
        default:
            break;
    }
    [self.layer addSublayer:border];
}


/**
 阴影
 当前veiw.layer.cornerRadius 后会和layer.shadowRadius 冲突
 
 @param shadowColor UIColor
 */
- (void)ax_shadowWith:(UIColor *)shadowColor{
    
    CALayer *subLayer=[CALayer layer];
    subLayer.frame = self.frame;
    subLayer.cornerRadius = 5;
    subLayer.backgroundColor = shadowColor.CGColor;
    subLayer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = CGSizeMake(0,1);//默认值 0,-3
    subLayer.shadowOpacity = 0.8;//阴影透明度，默认0
    subLayer.shadowRadius = 5;//阴影半径，默认3
    [self.superview.layer insertSublayer:subLayer below:self.layer];
}


/**
 * view 添加手势 成为点击事件
 */
- (void)ax_addViewActionBlock:(void(^)(id aView))block{
    self.userInteractionEnabled = YES;
    self.didViewBlock = block;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    
}
- (void)tapGestureAction:(UIGestureRecognizer *)sender{
    if (self.didViewBlock) {
        self.didViewBlock(self);
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self]) {
        return YES;
    }
    return NO;
}

/**
 找出绑定 ax_tag 的对象
 
 @param tag ax_tag
 @return view
 */
- (nullable __kindof UIView *)ax_viewWithTag:(NSString *)tag{
    
    
    UIView *aView = nil;
    
    for (UIView *subView in self.subviews) {
        
        if([subView.axTag isEqualToString:tag]){
            aView = subView;
            break;
        }else{
            aView = [subView ax_viewWithTag:tag];
            if (aView) {
                break;
            }
        }
    }
    
    return aView;
    
}

/**
 截屏 不含有转态栏  保存至相册
 */
- (void )ax_saveScreenShotsToPhotoAlbum{
    
    CGSize size = [[UIApplication sharedApplication] keyWindow].rootViewController.view.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(theImage, self, nil, nil);
}

/**
 当前view layer  重绘图片
 
 @return UIImage
 */
- (UIImage *)ax_drawRectToImage{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}



/**
 当前view layer  重绘图片,并保存到相册中
 */
- (void )ax_saveToPhotoAlbum{
    
    UIImage *theImage = [self ax_drawRectToImage];
    
    UIImageWriteToSavedPhotosAlbum(theImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
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
    shapeLayer.lineDashPattern=@[@(lineLength),@(lineSpacing)];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame)-20, 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


/**
 活动view响应 UIViewController
 
 @return UIViewController
 */
- (UIViewController *)ax_viewController {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - set and get

- (void)setDidViewBlock:(DidViewBlock)didViewBlock{
    ax_setCopyPropertyAssociated(didViewBlock);
}

- (DidViewBlock)didViewBlock{
    return ax_getValueAssociated(didViewBlock);
}

- (void)setAxTag:(NSString *)axTag{
    ax_setCopyPropertyAssociated(axTag);
}

- (NSString *)axTag{
    return ax_getValueAssociated(axTag);
}

- (void)ax_addLineDirection:(AXLineDirection)direction color:(UIColor *)color height:(NSInteger)height{
    
    if (direction & AXLineDirectionTop) {
        UIView *line = [UIView.alloc init];
        line.backgroundColor = color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self);
            make.height.equalTo(@(height));
        }];
    }
    
    if (direction & AXLineDirectionBottom) {
        UIView *line = [UIView.alloc init];
        line.backgroundColor = color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@(height));
        }];
    }
    
    if (direction & AXLineDirectionLeft) {
        UIView *line = [UIView.alloc init];
        line.backgroundColor = color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(height));
            make.left.equalTo(self);
            make.top.bottom.equalTo(self);
        }];
    }
    
    if (direction & AXLineDirectionRight) {
        UIView *line = [UIView.alloc init];
        line.backgroundColor = color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(height));
            make.right.equalTo(self);
            make.top.bottom.equalTo(self);
        }];
    }
}

/// UIBarButtonItem 尺寸约束
/// @param width 宽
/// @param height 高
-(void)ax_constraintButtonItemWidth:(CGFloat )width  height:(CGFloat )height {
    [self.widthAnchor constraintEqualToConstant:width].active =YES;
    [self.heightAnchor constraintEqualToConstant:height].active =YES;
}

/// 制作圆角（含部分圆角）
/// @param radius 圆角半径 只会影响背景色和边界，不会影响layer image content，如需裁切内容，参看masksToBounds属性
/// @param corners 圆角位置
/// @param masksToBounds 子layer是否剪切到layer的边界，为YES时会影响阴影的设置。
/// @Discussion
/// ⚠️低于iOS11的版本且为设置部分圆角的情况下，请在frame确认之后调用此方法。
///尤其是自动布局，可能需要先调用layoutIfNeeded确定frame之后再调用。低于iOS11的版本，设置圆角会影响阴影的设置，您可以使用额外的view来辅助显示阴影
- (void)ax_makeConerWithRadius:(CGFloat)radius
                       corners:(UIRectCorner)corners
                 masksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
    // 设置所有圆角
    // 直接使用与约束无关的属性，可以自动适应自动布局
    if (corners & UIRectCornerAllCorners) {
        self.layer.cornerRadius = radius;
        return;
    }
    // 设置部分圆角
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corners; //bit位一致
    } else {
        // 此方法需要在frame已经确定后才有效果，如果使用自动布局，则使用者可以需要在必要的时候调用 layoutIfNeeded 计算frame之后才有效果.
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}

@end
