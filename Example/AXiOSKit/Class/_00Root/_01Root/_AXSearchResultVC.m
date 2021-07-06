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

@property (nonatomic, strong) NSArray<NSDictionary*> *dataArray;

@property(nonatomic, strong) UISearchController *searchController;
@end

@implementation _AXSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    [_00TableViewCell ax_registerNibCellWithTableView:self.tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _00TableViewCell *cell = [_00TableViewCell ax_dequeueCellWithTableView:tableView forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.indexLabel.text = [dict[@"index"] stringValue];
    cell.nameLabel.text = dict[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    void (^action)(void) = dict[@"action"];
    action();
    
    self.searchController.searchBar.text = nil;
    ///很重要,消失的
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    if (!self.searchController) {
        self.searchController = searchController;
    }
    NSString *str = searchController.searchBar.text;
    
    NSLog(@"searchController=%@",str);
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",str];
    NSArray *array1 = [self.filterArray filteredArrayUsingPredicate:pre];
    
    NSLog(@"title=%@",array1);
    
    if (array1.count==0) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"index == %ld",str.integerValue];
        array1 = [self.filterArray filteredArrayUsingPredicate:pre];
        NSLog(@"index=%@",array1);
    }
    
    self.dataArray = array1;
    [self.tableView reloadData];
}



@end
