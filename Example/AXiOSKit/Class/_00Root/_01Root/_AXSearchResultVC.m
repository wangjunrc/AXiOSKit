//
//  _AXSearchResultVC.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/7.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_AXSearchResultVC.h"
#import "_00TableViewCell.h"
#import "UITableViewCell+AXKit.h"

@interface _AXSearchResultVC ()<UISearchResultsUpdating>

@property (nonatomic, strong) NSArray<_AXCellItem*> *dataArray;

@property(nonatomic, weak) UISearchController *searchController;

@end

@implementation _AXSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    [_00TableViewCell ax_registerCellWithTableView:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _00TableViewCell *cell = [_00TableViewCell ax_dequeueCellWithTableView:tableView forIndexPath:indexPath];
    _AXCellItem *item = self.dataArray[indexPath.row];
    cell.titleLabel.text = item.title;
    cell.detailLabel.text =item.detail;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _AXCellItem *item = self.dataArray[indexPath.row];
    if (item.action) {
        item.action();
    }
    
    self.searchController.searchBar.text = nil;
    ///很重要,消失的
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    if (!self.searchController) {
        self.searchController = searchController;
    }
    NSString *text = searchController.searchBar.text;
    
    NSLog(@"searchController=%@",text);
    
    //    NSPredicate *pre = [NSPredicate predicateWithFormat:@"detail CONTAINS[cd] %@ || title CONTAINS[cd] %@",text,text];
    
    NSPredicate *detailPre = [NSPredicate predicateWithFormat:@"detail CONTAINS[cd] %@",text];
    
    NSPredicate *titlePre = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",text];
    NSPredicate *pre = [NSCompoundPredicate orPredicateWithSubpredicates:@[detailPre,titlePre]];
    
    self.dataArray = [self.filterArray filteredArrayUsingPredicate:pre];
    NSLog(@"搜索过滤=%@", self.dataArray);
    [self.tableView reloadData];
}



@end
