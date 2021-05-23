//
//  _03RootVC.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/3/25.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_03RootVC.h"
#import "_03HeaderView.h"
#import "_03RootCell.h"
#import "_01ContentViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/UIViewController+AXNavBarConfig.h>
@interface _03RootVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataArray;
@end

@implementation _03RootVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"导航栏隐藏";
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    // 适配iOS11以上UITableview 页面偏移
    if (@available(iOS 11.0, *)){
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    //    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = UIColor.brownColor;
    self.navigationController.view.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_03RootCell ax_registerCellWithTableView:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    _03HeaderView *headerView = [_03HeaderView.alloc init];
    self.tableView.tableHeaderView =headerView;
    
//    if (@available(iOS 13.0, *)) {
//        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDarkContent;
//    } else {
//        self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
//    }
    
    if (@available(iOS 13.0, *)) {
        UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    int age = 10;
   void (^myblock)(void) =  ^{
     NSLog(@"age = %d",age);
   };
   age  = 20;
   myblock();
    
    
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:UIImage.alloc.init forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:UIImage.alloc.init];
    [self ax_setNavBarBackgroundImageTransparent];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.y;
    
    //    if (offset>0) {
    //        [self.navigationController setNavigationBarHidden:NO animated:NO];
    //    }else{
    //        [self.navigationController setNavigationBarHidden:YES animated:NO];
    //    }
    //    if (offset==0) {
    //        [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    }
    //根据透明度来生成图片
    //找最大值/
    CGFloat alpha = offset * 1 / 136.0;   // (200 - 64) / 136.0f
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    //拿到标题 标题文字的随着移动高度的变化而变化
    UILabel *titleL = (UILabel *)self.navigationItem.titleView;
    titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    //把颜色生成图片
    //    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    if (alpha<=0) {
        [self ax_setNavBarBackgroundImageTransparent];
    }else{
        UIColor *alphaColor = [UIColor.orangeColor colorWithAlphaComponent:alpha];
        if (!alphaColor) {
            NSLog(@"alphaColor nil");
        }
        [self ax_setNavBarBackgroundImageWithColor:alphaColor];
    }
    //    self.navigationController.navigationBar.barTintColor = alphaColor;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView ax_layoutHeaderHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}



- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return 50; //self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _03RootCell  *cell = [_03RootCell ax_dequeueCellWithTableView:tableView forIndexPath:indexPath];
    
    //    NSDictionary *dict = self.dataArray[indexPath.row];
    //    NSString  *index = [dict[@"index"] stringValue];
    //    NSString  *title = dict[@"title"];
    //    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",index,title];
//    cell.backgroundColor = UIColor.cyanColor;
    
    if (@available(iOS 14.0, *)) {
        UIListContentConfiguration *content = cell.defaultContentConfiguration;
        
        // Configure content.
        content.image = [UIImage systemImageNamed:@"star"];
        content.text = @"Favorites";
        content.imageProperties.tintColor = UIColor.purpleColor;
        cell.contentConfiguration = content;
        
        
        UIBackgroundConfiguration  *back = [UIBackgroundConfiguration listPlainCellConfiguration];
//        UIImageView *imgView =[UIImageView.alloc initWithImage:[UIImage imageNamed:@"200x100"]];
//        imgView.contentMode = UIViewContentModeScaleToFill;
//        back.customView = imgView;
        back.backgroundColor = UIColor.greenColor;
        
        cell.backgroundConfiguration = back;
        
    } else {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    


    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.isEditing) {
        return;
    }
    //    NSDictionary *dict = self.dataArray[indexPath.row];
    //
    //    void (^ didSelectRowAtIndexPath)(void) = dict[@"action"];
    //
    //    didSelectRowAtIndexPath();
    
    AXNoMsgLog(@"navigationBar height = %lf",self.navigationController.navigationBar.frame.size.height);
    AXNoMsgLog(@"ax_status_bar_height = %lf",ax_status_bar_height());
    AXNoMsgLog(@"ax_safe_area_insets_top = %lf",ax_safe_area_insets_top());
    AXNoMsgLog(@"ax_navigation_and_status_height = %lf",ax_navigation_and_status_height());
    AXNoMsgLog(@"ax_navigation_bar_height = %lf",ax_navigation_bar_height());
    AXNoMsgLog(@"ax_tab_bar_height = %lf",ax_tab_bar_height());
    
    _01ContentViewController *vc = _01ContentViewController.alloc.init;
    [self ax_pushVC:vc];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    }
    return _tableView;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray =  @[
            @{
                @"index": @1,
                @"title": @"单元测试",
                @"action": ^{
                    _01ContentViewController *vc = _01ContentViewController.alloc.init;
                    [self ax_pushVC:vc];
                },
            },
        ].mutableCopy;
    }
    return _dataArray;
}
//-(void)canRotate
//{
//
//}
/** 是否支持自动转屏 */
//- (BOOL)shouldAutorotate {
//
//    return YES;
//
//}
/** 支持哪些屏幕方向 */

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//
////    return UIInterfaceOrientationMaskPortrait| UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//    return UIInterfaceOrientationMaskAll;
//}

/** 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法） */

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//
//    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//
//}


@end
