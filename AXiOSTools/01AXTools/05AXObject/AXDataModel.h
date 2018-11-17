//
//  AXDataModel.h
//  AXTools
//
//  Created by AXing on 2018/11/17.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXDataModel : NSObject

/**一般用于tableView分页 第几页*/
@property (nonatomic, assign) NSInteger pageIndex;

/**一般用于tableView分页 每页几个*/
@property (nonatomic, assign) NSInteger pageSize;

/**一般用于tableView数据结果*/
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

NS_ASSUME_NONNULL_END
