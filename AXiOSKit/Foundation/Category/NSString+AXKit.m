//
//  NSString+AXKit.m
//  44
//
//  Created by liuweixing on 15/8/25.
//  Copyright (c) 2015年 liuweixing. All rights reserved.
//

#import "NSString+AXKit.h"
#import <CommonCrypto/CommonCrypto.h>
#include<stdio.h>
#include<stdlib.h>
#include<errno.h>
#include<string.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<sys/socket.h>
#include<sys/wait.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include <arpa/inet.h>
#include<netdb.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <net/if.h>
@implementation NSString (AXKit)

+(NSString *)ax_documentDirectory{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ).firstObject;
}

+(NSString *)ax_libraryPaths {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}

+(NSString *)ax_applicationSupportDirectory {
    return NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES ).firstObject;
}

+(NSString *)ax_tmpPath{
    return  NSTemporaryDirectory();
}

/// 存放缓存
+(NSString *)ax_cachesDomainMask {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

/// 系统启动图缓存路径
+ (NSString *)ax_launchImageCacheDirectory {
    NSString *bundleID = [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // iOS13之前
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *snapshotsPath = [[cachesDirectory stringByAppendingPathComponent:@"Snapshots"] stringByAppendingPathComponent:bundleID];
    if ([fileManager fileExistsAtPath:snapshotsPath]) {
        return snapshotsPath;
    }
    
    // iOS13
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    snapshotsPath = [NSString stringWithFormat:@"%@/SplashBoard/Snapshots/%@ - {DEFAULT GROUP}", libraryDirectory, bundleID];
    if ([fileManager fileExistsAtPath:snapshotsPath]) {
        return snapshotsPath;
    }
    
    return nil;
}

/**
 * 获得home后部分的路径,
 */
- (NSString *)ax_getDidHomePath{
    NSString *temp = [NSString stringWithFormat:@"%@/",NSHomeDirectory()];
    return  [self componentsSeparatedByString:temp].lastObject;
}
/**
 * 拼接home路径,得到全路径
 */
- (NSString *)ax_addHomePath{
    NSString *home = NSHomeDirectory();
    return [home stringByAppendingPathComponent:self];
}


- (CGSize )ax_sizeWithLabel:(UILabel *)label{
    
    NSDictionary *attributes = @{NSFontAttributeName:label.font};
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}
/**
 * 文字:计算单行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}
/**
 * 文字:计算多行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font lineNumber:(NSInteger )number{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return CGSizeMake(size.width/number, size.height*number);
    
}

/**
 * 文字:根据指定宽度,得到高度
 */
- (CGFloat )ax_heightWithaFont:(UIFont *)font width:(CGFloat )width{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size.height;
}
/**
 * 根据指定宽度,得到size
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font width:(CGFloat )width{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
    
}
/**
 * 随机生成指定长度的数字,字母组合的字符串
 */
+(NSString *)ax_stringRandomlyWithCount:(NSInteger )count{
    
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < count; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

+ (NSDictionary*)ax_getAppInfo{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return info;
}

/**
 * 项目工程版本号
 */

+(NSString *)ax_getAppVersion{
    NSDictionary *info = [self ax_getAppInfo];
    return [info[@"CFBundleShortVersionString"]stringValue];
}

/**
 * 获取应用程序名称
 */
+ (NSString*)ax_getAppName{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleName"];
}

/**
 * 获取应用程序 编译版本
 */
+ (NSString*)ax_getAppBulid{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleVersion"];
}

/**
 * 获取应用程序的 BundleID
 */
+ (NSString*)ax_getAppBundleID{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleIdentifier"];
}

/**
 * 获取应用程序的 AppIcon
 */
+ (NSString*)ax_getAppIcon {
    NSDictionary *info = [self ax_getAppInfo];
    return [[[info valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject] stringValue];
}

/**
 * 获取应用程序的 infor 路径
 */
+ (NSString*)ax_getAppInfoPlistPath{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleInfoPlistURL"];
}

/**
 * 获取应用程序的 URLSchemes URLName为手工填入的
 */
+ (NSString*)ax_getAppURLSchemesByURLName:(NSString *)URLName{
    
    NSDictionary *bundleInfo = [NSBundle mainBundle].infoDictionary;
    NSArray *URLTypes = bundleInfo[@"CFBundleURLTypes"];
    
    //    NSString *bundleID=bundleInfo[@"CFBundleIdentifier"];
    
    
    NSString *scheme = nil;
    for (NSDictionary *dic in URLTypes) {
        if ([dic[@"CFBundleURLName"] isEqualToString:URLName]) {
            scheme = dic[@"CFBundleURLSchemes"][0];
            break;
        }
        ;
    }
    return scheme;
}

/** 获取设备的ip地址 */
+ (NSString *)ax_getDeviceIP{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) return nil;
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP = ips.lastObject;
    return deviceIP;
}

/** 获取设备信息 */
+ (NSString *)ax_getDeviceInfo {
    UIDevice *device = [[UIDevice alloc] init];
    return [NSString stringWithFormat:@"%@|%@|%@",device.name,device.systemName,device.systemVersion];
}


/**
 * string 生成二维码
 */
- (UIImage *)ax_stringToQRCodeWithWH:(CGFloat )wh{
    NSString *codeStr = self;
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
 * 拼接 tel://
 */
- (NSString *)ax_byPhone{
    return [NSString stringWithFormat:@"tel://%@",self];
}



//是否含有Emoji表情
- (BOOL)ax_isContainsEmoji{
    NSString *string = self;
    __block BOOL returnValue = NO;
    
    //    xF0\x9F\xA4\x97
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                    
                                    
                                    
                                }
                            }];
    
    return returnValue;
}


/**
 * 转换为UTF8,与UTF8String有区别
 */
- (NSString *)ax_toUTF8{
    return  [NSString stringWithCString:self.UTF8String encoding:NSUTF8StringEncoding];
}

/**
 中文转 Encoding 编码集
 
 @return NSString
 */
- (NSString *)ax_toEncoding {
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;
}

/**
 Encoding 编码集 转  中文
 
 @return NSString
 */
- (NSString *)ax_fromEncoding {
    
    return [self stringByRemovingPercentEncoding];
}


/**
 * 获得文件内所有内容
 */
- (NSArray *)ax_getContentsOfDirectory{
    
    NSString *dirPath = self;
    
    
    //    NSMutableArray *filenamelist = [NSMutableArray array];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        
        return @[];
    }
    
    
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    
    return tmplist;
}




