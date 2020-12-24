//
//  AXImageSchemeHanlder.h
//  AFNetworking
//
//  Created by 小星星吃KFC on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import <WebKit/WKURLSchemeHandler.h>

//第二次获取高度延迟时间 不建议太小 否则可能获取高度不对
#define DelayTime 0.4

#define XXXCustomImageScheme @"xxxixxxx"

NS_ASSUME_NONNULL_BEGIN

@interface AXImageSchemeHanlder : NSObject<WKURLSchemeHandler>

@property (nonatomic, copy) NSString *oriImageUrl;
@property (nonatomic, copy) NSString *oriImageScheme;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, copy) void(^updateImageBlock)(void);

@end

NS_ASSUME_NONNULL_END
