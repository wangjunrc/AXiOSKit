//
//  UIImage+AXKit.m
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UIImage+AXKit.h"
#import "UIKit+AXAssistant.h"
@implementation UIImage (AXKit)

/**
 将图片变成指定尺寸
 image 需要重绘的图片
 size 指定大小
 返回新的图片
 */
- (UIImage *)ax_imageScaleToSize:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self drawInRect:CGRectMake(0,0,size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 将图片剪切成 指定半径 圆形
 
 @param radius 半径
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @return 返回新的图片
 */
- (UIImage *)ax_imageCircleWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    UIImage *image = self;
    //1.1.(计算画布尺寸,图片宽高+2倍线宽)
    CGFloat imageWidth = radius*2 + 2*borderWidth;
    CGFloat imageHeight = radius*2 + 2*borderWidth;
    
    //2.获取上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 1.0);
    
    //3.1.圆半径,以宽.高一半,最小的为半径
    //    CGFloat radius = diameter*0.5;
    //3.2.画圆
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth*0.5,imageHeight*0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //3.3.设置圆线宽
    bezierPath.lineWidth = borderWidth;
    
    //3.4.设置边界颜色
    if (borderColor) {
        [borderColor setStroke];
        [bezierPath stroke];
    }
    //3.5.填充背景
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    
    //3.6.剪切
    [bezierPath addClip];
    
    //4.1.画图片
    [image drawInRect:CGRectMake(borderWidth, borderWidth,radius*2,radius*2)];
    
    //5.得到新图片
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    //6关闭上下文
    UIGraphicsEndImageContext();
    //7.返回新图片
    return tempImage;
}

/**
 将图片剪切成圆形
 
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @return 返回新的图片
 */
- (UIImage *)ax_imageCircleWithBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor{
    UIImage *image = self;
    //1.1.(计算画布尺寸,图片宽高+2倍线宽)
    CGFloat imageWidth = image.size.width + 2*borderWidth;
    CGFloat imageHeight = image.size.height + 2*borderWidth;
    
    //2.获取上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 1.0);
    
    //3.1.圆半径,以宽.高一半,最小的为半径
    CGFloat radius = MIN(image.size.width*0.5,image.size.height*0.5);
    //3.2.画圆
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth*0.5,imageHeight*0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //3.3.设置圆线宽
    bezierPath.lineWidth = borderWidth;
    
    //3.4.设置边界颜色
    if (borderColor) {
        [borderColor setStroke];
        [bezierPath stroke];
    }
    //3.5.填充背景
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    
    //3.6.剪切
    [bezierPath addClip];
    
    //4.1.画图片
    [image drawInRect:CGRectMake(borderWidth, borderWidth,image.size.width,  image.size.height)];
    
    //5.得到新图片
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    //6关闭上下文
    UIGraphicsEndImageContext();
    //7.返回新图片
    return tempImage;
}

/**
 *将图片剪切成圆形
 *@param borderWidth 边框的宽度
 *@param borderColor 边框的颜色
 *@return 返回新的图片
 */

- (UIImage *)ax_circleImageWithBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor{
    UIImage *image = self;
    //1.1.(计算画布尺寸,图片宽高+2倍线宽)
    CGFloat imageWidth = image.size.width + 2*borderWidth;
    CGFloat imageHeight = image.size.height + 2*borderWidth;
    
    //2.获取上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 1.0);
    
    //3.1.圆半径,以宽.高一半,最小的为半径
    CGFloat radius = MIN(image.size.width*0.5,image.size.height*0.5);
    //3.2.画圆
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth*0.5,imageHeight*0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //3.3.设置圆线宽
    bezierPath.lineWidth = borderWidth;
    
    //3.4.设置边界颜色
    [borderColor setStroke];
    [bezierPath stroke];
    //3.5.填充背景
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    
    //3.6.剪切
    [bezierPath addClip];
    
    //4.1.画图片
    [image drawInRect:CGRectMake(borderWidth, borderWidth,image.size.width,  image.size.height)];
    
    //5.得到新图片
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    //6关闭上下文
    UIGraphicsEndImageContext();
    //7.返回新图片
    return tempImage;
    
}


