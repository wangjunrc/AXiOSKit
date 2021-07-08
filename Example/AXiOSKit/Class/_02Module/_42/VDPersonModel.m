//
//  VDPersonModel.m
//  TestMac
//
//  Created by 小星星吃KFC on 2021/7/8.
//

#import "VDPersonModel.h"
static NSString * const kPropertyKeyName = @"name";
static NSString * const kPropertyKeyAge = @"age";
static NSString * const kPropertyKeyBirthday = @"birthday";

@implementation VDPersonModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
//    NSMutableDictionary *mutDic = [[NSDictionarymtl_identityPropertyMapWithModel:[selfclass]] mutableCopy];
//
//    [mutDic setObject:@"dt"forKey:@"date"];
//
//    [mutDic setObject:@"main.humidity"forKey:@"humidity"];
//
//    [mutDic setObject:@"main.temp"forKey:@"temperature"];
//
//    [mutDic setObject:@"weather"forKey:@"arrWeathers"];
    
    
    
    return @{
             @"name"        : kPropertyKeyName,
             @"birthday"    : kPropertyKeyBirthday,
             @"age"         : kPropertyKeyAge
             };
}

+ (NSValueTransformer *)birthdayJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return dateFormatter;
}

@end
