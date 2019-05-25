//
//  AXDataModelProtocol.h
//  AXKit
//
//  Created by AXing on 2018/11/17.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AXDataModelProtocol <NSObject>

@optional
@property (nonatomic, strong) AXDataModel *dataModel;

@end

NS_ASSUME_NONNULL_END
