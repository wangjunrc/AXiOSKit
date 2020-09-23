//
//  AXMediaConfig.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/9/23.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMediaType : NSObject

@property(nonatomic, class, readonly )NSString *kUTTypeImage;

@property(nonatomic, class, readonly, )NSString *kUTTypeJPEG;

@property(nonatomic, class, readonly, )NSString *kUTTypePNG;

@property(nonatomic, class, readonly, )NSString *kUTTypeGIF;

@property(nonatomic, class, readonly, )NSString *kUTTypeMovie;

@property(nonatomic, class, readonly, )NSString *kUTTypeQuickTimeMovie;

@end

@interface AXMediaConfig : NSObject

@property(nonatomic, assign, getter=isEditing)BOOL editing;


/// 可以存放 AXMediaType属性,
/// 或者 #import <MobileCoreServices/UTCoreTypes.h> 中寻找对应的
@property(nonatomic,copy)NSArray<__kindof NSString *>  *mediaTypes;

@end

NS_ASSUME_NONNULL_END
