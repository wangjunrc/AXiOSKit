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

@property (nonatomic, strong) NSArray<NSArray<_AXCellItem*>*> *dataArray;

@property(nonatomic, weak) UISearchController *searchController;

@property(nonatomic, copy) NSString *searchStr;

@end

@implementation _AXSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    [_00TableViewCell ax_registerCellWithTableView:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return @"自定义控制器";
    } else {
        return @"第三方组件控制器";
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray[section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _00TableViewCell *cell = [_00TableViewCell ax_dequeueCellWithTableView:tableView forIndexPath:indexPath];
    _AXCellItem *item = self.dataArray[indexPath.section][indexPath.row];
    
    {
        NSMutableAttributedString *text = [NSMutableAttributedString.alloc initWithString:item.title];
        NSRange range = [item.title rangeOfString:self.searchStr];
        
        if (range.location != NSNotFound) {
            [text addAttributes:@{NSForegroundColorAttributeName:UIColor.redColor} range:range];
        }
        
        cell.titleLabel.attributedText = text;
    }
    
    
    {
        
        NSMutableAttributedString *text = [NSMutableAttributedString.alloc initWithString:item.detail];
        NSRange range = [item.detail rangeOfString:self.searchStr];
        if (range.location != NSNotFound) {
            [text addAttributes:@{NSForegroundColorAttributeName:UIColor.redColor} range:range];
        }
        cell.detailLabel.attributedText = text;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _AXCellItem *item = self.dataArray[indexPath.section][indexPath.row];
    if (item.action) {
        item.action();
    }
    /// 控制点击消失
    //    self.searchController.searchBar.text = nil;
    //    ///很重要,消失的
    //    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    if (!self.searchController) {
        self.searchController = searchController;
    }
    NSString *text = searchController.searchBar.text;
    self.searchStr = text;
    
    NSLog(@"searchController=%@",text);
    
    /// 方式一 |
    //    NSPredicate *pre = [NSPredicate predicateWithFormat:@"detail CONTAINS[cd] %@ || title CONTAINS[cd] %@",text,text];
    
    /// 方式二 OR
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"detail CONTAINS[cd] %@ OR title CONTAINS[cd] %@",text,text];
    
    /// 方式三 NSCompoundPredicate
    //    NSPredicate *detailPre = [NSPredicate predicateWithFormat:@"detail CONTAINS[cd] %@",text];
    //
    //    NSPredicate *titlePre = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",text];
    //    NSPredicate *pre = [NSCompoundPredicate orPredicateWithSubpredicates:@[detailPre,titlePre]];
    
    //    self.dataArray = [self.filterArray filteredArrayUsingPredicate:pre];
    
    NSMutableArray<NSArray<_AXCellItem *> *> *allArray = NSMutableArray.array;
    
    [self.filterArray enumerateObjectsUsingBlock:^(NSMutableArray<_AXCellItem *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray<_AXCellItem *> *temp = [obj filteredArrayUsingPredicate:pre];
        
        [allArray addObject:temp];
        
    }];
    
    NSLog(@"搜索过滤=%@", allArray);
    self.dataArray = allArray.copy;
    
    [self.tableView reloadData];
}



@end
