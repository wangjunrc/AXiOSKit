//
//  AXMediaRaresult.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/9/23.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMediaResult : NSObject

/// 原图
@property(nonatomic, strong) UIImage *originalImage;

/// 编辑后的图片
@property(nonatomic, strong) UIImage *editedImage;

/// 原件的URL
@property(nonatomic, strong) NSURL *referenceURL;

/// 媒体的URL 只有视频才有
@property(nonatomic, strong) NSURL *mediaURL;

@end

NS_ASSUME_NONNULL_END
