//
//  AXShareService.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXShareTarget.h"
#import "AXUserSwiftImport.h"
#import "AXShareOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXShareService : NSObject

AX_SINGLETON_INTER(Service);

-(BOOL)handleOpenUrl:(NSURL *)url;

-(void)shareDownloadLinkOption:(AXShareOption *)option;

-(void)shareOption:(AXShareOption *)option item:(AXSocialShareContent *)item;

@end

NS_ASSUME_NONNULL_END
