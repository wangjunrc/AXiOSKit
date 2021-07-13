//
//  _03RootVC.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/3/25.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_11MasonryTableVC.h"
#import "_03HeaderView.h"
#import "_11MasonryCell.h"
#import "_01ContentViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/UIViewController+AXNavBarConfig.h>
#import "_AXCellItem.h"
@interface _11MasonryTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<_AXCellItem *> *dataArray;
@end

@implementation _11MasonryTableVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自动适配高度";
    
    self.view.backgroundColor = UIColor.brownColor;
    self.navigationController.view.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_11MasonryCell ax_registerCellWithTableView:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
//    _03HeaderView *headerView = [_03HeaderView.alloc init];
//    self.tableView.tableHeaderView =headerView;
}



- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView ax_layoutHeaderHeight];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView

 numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _11MasonryCell  *cell = [_11MasonryCell ax_dequeueCellWithTableView:tableView forIndexPath:indexPath];
    
    _AXCellItem *item  =  self.dataArray[indexPath.row];
    
    cell.titleLabel.text = item.title;
    
    cell.detailLabel.text = item.detail;
    return cell;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    }
    return _tableView;
}

- (NSMutableArray<_AXCellItem *> *)dataArray {
    if (!_dataArray) {
        
        NSMutableArray<_AXCellItem *> *temp = NSMutableArray.array;
        {
            _AXCellItem *item = _AXCellItem.alloc.init;
            [temp addObject:item];
            item.title = @"左边-哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
            item.detail = @"右边-哈哈";
            
        }
        
        {
            _AXCellItem *item = _AXCellItem.alloc.init;
            [temp addObject:item];
            item.title = @"左边-哈哈哈";
            item.detail = @"右边-哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n";
            
        }
        {
            _AXCellItem *item = _AXCellItem.alloc.init;
            [temp addObject:item];
            item.title = @"左边-哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
            item.detail = @"右边-哈哈";
            
        }
        
        {
            _AXCellItem *item = _AXCellItem.alloc.init;
            [temp addObject:item];
            item.title = @"左边-哈哈哈";
            item.detail = @"右边-哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n哈哈哈\n";
        }
        _dataArray = temp.mutableCopy;
    }
    return _dataArray;
}


@end
