//
//  DLCompanyNewsViewModel.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLCompanyNewsOneSmallPictureCell.h"
#import "DLCompanyNewsMoreSmallPictureCell.h"
#import "DLCompanyNewsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLCompanyNewsViewModel : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

- (UITableViewCell *)dequeueReusableCellWithModel:(DLCompanyNewsModel *)model cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
