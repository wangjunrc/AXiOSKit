//
//  UITableViewCell+AXKit.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/3.
//

#import "UITableViewCell+AXKit.h"

@implementation UITableViewCell (AXKit)

+ (void)ax_registerCellWithTableView:(UITableView *)tableView {
    [tableView registerClass:self.class forCellReuseIdentifier:self.ax_identifier];
}
+ (void)ax_registerNibCellWithTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] forCellReuseIdentifier:self.ax_identifier];
}

+ (__kindof UITableViewCell *)ax_dequeueCellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:self.ax_identifier forIndexPath:indexPath];
}

+ (NSString *)ax_identifier {
    return NSStringFromClass([self class]);
}


@end
