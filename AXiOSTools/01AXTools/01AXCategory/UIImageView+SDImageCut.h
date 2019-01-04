//
//  UIImageView+SDImageCut.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/4/10.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#if __has_include("SDWebImageManager.h")

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"


@interface UIImageView (SDImageCut)

- (void)ax_setCutImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder  completed:(nullable SDExternalCompletionBlock)completedBlock;

@end

#endif