/**
 * 获得文件内,指定文件,只有文件名
 */
- (NSMutableArray *)ax_getFileNameListName:(NSString *)name{
    
    return  [self ax_toolFileName:name type:@"Name"];
}

/**
 * 获得文件内,指定文件,全路径
 */
- (NSMutableArray *)ax_getFileNameListFullpath:(NSString *)name{
    
    return  [self ax_toolFileName:name type:@"Full"];
}

/**
 * 获得文件内,封装方法
 */
- (NSMutableArray *)ax_toolFileName:(NSString *)name  type:(NSString *)type{
    
    NSString *hostPath = self;
    
    NSMutableArray *temp = [NSMutableArray array];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:hostPath]) {
        
        return temp;
    }
    
    
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:hostPath error:nil];
    
    for (NSString *filename in tmplist) {
        
        NSString *fullpath = [hostPath stringByAppendingPathComponent:filename];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullpath]) {
            
            if ([[filename pathExtension] isEqualToString:name]) {
                if ([type isEqual:@"Full"]) {
                    [temp  addObject:fullpath];
                    
                }
                
                if ([type isEqual: @"Name"]) {
                    [temp  addObject:filename];
                    
                }
                
            }
        }
    }
    
    return temp;
    
}

/**
 * 显示万元单位
 */
- (NSString *)ax_keepWanYuan{
    if (self.doubleValue>10000) {
        return [NSString stringWithFormat:@"%.2lf 万元",self.doubleValue/10000];
    }else if (self.doubleValue>0){
        return [NSString stringWithFormat:@"%@ 元",self];
        
    }else{
        return  @"0 元";
    }
}

/**
 * 显示万元单位 ,有前缀
 */
