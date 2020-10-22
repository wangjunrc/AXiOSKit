//
//  AXUserInfo.h
//  macOS_demo
//
//  Created by 小星星吃KFC on 2020/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXUserInfo : NSObject

@property(nonatomic,assign)NSInteger userId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *headUrl;
@property(nonatomic,strong)NSDate *registerDate;

@end

NS_ASSUME_NONNULL_END
