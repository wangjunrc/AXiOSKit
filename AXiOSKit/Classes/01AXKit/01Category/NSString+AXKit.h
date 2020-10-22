//
//  NSString+AXKit.h
//  44
//
//  Created by liuweixing on 15/8/25.
//  Copyright (c) 2015年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AXiOSKit.h"
@interface NSString (AXKit)

/**
 * 文件路径
 */
+(NSString *)ax_documentPath;

/**
 * 文件路径
 */
+(NSString *)ax_libraryPaths;

/**
 * 文件路径
 */
+(NSString *)ax_tmpPath;

/**
 * 获得home后部分的路径,
 */
- (NSString *)ax_getDidHomePath;

/**
 * 拼接home路径,得到全路径
 */
- (NSString *)ax_addHomePath;

/**
 * 文字:计算单行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font;

/**
 * 文字:计算多行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font lineNumber:(NSInteger )number;

/**
 * 文字:根据指定宽度,得到高度
 
 */
- (CGFloat )ax_heightWithaFont:(UIFont *)font width:(CGFloat )width;

/**
 * 文字:根据指定宽度,得到size
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font width:(CGFloat )width;


/**
 * 随机生成指定长度的数字,字母组合的字符串
 */
+(NSString *)ax_stringRandomlyWithCount:(NSInteger )count;

/**
 * 项目工程版本号
 */

+(NSString *)ax_getAppVersion;

/**
 * 获取应用程序名称
 */
+ (NSString*)ax_getAppName;

/**
 * 获取应用程序 编译版本
 */
+ (NSString*)ax_getAppBulid;

/**
 * 获取应用程序的 BundleID
 */
+ (NSString*)ax_getAppBundleID;

/**
 * 获取应用程序的 infor 路径
 */
+ (NSString*)ax_getAppInfoPlistPath;

/**
 * 获取应用程序的 URLSchemes URLName为手工填入的
 */
+ (NSString*)ax_getAppURLSchemesByURLName:(NSString *)URLName;

/**
 * 获取设备的ip地址
 */
+(NSString *)ax_getDeviceIP;

/**
 * 获取设备信息
 */
+ (NSString *)ax_getDeviceInfo;

/**
 * string 生成二维码
 */
- (UIImage *)ax_stringToQRCodeWithWH:(CGFloat )wh;

/**
 * 拼接 tel://
 */
- (NSString *)ax_byPhone;

/**
 * 是否含有Emoji表情
 */
- (BOOL)ax_isContainsEmoji;

/**
 * 转换为UTF8,与UTF8String有区别
 */
- (NSString *)ax_toUTF8;

/**
 url Encoding 编码集
 
 @return NSString
 */
- (NSString *)ax_toEncoding;

/**
 Encoding 编码集 转  中文
 
 @return NSString
 */
- (NSString *)ax_toUnEncoding;

/**
 * 获得文件内,指定文件,只有文件名
 */
- (NSMutableArray *)ax_getFileNameListName:(NSString *)name;

/**
 * 获得文件内,指定文件,全路径
 */
- (NSMutableArray *)ax_getFileNameListFullpath:(NSString *)name;

/**
 * 获得文件内所以内容
 */
- (NSArray *)ax_getContentsOfDirectory;

/**
 * 显示万元单位
 */
- (NSString *)ax_keepWanYuan;

/**
 * 显示万元单位 ,有前缀
 */
- (NSString *)ax_keepWanYuanWithPrefix:(NSString *)prefix;

/**
 * 头部拼接一个字串
 */
- (NSString *)ax_addHeadPrefix:(NSString *)prefix;

/**
 截取头尾  中间显示*号
 
 @param headLength 头 需要保留的长度
 @param endLength 尾 需要保留的长度
 @return 返回结果
 */
- (NSString *)ax_substringHeadLength:(NSInteger )headLength endLength:(NSInteger )endLength;

/**
 11位手机号码,中间4位省略
 
 @return 号码
 */
- (NSString *)ax_phoneNumSecret;

/**
 * url 拼接,用别的办法,不然就出现 http:// 变成  http:/ 或者? 不识别
 */
- (NSString *)ax_urlStringtAppending:(NSString *)str;