- (NSString *)ax_keepWanYuanWithPrefix:(NSString *)prefix{
    if (self.doubleValue>10000) {
        return [NSString stringWithFormat:@"%@%.2lf 万元",prefix,self.doubleValue/10000];
    }else if (self.doubleValue>0){
        return [NSString stringWithFormat:@"%@%@ 元",prefix,self];
        
    }else{
        return [NSString stringWithFormat:@"%@0 元",prefix];
    }
}

/**
 * 头部拼接一个字串
 */
- (NSString *)ax_addHeadPrefix:(NSString *)prefix{
    return [NSString stringWithFormat:@"%@%@",prefix,self];
}


/**
 * 截取头尾  中间显示*号
 */
- (NSString *)ax_substringHeadLength:(NSInteger )headLength endLength:(NSInteger )endLength{
    
    NSInteger middleLength = self.length - headLength - endLength;
    
    if (middleLength<=0) {
        return self;
    }
    
    NSString *str1 = [self substringToIndex:headLength];
    NSString *str2 = [self substringFromIndex:self.length-endLength];
    NSMutableString *tempStr = [NSMutableString string];
    for (NSInteger index=0; index<middleLength; index++) {
        [tempStr appendString:@"*"];
    }
    
    return [NSString stringWithFormat:@"%@%@%@",str1,tempStr,str2];
    
}

/**
 * url 拼接,用别的办法,不然就出现 http:// 变成  http:/ 或者? 不识别
 */
- (NSString *)ax_urlStringtAppending:(NSString *)str{
    
    //    NSString *temp = nil;
    NSString *head = nil;
    if ( [self hasPrefix:@"https://"]) {
        head = @"https://";
    }else if ( [self hasPrefix:@"http://"]){
        head = @"http://";
    }
    NSString *temp = [[self componentsSeparatedByString:head].lastObject stringByAppendingPathComponent:str];
    return [NSString stringWithFormat:@"%@%@",head,temp];
}

/**
 生成唯一的字符串UUID
 
 @return 字符串,大写
 */
+(NSString *)ax_uuid{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uuidStr = (__bridge NSString *)uuidStrRef;
    CFRelease(uuidStrRef);
    return uuidStr;
}


/**
 11位手机号码,中间4位省略
 
 @return 号码
 */
- (NSString *)ax_phoneNumSecret{
    
    if (self.length==11) {
        NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return numberString;
    }else{
        return self;
    }
}



/**
 拼接成 tel:// 格式
 
 @return return value stringValue
 */
- (NSURL *)ax_toTelURL{
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self]];
}



/**
 2位小数 解决json解析小数异常,一般因为该小数为2位,所以这里强制用.2lf
 如用另外方法 ax_to2Decimal2
 
 @return NSString
 */
- (NSString *)ax_to2Decimal {
    
    return [NSString stringWithFormat: @"%.2lf", self.doubleValue];
}


/**
 2位小数
 @return NSString
 */
- (NSString *)ax_to2Decimal2 {
    
    double conversionValue = self.doubleValue;
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return decNumber.stringValue;
}

/**
 count位小数
 
 @return NSString
 */
- (NSString *)ax_toCountDecimal:(NSInteger )count {
    
    float number = self.doubleValue;
    NSString* format = [NSString stringWithFormat:@"%%.%ldf",(long)count];
    NSString* resultStr = [NSString stringWithFormat:format,number];
    return resultStr;
}

/**
 时间秒 转换 时分秒 字符串
 
 @param seconds 秒
 @return str
 */
