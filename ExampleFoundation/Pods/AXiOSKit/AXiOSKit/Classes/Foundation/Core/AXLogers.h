//
//  AXLogers.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXLogers : NSObject
+(void)Info:(const char *)file
   function:(const char *)function
       line:(NSUInteger )line
     format:(NSString *)format, ...;


+(void)PrefixLog:(NSString *)msg
          format:(NSString *)format, ...;
@end

NS_ASSUME_NONNULL_END
