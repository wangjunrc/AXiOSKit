//
//  TableViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "ChatViewController.h"
#import "UIViewController+AXKit.h"

typedef void (^CollectionBlock)(void);

@interface TableViewController ()

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellid"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    cell.textLabel.text = dict[@"title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    void (^didSelectRowAtIndexPath)(void) = dict[@"action"];
    
    didSelectRowAtIndexPath();
    
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            
            @{
                @"title":@"暗黑主题-ViewController",
                @"action":  ^{
                    ViewController *vc = [[ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            @{
                @"title":@"聊天-ChatViewController",
                @"action":  ^{
                    ChatViewController *vc = [[ChatViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            
            @{
                @"title":@"隐藏导航栏",
                @"action":  ^{
                    ViewController *vc = [[ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    vc.ax_shouldNavigationBarHidden = YES;
                },
            },
            
            
        ];
    }
    return _dataArray;
}

@end