+ (NSString *)ax_getHHMMSSWithSeconds:(NSInteger )seconds{
    
//    //format of hour
//    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
//    //format of minute
//    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
//    
//    //format of second
//    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
//    //format of time
//    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
//    return format_time;
    
    
    NSInteger duration = seconds;
    
    if (duration < 60) {
        return [NSString stringWithFormat:@"00:%02ld", duration];
    } else if (duration < 3600) {
        NSInteger m = duration / 60;
        NSInteger s = duration % 60;
        return [NSString stringWithFormat:@"%02ld:%02ld", m, s];
    } else {
        NSInteger h = duration / 3600;
        NSInteger m = (duration % 3600) / 60;
        NSInteger s = duration % 60;
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", h, m, s];
    }
    
}
/**
 (NSCharacterSet *)controlCharacterSet;             //控制符
 
 (NSCharacterSet *)whitespaceCharacterSet;          //空格
 (NSCharacterSet *)whitespaceAndNewlineCharacterSet;//首位空格
 (NSCharacterSet *)decimalDigitCharacterSet;        //小数
 (NSCharacterSet *)letterCharacterSet;              //文字
 (NSCharacterSet *)lowercaseLetterCharacterSet;     //小写字母
 (NSCharacterSet *)uppercaseLetterCharacterSet;     //大写字母
 (NSCharacterSet *)nonBaseCharacterSet;             //非基础
 (NSCharacterSet *)alphanumericCharacterSet;        //字母数字
 (NSCharacterSet *)decomposableCharacterSet;        //可分解
 (NSCharacterSet *)illegalCharacterSet;             //非法
 (NSCharacterSet *)punctuationCharacterSet;         //标点
 (NSCharacterSet *)capitalizedLetterCharacterSet;   //大写
 (NSCharacterSet *)symbolCharacterSet;              //符号
 (NSCharacterSet *)newlineCharacterSet NS_AVAILABLE(10_5, 2_0);//换行符
 
 */

#pragma mark - 去除空格
/**
 去除首尾空格
 
 @return NSString
 */
- (NSString *)ax_trimWhitespace {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)ax_trimRedundantWhitespace {
    
    NSString *str = self;
    /// 分割空格
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSArray *parts = [str componentsSeparatedByCharactersInSet:whitespaces];
    
    /// 过滤空格
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    /// 添加空格
    NSString * ret = [filteredArray componentsJoinedByString:@" "];
    return ret;
    
}


/**
 去除首尾换行
 
 @return NSString
 */
- (NSString *)ax_trimNewline {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

/**
 去除首尾空格和换行
 
 @return NSString
 */
- (NSString *)ax_trimWhitespaceeAndNewline {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}




/**
 当前string 正则 inString 中的 需要的
 
 @param inString 需要保留的
 @return NSString
 */
-(NSString *)ax_scannerInString:(NSString *)inString {
    
    NSString *originStr = self;
    NSScanner *scanner = [NSScanner scannerWithString:originStr];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:inString];
    NSMutableString * result = [NSMutableString string];
    while (!scanner.isAtEnd) {
        NSString *bufferStr;
        //要set中的
        if ([scanner scanCharactersFromSet:set intoString:&bufferStr]) {
            [ result appendString:bufferStr];
        }else{
            scanner.scanLocation = scanner.scanLocation+1;
        }
    }
    return  result;
}
/**
 当前string 正则 upToString 中的 不需要的
 
 @param upToString 不需要保留的
 @return NSString
 */
-(NSString *)ax_scannerUpToString:(NSString *)upToString {
    
    NSString *originStr = self;
    NSScanner *scanner = [NSScanner scannerWithString:originStr];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:upToString];
    NSMutableString * result = [NSMutableString string];
    while (!scanner.isAtEnd) {
        NSString *bufferStr;
        //要set中的
        if ([scanner scanUpToCharactersFromSet:set intoString:&bufferStr]) {
            [ result appendString:bufferStr];
        }else{
            scanner.scanLocation = scanner.scanLocation+1;
        }
    }
    return  result;
}


/**
 url path 拼接参数

 @param parameter 参数
 @return path
 */
-(NSString *)ax_pathAppendingWithParameter:(NSDictionary <NSString *,id >*)parameter {
  
    NSMutableArray <NSString *> *keyAndValueArray = [NSMutableArray arrayWithCapacity:parameter.count];
    
    [parameter enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [keyAndValueArray addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
    }];
    NSString *parameterStr = [keyAndValueArray componentsJoinedByString:@"&"];
    
    
    NSString *string = self;
    NSRange range = [string rangeOfString:@"?"];
    if (range.location != NSNotFound) {//找到了
        
        //如果?是最后一个直接拼接参数
        if (string.length == (range.location + range.length)) {
            
            string = [string stringByAppendingString:parameterStr];
            
        }else{//如果不是最后一个需要加&
            
            if([string hasSuffix:@"&"]){//如果最后一个是&,直接拼接
                string = [string stringByAppendingString:parameterStr];
            }else{//如果最后不是&,需要加&后拼接
                string = [string stringByAppendingString:[NSString stringWithFormat:@"&%@",parameterStr]];
            }
        }
        
    }else{//没找到
        
        if([string hasSuffix:@"&"]){//如果最后一个是&,去掉&后拼接
            string = [string substringToIndex:string.length-1];
        }
        string = [string stringByAppendingString:[NSString stringWithFormat:@"?%@",parameterStr]];
    }
    return string;
}


