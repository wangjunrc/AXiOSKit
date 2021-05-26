//
//  AXWebScriptMessageModel.h
//  AXiOSKit
//
//  Created by axing on 2019/4/30.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXWKWebVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXWebScriptMessageModel : NSObject

@property (nonatomic, strong) id <AXScriptMessageDelegate> obj;

@property (nonatomic, assign) Class objClass;

@end

NS_ASSUME_NONNULL_END