/**
 生成唯一的字符串UUID
 
 @return 字符串
 */
+(NSString *)ax_uuid;

/**
 拼接成 tel:// 格式
 
 @return return value description
 */
- (NSURL *)ax_toTelURL;

/**
 2位小数 解决json解析小数异常,一般因为该小数为2位,所以这里强制用.2lf
 如用另外方法 ax_to2Decimal2
 
 @return NSString
 */
- (NSString *)ax_to2Decimal DEPRECATED_MSG_ATTRIBUTE ("使用字典转模型,属性类型为float,可以避免此情况") ;

/**
 count位小数
 
 @return NSString
 */
- (NSString *)ax_toCountDecimal:(NSInteger )count;
/**
 2位小数
 @return NSString
 */
- (NSString *)ax_to2Decimal2;


/**
 时间秒 转换 时分秒 字符串
 
 @param seconds 秒
 @return str
 */
+(NSString *)ax_getHHMMSSWithSeconds:(NSInteger )seconds;

/**
 去除首尾空格
 
 @return NSString
 */
- (NSString *)ax_removeHeadFootWhitespace;

/**
 去除首尾换行
 
 @return NSString
 */
- (NSString *)ax_removeHeadFootNewline;

/**
 去除首尾空格和换行
 
 @return NSString
 */
- (NSString *)ax_removeHeadFootWhitespaceeAndNewline;

/**
 当前string 正则 inString 中的 需要的
 
 @param inString 需要保留的
 @return NSString
 */
-(NSString *)ax_scannerInString:(NSString *)inString;
/**
 当前string 正则 upToString 中的 不需要的
 
 @param upToString 不需要保留的
 @return NSString
 */
-(NSString *)ax_scannerUpToString:(NSString *)upToString;

/**
 url path 拼接参数
 
 @param parameter 参数
 @return path
 */
-(NSString *)ax_pathAppendingWithParameter:(NSDictionary <NSString *,NSString *>*)parameter;

///**
// 含有Unicode的字串 to emoj 表情,用于显示
// 中文也是Unicode的一种
// @return 含有emoj表情的string
// */
//-(NSString *)ax_unicodeToEmojiCode;
//
///**
// emoj 表情  转 Unicode的字串,用于存储
//
// @return 含有Unicode的字串
// */
//-(NSString *)ax_emojiCodeToUnicode;


+ (instancetype)ax_stringWithFormat:(NSString *)format,... NS_FORMAT_FUNCTION(1,2);


/********************** validation *************************/

/**
 是不是含有表情
 */
@property (nonatomic, readonly) BOOL ax_containsEmoji;

/**
 判断是不是干净的int数据
 */
@property (nonatomic, readonly) BOOL ax_isPureIntNumber;

/**
 是否是邮箱
 */
@property (nonatomic, readonly) BOOL ax_conformsToEMailFormat;

/**
 身份是身份证
 */
@property (nonatomic, readonly) BOOL ax_conformsIDCard;

/**
 是否是中文字符
 */
@property (nonatomic, readonly) BOOL ax_isChineseCharacter;

/**
 是否是number或者英文或者中文
 */
@property (nonatomic, readonly) BOOL ax_isNumberOrEnglishOrChineseCharacter;

/**
 是否是纯正的Decimal
 */
@property (nonatomic, readonly) BOOL ax_isPureDecimalDigits;

/**
 是否包含非法字符
 
 @return YES：包含了非法字符 NO：没有包含非法字符
 */
@property (nonatomic, readonly) BOOL ax_containInvalidString;

/**
 去掉空格、空行之后判断是否为空
 */
@property (nonatomic, readonly) BOOL ax_isEmptyAfterTrimmingWhitespaceAndNewlineCharacters;

///  NSString中的数字变小
/// @param fontSize 字号
-(NSMutableAttributedString*)ax_smallerNumberWitSize:(CGFloat )fontSize;

//截取字符前多少位，处理emoji表情问题
////🐒🐒🐒🐒 + 截取3 = 🐒🐒🐒
-(NSString *)ax_subStringContainsEmojiWithLength:(NSInteger)limitLength;
@end