/**
 含有Unicode的字串 to emoj 表情,用于显示

 @return 含有emoj表情的string
 */
-(NSString *)ax_stringToEmojiCode {
    
    const char *jsonString = self.UTF8String;
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *emoji = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return emoji;
}


/**
 emoj 表情  转 Unicode的字串,用于存储

 @return 含有emoj表情的string
 */
-(NSString *)ax_emojiCodeToString{
    
    NSString *uniStr = self;
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *str = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding] ;
    return str;
    
}
/// NS_FORMAT_FUNCTION(1, 2)是什么意思呢？它会告诉编译器，索引1处的参数是一个格式化字符串，而实际参数从索引2处开始。

+ (instancetype)ax_stringWithFormat:(NSString *)format,... NS_FORMAT_FUNCTION(1,2){
    
   
    va_list arg_list;
    

    va_start(arg_list, format);
    

//    NSString *tmp = nil;

//    while ((tmp = va_arg(arg_list, NSString *))) {
//
//        NSLog(@"arg_list>> %@",tmp);
//    }

    
    while (TRUE)
    {
        id obj = va_arg(arg_list, id);
        if (nil == obj) {
            
             NSLog(@"arg_list>> %@",obj);
        }
        
        
    }
    
    
    va_end(arg_list);
    
    return @"AA";
    
}

+(NSString *)function:(NSString*)value,...{
    va_list argumentList;
    va_start(argumentList, value);
    NSString *tmp = nil;
    
    while ((tmp = va_arg(argumentList, NSString *))) {
        NSLog(@"%@",tmp);
    }
    
    va_end(argumentList);
    
    return @"A";
}



/******************** validation *************************/


