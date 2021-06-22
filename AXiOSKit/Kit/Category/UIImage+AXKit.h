//
//  UIImage+AXKit.h
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片格式
 */
typedef NS_ENUM(NSUInteger, AXImageFormat) {
    AXImageFormatUndefined,
    AXImageFormatJPEG,
    AXImageFormatPNG,
    AXImageFormatGIF,
    AXImageFormatTIFF,
    AXImageFormatWebp,
};

@interface UIImage (AXKit)

/**
 将图片变成指定尺寸
 image 需要重绘的图片
 size 指定大小
 返回新的图片
 */
- (UIImage *)ax_imageScaleToSize:(CGSize)size;

/**
 将图片剪切成 指定半径 圆形
 
 @param radius 半径
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @return 返回新的图片
 */
- (UIImage *)ax_imageCircleWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 将图片剪切成圆形
 
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @return 返回新的图片
 */
- (UIImage *)ax_imageCircleWithBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor;

/**
 *将图片剪切成圆形
 *@param borderWidth 边框的宽度
 *@param borderColor 边框的颜色
 *@return 返回新的图片
 */

- (UIImage *)ax_circleImageWithBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor;

/**
 *  画颜色色线, |______| 形状线图片
 */
+(UIImage *)ax_imageLineWithColor:(UIColor *)aColor;

/**
 *  画颜色线, ______ 形状线图片
 */
+(UIImage *)ax_imageStraightLineWithColor:(UIColor *)aColor;

/**
 * 圆背景,和颜色 ,线宽
 */
+(UIImage *)ax_imageWithCircleColor:(UIColor *)aColor Size:(CGSize )aSzize Width:(CGFloat )aWidht;

/**
 * 矩形颜色图片
 */
+(UIImage *)ax_imageRectangleWithSize:(CGSize )aSzize color:(UIColor *)aColor;

/**
 正方形颜色图片CGSize(1.0f, 1.0f);
 */
+(UIImage *)ax_imageSquareWithColor:(UIColor *)color ;

/**
 * 圆形颜色图片
 radius 半径
 */
+(UIImage *)ax_imageCircularWithRadius:(CGFloat )radius color:(UIColor *)aColor;

/**
 * string 生成二维码
 */
+(UIImage *)ax_imageByString:(NSString *)codeStr toQRCodeWithWH:(CGFloat )wh;

/**
 * ax_navigationBarTopImage
 */
+(UIImage *)ax_navigationBarTopImage:(UIColor *)color;

/**
 *  去掉系统默认对图片的渲染(默认渲染成蓝色)，恢复图片原来的颜色
 *
 *  @param imageName 图片的名称
 *
 *  @return 未渲染的图片
 */
+ (UIImage *)ax_imageWithOriginalImageName:(NSString *)imageName;

/**
 初始化 UIImage 去掉系统默认对图片的渲染(默认渲染成蓝色)，恢复图片原来的颜色
 
 @param name name
 @return UIImage
 */
+ (UIImage *)ax_imageOriginalByName:(NSString *)name;

/**
 矩形图片-->正方形图片 以图片中心为中心，以最小边为边长，裁剪正方形图片
 
 @return 剪切图片
 */
- (UIImage *)ax_imageRectangleToSquare;

/**
 微信分享图片,必须小于32kb,且是正方形
 
 @param imageUrl url
 @return image
 */
+ (UIImage *)ax_ImageWeChatShareZipWithUrl:(NSString *)imageUrl;

/**
 UIImage 转换png data
 
 @return NSData
 */
-(NSData *)ax_toPNGData;

/**
 UIImage 转换JPEG data 1.0压缩
 
 @return NSData
 */
-(NSData *)ax_toJPEGData;

/**
 UIImage 转换JPEG data
 
 @param scale 压缩比例
 @return NSData
 */
-(NSData *)ax_toJPEGDataScale:(CGFloat )scale;

/**
 * 保存图片到系统相册
 */
- (void)ax_saveImageToPhotos;

//文字转化成图片

+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor;

+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize;

/// 获取图片上某个点的颜色值(不包含alpha)。
- (UIColor *)ax_pixelColorFromPoint:(CGPoint)point scale:(CGFloat)scale;

@property(nonatomic, assign, readonly) AXImageFormat ax_imageFormatType;

@property(nonatomic, copy, readonly) NSString *ax_mimeType;

@end

