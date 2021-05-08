//
//  AXShareService.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2021/5/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXShareType.h"
#import "AXUserSwiftImport.h"
#import "AXShareOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXShareService : NSObject

AX_SINGLETON_INTER(Service);

-(BOOL)handleOpenUrl:(NSURL *)url;

-(void)shareDownloadLinkOption:(AXShareOption *)option;

-(void)shareOption:(AXShareOption *)option item:(AXShareInfoItem *)item;

@end

NS_ASSUME_NONNULL_END