+(UIImage *)ax_imageLineWithColor:(UIColor *)aColor{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 4);
    UIBezierPath *path =[UIBezierPath bezierPath];
    //    NSArray *a = [NSArray arrayWithObject:path];
    
    //2.直接绘制路线
    [path moveToPoint:CGPointMake(0, 60)];
    [path addLineToPoint:CGPointMake(0, 75)];
    [path addLineToPoint:CGPointMake(80, 75)];
    [path addLineToPoint:CGPointMake(80, 60)];
    //3.关闭路径
    //    [path closePath];
    
    //4.设置线宽度
    path.lineWidth = 1;
    //4.2.线头的样式(线头多出的部分,才能看到)
    //    path.lineCapStyle = kCGLineCapRound;
    //4.3.线头连接处
    path.lineJoinStyle = kCGLineJoinBevel;
    //5.1.设置描边和填充的颜色
    [aColor setStroke];
    //    [[UIColor yellowColor]setFill];
    //5.2..按路径填充和描边颜色(有先后顺利,会影响描边的大小,2个单独的方法,C函数方法是三个方法)
    //    [path fill];
    [path stroke];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
    
    
}
/**
 *  画颜色线, ______ 形状线图片
 */
+(UIImage *)ax_imageStraightLineWithColor:(UIColor *)aColor{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 4);
    UIBezierPath *path =[UIBezierPath bezierPath];
    //2.直接绘制路线
    [path moveToPoint:CGPointMake(0, 79)];
    [path addLineToPoint:CGPointMake(80, 79)];
    //3.关闭路径
    [path closePath];
    //4.设置线宽度
    path.lineWidth = 1;
    path.lineJoinStyle = kCGLineJoinBevel;
    [aColor setStroke];
    [path stroke];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}

/**
 * 圆背景,和颜色
 */
+(UIImage *)ax_imageWithCircleColor:(UIColor *)aColor Size:(CGSize )aSzize Width:(CGFloat )aWidht{
    
    UIGraphicsBeginImageContextWithOptions(aSzize, NO,0);
    UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(aWidht, aWidht, aSzize.width-2*aWidht,aSzize.height-2*aWidht)];
    path.lineWidth = aWidht;
    [[UIColor whiteColor] setStroke];
    [aColor setFill];
    [path stroke];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}

/**
 * 矩形颜色图片
 */
+(UIImage *)ax_imageRectangleWithSize:(CGSize )aSzize color:(UIColor *)aColor{
    
    UIGraphicsBeginImageContextWithOptions(aSzize, NO,0);
    
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, aSzize.width, aSzize.height)];
    
    [[UIColor whiteColor] setStroke];
    [aColor setFill];
    [path stroke];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}

/**
 矩形颜色图片CGSize(1.0f, 1.0f);
 */
+(UIImage *)ax_imageSquareWithColor:(UIColor *)aColor {
    
    return [self ax_imageRectangleWithSize:CGSizeMake(1.0f, 1.0f) color:aColor];
    //    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //    CGSize aSize = rect.size;
    //    UIGraphicsBeginImageContextWithOptions(aSize, NO, 0.0);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //
    //    CGContextSetFillColorWithColor(context, [color CGColor]);
    //    CGContextFillRect(context, rect);
    //
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    return image;
    
}

/**
 * 圆形颜色图片
 */
+(UIImage *)ax_imageCircularWithRadius:(CGFloat )radius color:(UIColor *)aColor{
    
    UIGraphicsBeginImageContextWithOptions( CGSizeMake(radius*2, radius*2), NO,0);
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [[UIColor whiteColor] setStroke];
    [aColor setFill];
    [path stroke];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
    
}

/**
 * string 生成二维码
 */
+(UIImage *)ax_imageByString:(NSString *)codeStr toQRCodeWithWH:(CGFloat )wh{
    // 生成二维码图片
    NSData *data = [codeStr dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:YES];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *codeImage = filter.outputImage;
    
    // 消除模糊
    CGFloat scaleX = wh / codeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = wh / codeImage.extent.size.height;
    CIImage *transformedImage = [codeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

/**
 * ax_navigationBarTopImage
 */
+(UIImage *)ax_navigationBarTopImage:(UIColor *)color{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ax_screen_width(), 64), NO,0);
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ax_screen_width(), 64)];
    [color setFill];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
    
}


/**
 *  去掉系统默认对图片的渲染(默认渲染成蓝色)，恢复图片原来的颜色
 *
 *  @param imageName 图片的名称
 *
 *  @return 未渲染的图片
 */
