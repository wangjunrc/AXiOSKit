////
////  _02QQZoneController.m
////  CodeDemo
////
////  Created by wangrui on 2017/4/14.
////  Copyright © 2017年 wangrui. All rights reserved.
////
////  Github地址：https://github.com/wangrui460/WRNavigationBar
//
#import "_02QQZoneController.h"
//#import "WRNavigationBar.h"
//@import AXiOSKit;
//@import Masonry;
//
// static CGFloat const IMAGE_HEIGHT = 260;
//
//@interface _02QQZoneController () <UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIImageView *imgView;
//@end
//
@implementation _02QQZoneController
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
//    self.title = @"导航栏渐变";
//    
//    
//    if (@available(iOS 11.0, *)){
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
//    
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
//    self.tableView.tableHeaderView = self.imgView;
//    
//    [self wr_setNavBarBackgroundAlpha:0];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    CGFloat point = IMAGE_HEIGHT - ax_navigation_and_status_height();
//    AXLog(@"offsetY=%lf,%lf,%lf",offsetY,ax_navigation_and_status_height(),point);
//    
//    if (offsetY >= point){
//        
//        [self wr_setNavBarBackgroundAlpha:1];
//    }  else{
//        
//        CGFloat alpha = (offsetY) / point;
//        [self wr_setNavBarBackgroundAlpha:alpha];
//        
//    }
//    
//}
//
//
//
//
//#pragma mark - tableview delegate / dataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 20;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                   reuseIdentifier:nil];
//    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
//    cell.textLabel.text = str;
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UIViewController *vc = [UIViewController new];
//    vc.view.backgroundColor = UIColor.purpleColor;
//    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
//    vc.title = str;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//#pragma mark - getter / setter
//- (UITableView *)tableView
//{
//    if (_tableView == nil) {
//        CGRect frame = CGRectZero;
//        _tableView = [[UITableView alloc] initWithFrame:frame
//                                                  style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.backgroundColor = UIColor.purpleColor;
//    }
//    return _tableView;
//}
//
//- (UIImageView *)imgView
//{
//    if (_imgView == nil) {
//        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, IMAGE_HEIGHT)];
//        _imgView.contentMode = UIViewContentModeScaleAspectFill;
//        _imgView.clipsToBounds = YES;
//        _imgView.image =[UIImage imageNamed:@"image6"];
//    }
//    return _imgView;
//}
//
//
//
@end
