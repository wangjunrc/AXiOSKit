////
////  _41SlideHeadVC.m
////  AXiOSKit_Example
////
////  Created by 小星星吃KFC on 2021/7/1.
////  Copyright © 2021 axinger. All rights reserved.
////
//
#import "_41SlideHeadVC.h"
//#import "GSKTwitterStretchyHeaderView.h"
//#import "GSKSpotyLikeHeaderView.h"
//#import "UINavigationController+Transparency.h"
//@import  WRNavigationBar;
//
//@interface _41SlideHeadVC ()
//
//
//@property (nonatomic, strong) GSKStretchyHeaderView *headerView;
//
//@end
//
@implementation _41SlideHeadVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellID"];
////
////    self.automaticallyAdjustsScrollViewInsets = NO;
////    if (@available(iOS 11.0, *)) {
////        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
////    }
////    UIEdgeInsets contentInset = self.tableView.contentInset;
////    if (self.navigationController) {
////        contentInset.top = 64;
////    }
////    if (self.tabBarController) {
////        contentInset.bottom = 44;
////    }
////    self.tableView.contentInset = contentInset;
//
//    self.headerView = [GSKSpotyLikeHeaderView.alloc initWithFrame:CGRectMake(0, 0, self.view.width, 240)];
//    self.headerView.manageScrollViewInsets = NO;
//    
//    UIEdgeInsets contentInset = self.tableView.contentInset;
//    contentInset.top = self.headerView.minimumContentHeight;
//    self.tableView.contentInset = contentInset;
//    
//    // we add an empty header view at the top of the table view to increase the initial offset before the first section header
//    // otherwise the header view would cover the first cells
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
//                                                                              0,
//                                                                              self.tableView.width,
//                                                                              self.headerView.maximumContentHeight - self.headerView.minimumContentHeight)];
//
//    
//    [self.tableView addSubview:self.headerView];
//    
////    [self wr_setNavBarBarTintColor:[UIColor orangeColor]];
//    
//    // 设置初始导航栏透明度
//    [self wr_setNavBarBackgroundAlpha:0];
//    
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
////    [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
////    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
////    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
////    [self wr_setNavBarBackgroundAlpha:0];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
////    [self.navigationController gsk_setNavigationBarTransparent:NO animated:NO];
//    
//    
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 40;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    
//    
//    return cell;
//}
//
//
//
@end
