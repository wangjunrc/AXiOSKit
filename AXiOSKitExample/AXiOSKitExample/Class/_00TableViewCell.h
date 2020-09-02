//
//  _00TableViewCell.h
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/7.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface _00TableViewCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UILabel *indexLabel;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