+ (UIImage *)ax_imageWithOriginalImageName:(NSString *)imageName{
    return  [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


/**
 初始化 UIImage 去掉系统默认对图片的渲染(默认渲染成蓝色)，恢复图片原来的颜色
 
 @param name name
 @return UIImage
 */
+ (UIImage *)ax_imageOriginalByName:(NSString *)name{
    
    return [[UIImage imageNamed:name]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}


/**
 矩形图片-->正方形图片 以图片中心为中心，以最小边为边长，裁剪正方形图片
 
 @return 剪切图片
 */
- (UIImage *)ax_imageRectangleToSquare{
    
    UIImage *image = self;
    CGImageRef sourceImageRef = [image CGImage];//将UIImage转换成CGImageRef
    
    CGFloat _imageWidth = image.size.width * image.scale;
    CGFloat _imageHeight = image.size.height * image.scale;
    CGFloat _width = _imageWidth > _imageHeight ? _imageHeight : _imageWidth;
    CGFloat _offsetX = (_imageWidth - _width) / 2;
    CGFloat _offsetY = (_imageHeight - _width) / 2;
    
    CGRect rect = CGRectMake(_offsetX, _offsetY, _width, _width);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);//按照给定的矩形区域进行剪裁
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}

/**
 微信分享图片,必须小于32kb,且是正方形
 
 @param imageUrl url
 @return image
 */
+ (UIImage *)ax_ImageWeChatShareZipWithUrl:(NSString *)imageUrl{
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (image.size.width != image.size.height ) {
        CGFloat hw = MIN(image.size.width, image.size.height);
        image = [image ax_imageScaleToSize:CGSizeMake(hw, hw)];
    }
    if (imageData.length>32768) {
        image = [self ax_compressImage:image toByte:32768];
    }
    return image;
    
}


+ (UIImage *)ax_compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1; CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
            
        } else if (data.length > maxLength) { max = compression;
            
        } else {
            break;
            
        }
        
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        // Use NSUInteger to preventwhite blank
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        
    }
    return resultImage;
    
}


/**
 * 保存图片到系统相册
 */
- (void)ax_saveImageToPhotos{
    UIImage *image = self;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
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
 UIImage 转换png data
 
 @return NSData
 */
-(NSData *)ax_toPNGData {
    return   UIImagePNGRepresentation(self);
}

/**
 UIImage 转换JPEG data 1.0压缩
 
 @return NSData
 */
-(NSData *)ax_toJPEGData {
    return UIImageJPEGRepresentation(self, 1.0);
}

/**
 UIImage 转换JPEG data
 
 @param scale 压缩比例
 @return NSData
 */
-(NSData *)ax_toJPEGDataScale:(CGFloat )scale {
    return UIImageJPEGRepresentation(self, scale);
}

//文字转化成图片

+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor

{
    
    // set the font type and size
    
    
    
    UIFont *font = [UIFont fontWithName:@"Heiti SC" size:fontSize];
    
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    
    
    CGFloat fHeight = 0.0f;
    
    for (NSString *sContent in arrContent) {
        
        //        CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        NSDictionary *attributes = @{NSFontAttributeName:font};
        CGSize stringSize=[sContent boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        
        
        fHeight += stringSize.height;
        
    }
    
    
    
    CGSize newSize = CGSizeMake(MAXFLOAT+20, fHeight+50);
    
    
    
    // Create a stretchable image for the top of the background and draw it
    
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    
    //如果设置了背景图片
    
    if(bgImage)
        
    {
        
        UIImage* stretchedTopImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        
        [stretchedTopImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        
    }else
        
    {
        
        if(bgColor)
            
        {
            
            //填充背景颜色
            
            [bgColor set];
            
            UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
            
        }
        
    }
    
    
    
    CGContextSetCharacterSpacing(ctx, 10);
    
    CGContextSetTextDrawingMode (ctx, kCGTextFillClip);
    
    [textColor set];
    
    
    
    int nIndex = 0;
    
    CGFloat fPosY = 20.0f;
    
    for (NSString *sContent in arrContent) {
        
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        
        CGRect rect = CGRectMake(10, fPosY, MAXFLOAT , [numHeight floatValue]);
        
        
        
        [sContent drawInRect:rect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
        
        fPosY += [numHeight floatValue];
        
        nIndex++;
        
    }
    
    
    
    // transfer image
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
    
    
}

#define CONTENT_MAX_WIDTH   300.0f
+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize
{
    // set the font type and size
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) lineBreakMode:UILineBreakModeWordWrap];
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        fHeight += stringSize.height;
    }
    
    
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFillStroke);
    //    CGContextSetFillColorWithColor(ctx, [UIColor.redColor CGColor]);
    
    [UIColor.redColor set];
    //   CGContextSetRGBStrokeColor (ctx, 0, 0, 0, 1);
    
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, CONTENT_MAX_WIDTH , [numHeight floatValue]);
        
        
        [sContent drawInRect:rect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
        
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
}