- (BOOL)ax_containsEmoji {
//    __block BOOL containsEmoji = NO;
//    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
//     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//         const unichar hs = [substring characterAtIndex:0];
//         if (0xd800 <= hs && hs <= 0xdbff) {
//             if (substring.length > 1) {
//                 const unichar ls = [substring characterAtIndex:1];
//                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
//                 if (0x1d000 <= uc && uc <= 0x1f77f) {
//                     containsEmoji = YES;
//                 }
//             }
//         } else if (substring.length > 1) {
//             const unichar ls = [substring characterAtIndex:1];
//             if (ls == 0x20e3) {
//                 containsEmoji = YES;
//             }
//         } else {
//             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
//                 containsEmoji = YES;
//             } else if (0x2B05 <= hs && hs <= 0x2b07) {
//                 containsEmoji = YES;
//             } else if (0x2934 <= hs && hs <= 0x2935) {
//                 containsEmoji = YES;
//             } else if (0x3297 <= hs && hs <= 0x3299) {
//                 containsEmoji = YES;
//             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a) {
//                 containsEmoji = YES;
//             }
//         }
//     }];
//    return containsEmoji;
    NSString *string = self;
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        if (substring.length > 0) {
            const unichar hs = [substring characterAtIndex:0];
            if (0x2194 <= hs && hs <= 0x2199) {
                returnValue = YES;
            }
            if (0x23e9 <= hs && hs <= 0x23fa) {
                returnValue = YES;
            }
            if (0x2600 <= hs && hs <= 0x2604) {
                returnValue = YES;
            }
            if (0x2648 <= hs && hs <= 0x2653) {
                returnValue = YES;
            }
            if (0x30 <= hs && hs <= 0x39) {
                returnValue = YES;
            }
            if (0x26f0 <= hs && hs <= 0x26fd) {
                returnValue = YES;
            }
            if (hs == 0x203c || hs == 0x2049 || hs == 0x2122 || hs == 0x2139 || hs == 0x21a9 || hs == 0x21aa || hs == 0x23 || hs == 0x231a || hs == 0x231b || hs == 0x2328 || hs == 0x23cf || hs == 0x24c2 || hs == 0x25b6 || hs == 0x25c0 || hs == 0x260e || hs == 0x2611 || hs == 0x2614 || hs == 0x2615 || hs == 0x2618 || hs == 0x261d || hs == 0x2620 || hs == 0x2622 || hs == 0x2623 || hs == 0x2626 || hs == 0x262a || hs == 0x262e || hs == 0x262f || hs == 0x2638 || hs == 0x2639 || hs == 0x263a || hs == 0x2668 || hs == 0x267b || hs == 0x267f || hs == 0x2692 || hs == 0x2693 || hs == 0x2694 || hs == 0x2696 || hs == 0x2697 || hs == 0x2699 || hs == 0x269b || hs == 0x269c || hs == 0x26a0 || hs == 0x26a1 || hs == 0x26b0 || hs == 0x26b1 || hs == 0x26bd || hs == 0x26be || hs == 0x26c4 || hs == 0x26c5 || hs == 0x26c8 || hs == 0x26ce || hs == 0x26cf || hs == 0x26d1 || hs == 0x26d3 || hs == 0x26d4 || hs == 0x26e9 || hs == 0x26ea || hs == 0x2702 || hs == 0x2705 || hs == 0x2708 || hs == 0x2709 || hs == 0x270a || hs == 0x270b || hs == 0x270c || hs == 0x270d || hs == 0x270f || hs == 0x2712 || hs == 0x2714 || hs == 0x2716 || hs == 0x271d || hs == 0x2721 || hs == 0x2728 || hs == 0x2733 || hs == 0x2734 || hs == 0x2744 || hs == 0x2747 || hs == 0x274c || hs == 0x274e || hs == 0x2753 || hs == 0x2754 || hs == 0x2755 || hs == 0x2757 || hs == 0x2763 || hs == 0x2764 || hs == 0x2795 || hs == 0x2796 || hs == 0x2797 || hs == 0x27a1 || hs == 0x27b0 || hs == 0x27bf || hs == 0x2934 || hs == 0x2935 || hs == 0x2b05 || hs == 0x2b06 || hs == 0x2b07 || hs == 0x2b50 || hs == 0x2b55 || hs == 0x3030 || hs == 0x303d || hs == 0x3297 || hs == 0x3299 || hs == 0x2a || hs == 0xa9 || hs == 0xae || hs == 0xd83c || hs == 0xd83d || hs == 0xd83e || hs == 0x267e || hs == 0x25aa || hs == 0x25ab || hs == 0x265f || hs == 0x26ab || hs == 0x26aa || hs == 0x25fe || hs == 0x25fd || hs == 0x25fc || hs == 0x25fb || hs == 0x2b1b || hs == 0x2b1c || hs == 0x2660 || hs == 0x2663 || hs == 0x2665 || hs == 0x2666) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
    
}


- (BOOL)ax_isPureIntNumber {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    int val;
    return [scanner scanInt:&val] && [scanner isAtEnd];
}


// 是否是邮箱
- (BOOL)ax_conformsToEMailFormat {
    return [self ax_matchesRegularExpressionPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"];
}


- (BOOL)ax_conformsIDCard {
    if (self.length == 15) {
        for (NSUInteger i = 0; i < self.length; i++) {
            unichar character = [self characterAtIndex:i];
            if ('0' <= character && character <= '9') {
                continue;
            }
            return NO;
        }
        return YES;
    }
    
    if (self.length == 18) {
        NSInteger weights[17] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
        NSInteger total = 0;
        for (NSUInteger i = 0; i < self.length - 1; i++) {
            unichar character = [self characterAtIndex:i];
            if ('0' <= character && character <= '9') {
                NSInteger integer = (NSInteger)(character - '0');
                total += integer * weights[i];
                continue;
            }
            return NO;
        }
        NSInteger result = (12 - total % 11) % 11;
        unichar character = [self characterAtIndex:17];
        if (result == 10) {
            if (character == 'x') {
                return YES;
            }
            if (character == 'X') {
                return YES;
            }
            return NO;
        }
        
        if (result == (NSInteger)(character - '0')) {
            return YES;
        }
    }
    
    return NO;
}


- (BOOL)ax_containInvalidString {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:set];
    if ([self ax_matchesRegularExpressionPattern:trimmedString]) {
        return NO;
    }
    return YES;
}


- (BOOL)ax_isChineseCharacter {
    NSString *regex = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


- (BOOL)ax_isNumberOrEnglishOrChineseCharacter {
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


- (BOOL)ax_isPureDecimalDigits {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    return YES;
}


- (BOOL)ax_isEmptyAfterTrimmingWhitespaceAndNewlineCharacters {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
}

- (BOOL)ax_matchesRegularExpressionPattern:(NSString *)regularExpressionPattern {
    NSRange fullRange = NSMakeRange(0, [self length]);
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    NSRange range = [regularExpression rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:fullRange];
    if (NSEqualRanges(fullRange, range)) {
        return YES;
    }
    return NO;
}

///  NSString中的数字变小
/// @param fontSize 字号
-(NSMutableAttributedString*)ax_smallerNumberWitSize:(CGFloat )fontSize {
    
    NSString* text = self;
    if (text.length == 0) {return nil;}
    NSMutableArray *numStrArr = [NSMutableArray array];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:text.uppercaseString];
    
    NSScanner *scanner = [NSScanner scannerWithString:text];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        int number;
        [scanner scanInt:&number];
        
        NSString *num=[NSString stringWithFormat:@"%d",number];
        [numStrArr addObject:num];
    }
    
    if (numStrArr.count) {
        
        NSRange range = NSMakeRange(0, 0);
        for (int i = 0; i < numStrArr.count; i++) {
            range = [text rangeOfString:numStrArr[i]];
            [attributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:fontSize]
                                  range:range];
        }
    }else{
        [attributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:fontSize]
                              range:NSMakeRange(0, text.length)];
    }
    return attributedStr;
}


