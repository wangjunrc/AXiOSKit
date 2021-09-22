//
//  _45MXParallaxHeaderVC.m
//  AXiOSKit
//
//  Created by axinger on 2021/9/22.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_45MXParallaxHeaderVC.h"
#import "_45HeaderView.h"

@import MXParallaxHeader;

@interface _45MXParallaxHeaderVC ()<MXParallaxHeaderDelegate>

@property(nonatomic, strong)_45HeaderView *headerView;

@end

@implementation _45MXParallaxHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.tableView ax_registerClassCell:UITableViewCell.class];
    self.headerView = _45HeaderView.alloc.init;
    self.headerView.frame = CGRectMake(0, 0, self.view.width, 300);
    
    
    self.tableView.parallaxHeader.view =  self.headerView;
    self.tableView.parallaxHeader.height = 300;
    self.tableView.parallaxHeader.mode = MXParallaxHeaderModeCenter;
//    self.tableView.parallaxHeader.delegate = self;
    
//    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    if (@available(iOS 11.0, *)) {
//        self.tableView.parallaxHeader.minimumHeight = self.view.safeAreaInsets.top;
//    }
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView ax_dequeueReusableCellWithIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}


- (void)parallaxHeaderDidScroll:(MXParallaxHeader *)parallaxHeader {
    NSLog(@"progress %f", parallaxHeader.progress);
    
    
    CGFloat  angle = parallaxHeader.progress * M_PI * 2;
    NSLog(@"angle===%f", angle);
    //    self.headerView.imgView.transform = CGAffineTransform.identity.rotated(by: angle)
    
    
    //    self.headerView.imgView.transform = CGAffineTransformMakeRotation(angle);
    
}


@end
