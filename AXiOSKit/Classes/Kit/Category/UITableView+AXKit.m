//
//  UITableView+AXKit.m
//  AXiOSKit
//
//  Created by liuweixing on 16/8/23.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UITableView+AXKit.h"
#import "AXConstant.h"
@implementation UITableView (AXKit)


/**
 UITableView 注册 NibCell
 
 @param nib nib
 @param identifier identifier
 */
- (void)ax_registerNibCell:(NSString *)nib identifier:(NSString * )identifier{
    [self registerNib:[UINib nibWithNibName:nib bundle:nil] forCellReuseIdentifier:identifier];
}

/**
 UITableView 注册 NibCell
 
 @param aClass nib
 @param identifier identifier
 */
- (void)ax_registerNibCellClass:(Class )aClass identifier:(NSString *_Nullable )identifier{
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(aClass) bundle:nil]forCellReuseIdentifier:identifier];
}
/**
 UITableView 注册 NibCell 默认使用 axCellID identifier
 
 @param aClass nib名称
 */
- (void)ax_registerNibCellClass:(Class )aClass{
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(aClass) bundle:nil] forCellReuseIdentifier:k_axCellID];
}

/**
 UITableView 注册 NibCell 默认使用 axCellID identifier
 
 @param nibName nib名称
 */
- (void)ax_registerNibCell:(NSString *)nibName{
    
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil]forCellReuseIdentifier:k_axCellID];
}

/**
 UITableView 注册 ClassCell 默认使用 axCellID identifier
 
 @param aClass Class
 */
- (void)ax_registerClassCell:(Class )aClass{
    [self registerClass:aClass forCellReuseIdentifier:k_axCellID];
    
}


/**
 UITableView dequeueReusableCel 默认使用 axCellID identifier
 
 @param indexPath indexPath
 @return UITableViewCell
 */
- (__kindof UITableViewCell *)ax_dequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath{
    
    return [self dequeueReusableCellWithIdentifier:k_axCellID forIndexPath:indexPath];
}


/**
 UITableView 注册 section Header
 计算是自定义的xib也得用class方法
 
 @param aClass Class
 */
- (void)ax_registerHeaderWithClass:(Class )aClass{
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:k_axCellHeadID];;
}

/**
 UITableView dequeueReusableHeaderFooterView axCellHeadID
 
 @return UITableViewHeaderFooterView
 */
- (nullable __kindof UITableViewHeaderFooterView *)ax_dequeueReusableHeader{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:k_axCellHeadID];
}

/**
 UITableView 注册 section Footer
 计算是自定义的xib也得用class方法
 
 @param aClass Class
 */
- (void)ax_registerFooterWithClass:(Class )aClass{
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:k_axCellFootID];;
}

/**
 UITableView dequeueReusableHeaderFooterView axCellHeadID
 
 @return UITableViewHeaderFooterView
 */
- (nullable __kindof UITableViewHeaderFooterView *)ax_dequeueReusableFooter{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:k_axCellFootID];
}

- (void)ax_footerViewZero{
    self.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

/**
 tableheaderview高度自适应
 示例
 - (void)viewDidLayoutSubviews {
 [super viewDidLayoutSubviews];
 [self.tableView ax_layoutHeaderHeight];
 }
 */
-(void)ax_layoutHeaderHeight {
    UIView *header = self.tableHeaderView;
    if (header) {
        CGSize size = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        if (header.frame.size.height != size.height) {
            CGRect frame = header.frame;
            frame.size.height = size.height;
            header.frame = frame;
            //刷新tableHeaderView
            self.tableHeaderView = header;
        }
    }
}


-(void)ax_updates:(void (NS_NOESCAPE ^ _Nullable)(void))updates completion:(void (^ _Nullable)(BOOL finished))completion {
    
    if (@available(iOS 11.0, *)) {
        [self performBatchUpdates:updates completion:completion];
    } else {
        [self beginUpdates];
        if (updates) {
            updates();
        }
        [self endUpdates];
        if (completion) {
            completion(YES);
        }
    }
}
@end
