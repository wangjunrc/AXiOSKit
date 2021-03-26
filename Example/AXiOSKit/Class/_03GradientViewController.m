//
//  _01GradientViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/1.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_03GradientViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/UIViewController+AXNavBarConfig.h>
@interface UIImage (imgaeWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@implementation UIImage (imgaeWithColor)


+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 开启上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(ref, color.CGColor);
    // 渲染上下文
    CGContextFillRect(ref, rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}


@end



@interface _03GradientViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation _03GradientViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏渐变";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellID"];
    
    
    
    NSLog(@"ax_safe_area_insets_top() = %f",ax_safe_area_insets_top());
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmItemAction:)];
    self.navigationItem.rightBarButtonItems = @[confirmItem];
    
    
    
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    // 必须设置,不然返回手势失效
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//       self.navigationController.navigationBar.translucent = YES;//设置透明
    
    
}
#pragma mark - UINavigationControllerDelegate
//将要显示控制器
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//
//}
-(void)confirmItemAction:(UIBarButtonItem *)sender {
    
}

-(void)cancelItemAction:(UIBarButtonItem *)sender {
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;;
    
}


#pragma mark - scrollview
#define oriOfftY -244
#define oriHeight 200

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
    CGFloat offset = scrollView.contentOffset.y;
    
    NSLog(@"offset = %f", scrollView.contentOffset.y);
//
//    CGFloat imgH = oriHeight - offset;
//    if (imgH < 64) {
//        imgH = 64;
//    }
    
    if (offset>0) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
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
    UIColor *alphaColor = [UIColor.orangeColor colorWithAlphaComponent:alpha];
    //把颜色生成图片
//    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
//    //修改导航条背景图片
//    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
//
    [self ax_setNavBarGradientWithColor:alphaColor alpha:alpha];
}
- (void)dealloc {
self.navigationController.delegate = nil;
NSLog(@"dealloc>>>>");
}
@end

