//
//  NSData+AXTool.m
//  AXiOSKit
//
//  Created by liuweixing on 16/8/10.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSData+AXTool.h"

@implementation NSData (AXTool)
/**
 * NSData 进行 Base64
 */
- (NSString *)ax_toBase64{
    return  [self base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

//二进制转化为十六进制
- (NSString *)ax_dataToHexString{
    NSData *data = self;
    if (data == nil) {
        return nil;
    }
    
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    
    return [hexString uppercaseString];
}

/**
 * NSData 转化 NSString
 */
- (NSString *)ax_toString{
    
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

/**
 NSBundle 文件转data
 
 @param resource 文件名,带后缀
 @return NSData
 */
+(NSData *)ax_dataWithMainBundleResource:(NSString *)resource {
    
    NSString *file = [NSBundle.mainBundle pathForResource:resource ofType:nil];
    return [NSData dataWithContentsOfFile:file];
}
@end
