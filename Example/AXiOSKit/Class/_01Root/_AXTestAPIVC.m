//
//  _AXTestAPIVC.m
//  AXiOSKit_Example
//
//  Created by axinger on 2021/10/12.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_AXTestAPIVC.h"
#import "_AXCellItem.h"
#import "_00TableViewCell.h"

@interface _AXTestAPIVC ()
@property (nonatomic, strong) NSMutableArray<_AXCellItem *> *dataArray;
@end

@implementation _AXTestAPIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统API";
    
    self.tableView.tableFooterView = UIView.alloc.init;
    [_00TableViewCell ax_registerCellWithTableView:self.tableView];
    self.dataArray = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _00TableViewCell *cell = [_00TableViewCell ax_dequeueCellWithTableView:tableView forIndexPath:indexPath];
    _AXCellItem *item = self.dataArray[indexPath.row];
    cell.titleLabel.text = item.title;
    cell.detailLabel.text = item.detail;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _AXCellItem *item = self.dataArray[indexPath.row];
    if (item.action) {
        item.action();
    }
}


#pragma mark -  数据源

- (NSMutableArray<_AXCellItem *> *)dataArray {
    if (!_dataArray) {
        _dataArray =  NSMutableArray.array;
        [_dataArray addTitle:@"_01ContentViewController" detail:@"uikit示例" action:^(_AXCellItem *option) {
            NSLog(@"_01ContentViewController");
            
        }];
        
    }
    return _dataArray;
}


/// 指定控制器旋转: 基类：默认不支持旋转
- (BOOL)shouldAutorotate {
    return NO;
}

/// 指定控制器旋转: 默认支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