/// 获取图片上某个点的颜色值(不包含alpha)。
- (UIColor *)ax_pixelColorFromPoint:(CGPoint)point scale:(CGFloat)scale {
    // 判断点是否超出图像范围
    if (!CGRectContainsPoint(CGRectMake(0, 0, self.size.width*scale, self.size.height*scale), point)){
        NSLog(@"判断点是否超出图像范围");
        return nil;
    }
    // 将像素绘制到一个1×1像素字节数组和位图上下文。
    NSInteger pointX = trunc(point.x/scale);
    NSInteger pointY = trunc(point.y/scale);
    CGImageRef cgImage = self.CGImage;
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // 将指定像素绘制到上下文中
    CGContextTranslateCTM(context, -pointX, pointY - height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), cgImage);
    CGContextRelease(context);
    
    CGFloat red = (CGFloat)pixelData[0] / 255.0;
    CGFloat green = (CGFloat)pixelData[1] / 255.0;
    CGFloat blue = (CGFloat)pixelData[2] / 255.0;
    CGFloat al = (CGFloat)pixelData[3];
    NSLog(@"获取图片上某个点的颜色值 = %.2lf, %.2lf, %.2lf", red, green, blue);
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:al];
    return color;
}


- (AXImageFormat)ax_imageFormatType {
    
    UIImage *image = self;
    //NSData转换为UIImage
    //    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //    UIImage *image = [UIImage imageWithData:imageData];
    //UIImage转换为NSData
    NSData *data = UIImageJPEGRepresentation(image,1.0f);//第二个参数为压缩倍数
    
    if (!data) {
        return AXImageFormatUndefined;
    }
    
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return AXImageFormatJPEG;
            
        case 0x89:
            return AXImageFormatPNG;
            
        case 0x47:
            return AXImageFormatGIF;
            
        case 0x40:
        case 0x4D:
            return AXImageFormatTIFF;
            
        case 0x52:
            if (data.length < 12) {
                return AXImageFormatUndefined;
            }
            
            NSString *str = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([str hasPrefix:@"RIFF"] && [str hasSuffix:@"WEBP"]) {
                return AXImageFormatWebp;
            }
    }
    return AXImageFormatUndefined;
    
    
}

- (NSString *)ax_mimeType {
    
    UIImage *image = self;
    //NSData转换为UIImage
    //    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //    UIImage *image = [UIImage imageWithData:imageData];
    //UIImage转换为NSData
    NSData *data = UIImageJPEGRepresentation(image,1.0f);//第二个参数为压缩倍数
    
    if (!data) {
        return nil;
    }
    
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
            break;
        case 0x89:
            return @"image/png";
            break;
        case 0x47:
            return @"image/gif";
            break;
        case 0x49:
        case 0x4D:
            return @"image/tiff";
            break;
        case 0x25:
            return @"application/pdf";
            break;
        case 0xD0:
            return @"application/vnd";
            break;
        case 0x46:
            return @"text/plain";
            break;
        default:
            return @"application/octet-stream";
    }
    return nil;
}


+ (UIImage *)ax_imageFromGradientColors:(NSArray*)colors
                           gradientType:(AXGradientType)gradientType
                                imgSize:(CGSize)imgSize {
    
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        
        [ar addObject:(id)c.CGColor];
        
    }
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    switch (gradientType) {
            
        case AXGradientTypeTopToBottom:
            
            start = CGPointMake(0.0, 0.0);
            
            end = CGPointMake(0.0, imgSize.height);
            
            break;
            
        case AXGradientTypeLeftToRight:
            
            start = CGPointMake(0.0, 0.0);
            
            end = CGPointMake(imgSize.width, 0.0);
            
            break;
            
        case AXGradientTypeUpleftToLowright:
            
            start = CGPointMake(0.0, 0.0);
            
            end = CGPointMake(imgSize.width, imgSize.height);
            
            break;
            
        case AXGradientTypeUprightToLowleft:
            
            start = CGPointMake(imgSize.width, 0.0);
            
            end = CGPointMake(0.0, imgSize.height);
            
            break;
            
        default:
            
            break;
            
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end