//截取字符前多少位，处理emoji表情问题
////🐒🐒🐒🐒 + 截取3 = 🐒🐒🐒
-(NSString *)ax_subStringContainsEmojiWithLength:(NSInteger)limitLength {
    
    NSString *emojiString = self;
    if(emojiString.length < limitLength) return emojiString;
    @autoreleasepool {
        NSString * subStr = emojiString;
        NSRange  range;
        NSInteger index = 0;
        for(int i=0; i< emojiString.length; i += range.length){
            range = [emojiString rangeOfComposedCharacterSequenceAtIndex:i];
            NSString * charrrr = [emojiString substringToIndex:range.location + range.length];
            index ++;
            if(index == limitLength){
                subStr = charrrr;
                break;
            }
        }
        return subStr;
    }
}


/// 获取字符串的首字母, 缺省为#
- (NSString*)ax_firstLetter {
    NSString *string = self;
    if ((string == nil)|| (string == NULL) || ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) || [string isKindOfClass:[NSNull class]]) {
        return @"#";
    }
    
    NSMutableString *source = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [[source capitalizedString] substringToIndex:1];
}


/// 模糊搜索 汉字搜索 不分大小写拼音或首字母搜索
-(NSString *)ax_tansformToMixedString {
    NSString *originStr = self;
    // 转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:originStr];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    

    // 得到拼音
    NSMutableString *pinyinString = [NSMutableString string];
    for (NSString *s in pinyinArray) {
        [pinyinString appendString:s];
    }
    
    // 得到拼音首字母
    NSMutableString *initialStr = [NSMutableString string];
    for (NSString *s in pinyinArray){
        if (s.length > 0){
            [initialStr appendString:[s substringToIndex:1]];
        }
    }
    NSMutableArray<NSString *> *array = [NSMutableArray array];
    [array addObject:originStr];// 添加汉字
    [array addObject:pinyinString]; // 添加小写拼音
    [array addObject:[pinyinString uppercaseString]]; // 添加大写拼音
    [array addObject:initialStr]; // 添加小写首字母
    [array addObject:[initialStr uppercaseString]]; // 添加大写首字母

    return [array componentsJoinedByString:@","];
}

@end

