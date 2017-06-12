//
//  NSString+AXDate.m
//  ZBP2P
//
//  Created by Mole Developer on 2016/12/26.
//  Copyright © 2016年 mole. All rights reserved.
//

#import "NSString+AXDate.h"

@implementation NSString (AXDate)
/**
 时间字符串,转换成指定格式的时间字符串
 
 @param currentformat 当前格式
 @param toformatter 需要转换的格式
 @return 时间字符串
 */
-(NSString *)ax_toChangeTpyeCurrentFormat:(NSString *)currentformat toFormatter:(NSString *)toformatter{
    
    NSDate *localeDate =  [self ax_toDateCurrentFormat:currentformat];
    
    return [localeDate ax_toStringWithFormatter:toformatter];
    
}

/**
 * 时间字符串拼接成显示状态,0-> xxxx年x月x日 1-> xxxx-x- x
 */
-(NSString *)ax_dateStringWithState:(NSInteger )state{
    NSString *str = [self substringToIndex:14];
    
    NSString *yearStr = [str substringToIndex:4];
    
    NSString *monethStr = [str substringWithRange:NSMakeRange(4, 2)];
    
    NSString *dateStr = [str substringWithRange:NSMakeRange(6, 2)];
    
    NSString *timeStr = nil;
    switch (state) {
        case 0:
            return timeStr = [NSString stringWithFormat:@"%@年%@月%@日",yearStr,monethStr,dateStr];
            break;
            
        default:
            return   timeStr = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monethStr,dateStr];
            break;
    }
}

/**
 *  当前系统时间显示为字符串
 yyyyMMddHHmmss
 yyyy年MM月dd日 HH:mm:ss
 yyyy-MM-dd HH:mm:ss
 yyyyMMdd
 yyyy年MM月dd日
 */
+(NSString *)ax_stringNowDateFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}


/**
 时间字符串转换成时间,格式必须与需要转化的格式一致
 
 @param format 当前字符串时间样式
 @return 返回时间
 */
-(NSDate *)ax_toDateCurrentFormat:(NSString *)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    //转换时区
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: destDate];
    NSDate *localeDate = [destDate  dateByAddingTimeInterval: interval];
    
    
    return localeDate;
    
}
/**
 * 时间字符串转换成时间
 */
-(NSDate *)ax_toDateFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    return [dateFormatter dateFromString:self];
}

/**
 * 时间戳转换成时间格式(时间戳为13位精确毫秒)
 */
-(NSString *)ax_timeStampToStringFormat:(NSString *)format{
    NSString *time = self;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: time.doubleValue/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

/**
 * 10时间戳转换成本地时间(超过10未的自动截取前10位)
 */
-(NSDate *)ax_timestampToDate{
    NSString *time = self;
    if (time.length>10) {
        time = [time substringToIndex:10];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.doubleValue];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return  [date  dateByAddingTimeInterval: interval];
}


/**
 * 判断时间字符串与当前时间年月日是否相同
 */
-(NSString *)ax_differToNowDate{
    NSString *selfTime = self;
    //    if (selfTime.length<19) {
    //        NSInteger chaju = 19-selfTime.length;
    //
    //
    //    }
    NSDateFormatter *mattet = [NSDateFormatter new];
    mattet.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowDateStr = [mattet stringFromDate:[NSDate new]];
    
    NSString *nowyear =[nowDateStr substringToIndex:4];
    NSString *nowmonth =[nowDateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *nowday =[nowDateStr substringWithRange:NSMakeRange(8, 2)];
    
    
    NSString *toyear =[selfTime substringToIndex:4];
    NSString *tomonth =[selfTime substringWithRange:NSMakeRange(5, 2)];
    NSString *today =[selfTime substringWithRange:NSMakeRange(8, 2)];
    
    
    NSString * differ = selfTime;
    if (nowyear == toyear) {
        differ = [selfTime substringFromIndex:5];
        if (nowmonth == tomonth){
            differ = [selfTime substringFromIndex:5];;
            if (nowday == today){
                differ = [selfTime substringFromIndex:11];;
            }
        }
        
    }
    return differ;
}
@end
