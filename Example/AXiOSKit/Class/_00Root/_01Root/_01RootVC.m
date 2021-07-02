
//
//  TableViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "AnimRefreshFooter.h"
#import "AnimRefreshHeader.h"
#import "CopyActivity.h"
#import "MyActivity.h"
#import "RouterManager.h"
#import "_00TableViewCell.h"
#import "_01ContentViewController.h"
#import "_01HeaderView.h"
#import "_01RootVC.h"
#import "_02NavColorViewController.h"
#import "_03ChatViewController.h"
#import "_04RunLoopViewController.h"
#import "_05WebVC.h"
#import "_06WCDBViewController.h"
#import "_07VideoViewController.h"
#import "_08MP3VC.h"
#import "_09AFNViewController.h"
#import "_10TextFViewController.h"
#import "_13SDWebImageVC.h"
#import "_13WeImageTableViewController.h"
#import "_13WebpViewController.h"
#import "_14TFViewController.h"
#import "_15UIMenuController.h"
#import "_16KeyChainViewController.h"
#import "_17OtherShareViewController.h"
#import "_18MGSwipeTableVC.h"
#import "_19ScrollContentViewController.h"
#import "_20PhotoViewController.h"
#import "_21KVOViewController.h"
#import "_22ReactiveObjCViewController.h"
#import "_23FullViewController.h"
#import "_24NoteViewController.h"
#import "_25CompLayoutVC1.h"
#import "_25CompLayoutVC2.h"
#import "_25CompLayoutVC3.h"
#import "_25CompLayoutVC4.h"
#import "_25CompLayoutVC5.h"
#import "_25FlowLayoutVC1.h"
#import "_25LayoutViewController.h"
#import "_25_2_DiffableDataSource.h"
#import "_26RMQClientViewController.h"
#import "_27MQTTClientViewController.h"
#import "_28ShareFileViewController.h"
#import "_29AudioViewController.h"
#import "_30IGListViewController.h"
#import "_31GCDViewController.h"
#import "_32LottieVC.h"
#import "_33CropViewController.h"
#import "_34ViewController.h"
#import "_35ProtobufVC.h"
#import "_36YYKitTestVC.h"
#import "_37FileManagerVC.h"
#import "_38DirectionVC.h"
#import "_39MasonryViewController.h"
#import "_40ScreenshotsVC.h"
#import "_41SlideHeadVC.h"
#import <AXiOSKit/AXPayVC.h>
#import <AXiOSKit/AXPresentGesturesBack.h>
#import <AXiOSKit/AXSystemAuthorizerManager.h>
#import <AXiOSKit/UIViewController+AXNavBarConfig.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <mach/mach.h>
#import "Person.h"
#import <AXCollectionObserve/AXCollectionObserve.h>
#import "_02QQZoneController.h"
@import AssetsLibrary;

@interface _01RootVC ()

@property (nonatomic, strong) AXSystemAuthorizerManager *authorizerManager;
@property (nonatomic, strong) NSMutableArray<NSDictionary*> *dataArray;
@property(nonatomic, strong) UIBarButtonItem *deleteItem;
@property(nonatomic, strong) UIBarButtonItem *editItem;
@property(nonatomic, strong) UISearchController *searchVC;

@end

@implementation _01RootVC

- (void)injected {
    NSLog(@"重启了 InjectionIII: %@", self);
    
    [self viewDidLoad];
}

//- (instancetype)initWithStyle:(UITableViewStyle)style {
//    return [super initWithStyle:UITableViewStyleGrouped];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = AXNSLocalizedString(@"local.home");
    
    NSLog(@"国际化 = %@",NSLocalizedString(@"local.home", nil));
    
    AXLog(@"我是AXLog");
    
    self.tableView.tableFooterView = UIView.alloc.init;
    [_00TableViewCell ax_registerNibCellWithTableView:self.tableView];
    self.navigationItem.rightBarButtonItems = @[self.editItem,self.deleteItem];
    _01HeaderView *headerView = [_01HeaderView.alloc init];
    self.tableView.tableHeaderView =headerView;
    
    self.dataArray = nil;
    [self.tableView reloadData];
    /// 多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    NSLog(@"启动图缓存路径 %@",NSString.ax_launchImageCacheDirectory);
    
    UIButton *btn = self.editItem.customView;
    [RACObserve(btn,selected) subscribeNext:^(id _Nullable x) {
        NSLog(@"editItem selected=%@",x);
    }];
    
    //    [self _rac_kvo];
    [self _createRefresh];
    [self _createSearch];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView ax_layoutHeaderHeight];
}

-(void)_deleteCellArray:(NSArray<NSIndexPath *>*)array {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ax_updates:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSMutableArray *temp = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSIndexPath *_Nonnull obj, NSUInteger idx,
                                            BOOL *_Nonnull stop) {
            [temp addObject:strongSelf.dataArray[obj.row]];
        }];
        
        [strongSelf.dataArray removeObjectsInArray:temp];
        [strongSelf.tableView
         deleteRowsAtIndexPaths:strongSelf.tableView.indexPathsForSelectedRows
         withRowAnimation:UITableViewRowAnimationNone];
        
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    }];
    
}

-(void)deleteAction:(UIButton *)btn {
    [self _deleteCellArray:self.tableView.indexPathsForSelectedRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"vc";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor groupTableViewBackgroundColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //   header.contentView.backgroundColor=UIColor.whiteColor;
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    header.textLabel.font = [UIFont systemFontOfSize:20];
    [header.textLabel setTextColor:UIColor.redColor];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
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
    AXLogFunc;
    if (tableView.isEditing) {
        self.deleteItem.enabled = self.tableView.indexPathsForSelectedRows.count;
        return;
    }
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    void (^action)(void) = dict[@"action"];
    action();
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    AXLogFunc;
    if (tableView.isEditing) {
        self.deleteItem.enabled = self.tableView.indexPathsForSelectedRows.count;
        return;
    }
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView.isEditing) {
//        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//    }
//    return UITableViewCellEditingStyleDelete;
//}

// 实现UITableViewDelegate的两个代理

/// iOS13是否允许多指选中

-(BOOL)tableView:(UITableView *)tableView shouldBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(13.0)){
    
    return YES;
}

/// iOS13多指选中开始，这里可以做一些UI修改，比如修改导航栏上按钮的文本
-(void)tableView:(UITableView *)tableView didBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(13.0)){
    
    // 最后当用户选择完，要做某些操作的时候，我们可以用 tableView.indexPathsForSelectedRows 获取用户选择的 rows。
    
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) {
    
    NSMutableArray<UIContextualAction *> *actionsArray = [NSMutableArray array];
    
    {
        /// 效果和iOS短信效果一样,不能监控点击2次,UIContextualActionStyleDestructive
        UIContextualAction *deleAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            __weak typeof(self) weakSelf = self;
            [self ax_showAlertByTitle:@"是否删除" message:nil confirm:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf.dataArray removeObjectAtIndex:indexPath.section];
                [strongSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                completionHandler(YES);
            } cancel:^{
                completionHandler(YES);
            }];
            
        }];
        if (@available(iOS 13.0, *)) {
            deleAction.image = [UIImage systemImageNamed:@"trash.circle.fill"];
        } else {
            deleAction.image = [UIImage imageNamed:@"cell_right_delete"];
        }
        deleAction.backgroundColor = [UIColor blueColor];
        [actionsArray addObject:deleAction];
        
    }
    {
        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            completionHandler(YES);
            
        }];
        if (@available(iOS 13.0, *)) {
            action.image = [UIImage systemImageNamed:@"folder.circle.fill"];
        } else {
            action.image = [UIImage imageNamed:@"cell_right_delete"];
        }
        action.backgroundColor = [UIColor orangeColor];
        [actionsArray addObject:action];
        
    }
    
    
    UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:actionsArray];
    // 禁止侧滑无线拉伸
    actions.performsFirstActionWithFullSwipe = NO;
    return actions;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    tableView.backgroundColor = UIColor.whiteColor;
//    // 圆角角度
//      CGFloat radius = 10.f;
//      // 设置cell 背景色为透明
//      cell.backgroundColor = UIColor.clearColor;
//      // 创建两个layer
//      CAShapeLayer *normalLayer = [[CAShapeLayer alloc] init];
//      CAShapeLayer *selectLayer = [[CAShapeLayer alloc] init];
//      // 获取显示区域大小
//      CGRect bounds = CGRectInset(cell.bounds, 10, 0);
//      // 获取每组行数
//      NSInteger rowNum = [tableView numberOfRowsInSection:indexPath.section];
//      // 贝塞尔曲线
//      UIBezierPath *bezierPath = nil;
//
//    if (rowNum == 1) {
//        // 一组只有一行（四个角全部为圆角）
//        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
//                                           byRoundingCorners:UIRectCornerAllCorners
//                                                 cornerRadii:CGSizeMake(radius, radius)];
//    } else {
//        if (indexPath.row == 0) {
//            // 每组第一行（添加左上和右上的圆角）
//            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
//                                               byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
//                                                     cornerRadii:CGSizeMake(radius, radius)];
//
//        } else if (indexPath.row == rowNum - 1) {
//            // 每组最后一行（添加左下和右下的圆角）
//            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
//                                               byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
//                                                     cornerRadii:CGSizeMake(radius, radius)];
//        } else {
//            // 每组不是首位的行不设置圆角
//            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
//        }
//    }
//    // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
//    normalLayer.path = bezierPath.CGPath;
//    selectLayer.path = bezierPath.CGPath;
//
//
//    UIView *nomarBgView = [[UIView alloc] initWithFrame:bounds];
//    // 设置填充颜色
////    normalLayer.fillColor = [UIColor redColor].CGColor;
//    normalLayer.fillColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    // 添加图层到nomarBgView中
//    [nomarBgView.layer insertSublayer:normalLayer atIndex:0];
//    nomarBgView.backgroundColor = UIColor.clearColor;
//    cell.backgroundView = nomarBgView;
//
//    UIView *selectBgView = [[UIView alloc] initWithFrame:bounds];
//    selectLayer.fillColor = [UIColor orangeColor].CGColor;
//    [selectBgView.layer insertSublayer:selectLayer atIndex:0];
//    selectBgView.backgroundColor = UIColor.clearColor;
//    cell.selectedBackgroundView = selectBgView;
//
//
//}


//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    for (UIView *subview in tableView.subviews) {
//        if ([NSStringFromClass([subview class]) isEqualToString:@"UISwipeActionPullView"]) {
//            if ([NSStringFromClass([subview.subviews[0] class]) isEqualToString:@"UISwipeActionStandardButton"]) {
//                UIButton *collectBtn = subview.subviews[0];
//                collectBtn.backgroundColor = [UIColor greenColor];
//                [collectBtn setImage:[UIImage imageNamed:@"cell_right_delete"] forState:UIControlStateNormal];
//                [collectBtn setTitle:@"删除" forState:UIControlStateNormal];
//            }
//        }
//    }
//}


-(void)_rac_kvo{
    
    /// 监听数据源
    [[self rac_signalForSelector:@selector(tableView:numberOfRowsInSection:)
                    fromProtocol:@protocol(UITableViewDataSource)]
     subscribeNext:^(RACTuple * _Nullable x) {
        //        RACTupleUnpack(UITableView *tableView,NSNumber *section) = x;
        
        NSLog(@"监听协议numberOfRowsInSection=%@",x);
        //        NSLog(@"监听协议numberOfRowsInSection参数=%@,section=%@",tableView,section);
        //        [x objectAtIndex:2]
        NSLog(@"监听协议numberOfRowsInSection参数section=%@",x.second);
    }];
    
    /* 1.代替代理 */
    //   self.textField.delegate = self;
    // 监听代理
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)
                    fromProtocol:@protocol(UITableViewDelegate)]
     subscribeNext:^(RACTuple * _Nullable x) {
        RACTupleUnpack(UITableView *tableView,NSIndexPath *indexPath) = x;
        NSLog(@"监听实现的代理didSelectRowAtIndexPath=%@",x);
        NSLog(@"监听实现的代理didSelectRowAtIndexPath=%@,indexPath=%@",tableView,indexPath);
    }];
    
    if ([self respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        // 未实现代理,监听不到
        [[self rac_signalForSelector:@selector(tableView:didDeselectRowAtIndexPath:)
                        fromProtocol:@protocol(UITableViewDelegate)]
         subscribeNext:^(RACTuple * _Nullable x) {
            NSLog(@"监听未实现的代理didDeselectRowAtIndexPath=%@",x);
        }];
    }
    
}
/// 刷新
-(void)_createRefresh {
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [AnimRefreshHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView.mj_header beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.tableView.mj_header endRefreshing];
        });
        
    }];
    
    
    self.tableView.mj_footer = [AnimRefreshFooter footerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView.mj_footer beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.tableView.mj_footer endRefreshing];
        });
    }];
}

/// 搜索栏
-(void)_createSearch{
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchVC;
        /// https://github.com/CoderMJLee/MJRefresh/issues/1317
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
    }
    
}

#pragma mark - get

- (UIBarButtonItem *)editItem {
    if (!_editItem) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateSelected];
        btn.backgroundColor = UIColor.blueColor;
        __weak typeof(self) weakSelf = self;
        [btn ax_addTargetBlock:^(UIButton * _Nullable button) {
            button.selected = !button.selected;
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.tableView setEditing:!strongSelf.tableView.isEditing animated:YES];
        }];
        _editItem =[UIBarButtonItem ax_itemByButton:btn];
    }
    return _editItem;
}

- (UIBarButtonItem *)deleteItem {
    if (!_deleteItem) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.lightTextColor forState:UIControlStateDisabled];
        btn.backgroundColor = UIColor.blueColor;
        [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn ax_constraintButtonItemWidth:120 height:30];
        _deleteItem =[UIBarButtonItem ax_itemByButton:btn];
        _deleteItem.enabled = NO;
    }
    return _deleteItem;
}
- (UISearchController *)searchVC {
    if (!_searchVC) {
        
        _searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
        
        // 1.设置placeholder
        _searchVC.searchBar.placeholder = @"头部搜索";
        
        // 2.设置searchBar的背景透明
        //        [_searchVC.searchBar setBackgroundImage:[UIImage new]];
        //        _searchVC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        
        // 3.设置搜索框文字的偏移
        //        _searchVC.searchBar.searchTextPositionAdjustment = UIOffsetMake(3, 0);
        
        // 4.设置搜索框图标的偏移
        //        CGFloat offsetX = (self.view.bounds.size.width - 200 - 32) / 2;
        //        [_searchVC.searchBar setPositionAdjustment:UIOffsetMake(offsetX, 0) forSearchBarIcon:UISearchBarIconSearch];
        
        // 5.取消按钮和文本框光标颜色
        //        _searchVC.searchBar.tintColor = [UIColor blackColor];
        
        // 6.设置搜索文本框背景图片 [圆形的文本框只需要设置一张圆角图片就可以了]
        //        [_searchVC.searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.bounds.size.width - 32, 36) isRound:YES] forState:UIControlStateNormal];
        // 7.设置搜索按钮图片
        //        UIImage *searchImg = [[UIImage imageNamed:@"ax_icon_weixin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        [_searchVC.searchBar setImage:searchImg forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        // 8.拿到搜索文本框
        //        UITextField *searchField = [_searchVC.searchBar valueForKey:@"_searchField"];
        //        // 9.设置取消按钮文字
        //        [_searchVC.searchBar setValue:@"Custom Cancel" forKey:@"_cancelButtonText"];
        
        
    }
    return _searchVC;
}
#pragma mark -  数据源

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray =  @[
            @{
                @"index": @1,
                @"title": @"ContentViewController",
                @"action": ^{
                    _01ContentViewController *vc =
                    [[_01ContentViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @2,
                @"title": @"导航栏效果",
                @"action": ^{
                    _02NavColorViewController *vc = [[_02NavColorViewController alloc]init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @2,
                @"title": @"导航栏渐变",
                @"action": ^{
                    _02QQZoneController *vc = [[_02QQZoneController alloc]init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @3,
                @"title": @"聊天-ChatViewController",
                @"action": ^{
                    _03ChatViewController *vc = [[_03ChatViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @4,
                @"title": @"NSRunLoop模式",
                @"action": ^{
                    _04RunLoopViewController *vc = [[_04RunLoopViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @5,
                @"title": @"WKWebVC",
                @"action": ^{
                    _05WebVC *vc = [[_05WebVC alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @6,
                @"title": @"WCDB",
                @"action": ^{
                    _06WCDBViewController *vc = [[_06WCDBViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @7,
                @"title": @"视频",
                @"action": ^{
                    _07VideoViewController *vc = [[_07VideoViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @8,
                @"title": @"音频",
                @"action": ^{
                    _08MP3VC *vc = [[_08MP3VC alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @9,
                @"title": @"AFN",
                @"action": ^{
                    _09AFNViewController *vc = [[_09AFNViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @10,
                @"title": @"多行textview-alert",
                @"action": ^{
                    _10TextFViewController *vc = [[_10TextFViewController alloc] init];
                    [self ax_showVC:vc];
                },
            },
            @{
                @"index": @13,
                @"title": @"SDWebImage测试",
                @"action": ^{
                    _13SDWebImageVC *vc = [[_13SDWebImageVC alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @13,
                @"title": @"webp/GIF",
                @"action": ^{
                    _13WebpViewController *vc = [[_13WebpViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @13,
                @"title": @"WeImage",
                @"action": ^{
                    _13WeImageTableViewController *vc = [[_13WeImageTableViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @14,
                @"title": @"TextFeild",
                @"action": ^{
                    _14TFViewController *vc = [[_14TFViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @15,
                @"title": @"UIMenuController",
                @"action": ^{
                    _15UIMenuController *vc = [[_15UIMenuController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @16,
                @"title": @"KeyChain",
                @"action": ^{
                    _16KeyChainViewController *vc =
                    [[_16KeyChainViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @17,
                @"title": @"第三方分享",
                @"action": ^{
                    _17OtherShareViewController *vc =
                    [[_17OtherShareViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @18,
                @"title": @"SwipeTableVC",
                @"action": ^{
                    _18MGSwipeTableVC *vc = [[_18MGSwipeTableVC alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @19,
                @"title": @"Scroll自适应内容",
                @"action": ^{
                    _19ScrollContentViewController *vc =
                    [[_19ScrollContentViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @20,
                @"title": @"照片相册选择",
                @"action": ^{
                    _20PhotoViewController *vc = [[_20PhotoViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @21,
                @"title": @"KVO",
                @"action": ^{
                    _21KVOViewController *vc = [[_21KVOViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @22,
                @"title": @"ReactiveObjCViewController",
                @"action": ^{
                    _22ReactiveObjCViewController *vc =
                    [[_22ReactiveObjCViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @23,
                @"title": @"约束全屏\n prefersStatusBarHidden\n setNavigationBarHidden",
                @"action": ^{
                    _23FullViewController *vc = [[_23FullViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @24,
                @"title": @"本地通知",
                @"action": ^{
                    _24NoteViewController *vc = [[_24NoteViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @25,
                @"title": @"Layout-UICollectionView",
                @"action": ^{
                    _25LayoutViewController *vc =
                    [[_25LayoutViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @25,
                @"title": @"UICollectionView 左右空隙",
                @"action": ^{
                    _25FlowLayoutVC1 *vc =
                    [[_25FlowLayoutVC1 alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @25,
                @"title": @"水平滚动，但cell大小交替变换，且cell居中对齐。",
                @"action": ^{
                    if (@available(iOS 13.0, *)) {
                        _25CompLayoutVC1 *vc =
                        [[_25CompLayoutVC1 alloc] init];
                        [self ax_pushVC:vc];
                    }
                },
            },
            @{
                @"index": @25,
                @"title": @"垂直滚动，一个大cell + 两个小cell 交替",
                @"action": ^{
                    _25CompLayoutVC2 *vc =
                    [[_25CompLayoutVC2 alloc] init];
                    [self ax_pushVC:vc];
                    
                },
            },
            @{
                @"index": @25,
                @"title": @"25-3 类似App Store 效果",
                @"action": ^{
                    _25CompLayoutVC3 *vc =
                    [[_25CompLayoutVC3 alloc] init];
                    [self ax_pushVC:vc];
                    
                },
            },
            
            @{
                @"index": @25,
                @"title": @"25-4 含有背景",
                @"action": ^{
                    _25CompLayoutVC4 *vc =
                    [[_25CompLayoutVC4 alloc] init];
                    [self ax_pushVC:vc];
                    
                },
            },
            @{
                @"index": @25,
                @"title": @"25-4 NSCollectionLayoutGroupCustomItem",
                @"action": ^{
                    _25CompLayoutVC5 *vc =
                    [[_25CompLayoutVC5 alloc] init];
                    [self ax_pushVC:vc];
                    
                },
            },
            
            @{
                @"index": @25,
                @"title": @"25_2-UITableViewDiffableDataSource",
                @"action": ^{
                    if (@available(iOS 14.0, *)) {
                        _25_2_DiffableDataSource *vc =
                        [[_25_2_DiffableDataSource alloc] init];
                        [self ax_pushVC:vc];
                    }
                    
                },
            },
            
            
            @{
                @"index": @26,
                @"title": @"RMQClient",
                @"action": ^{
                    _26RMQClientViewController *vc =
                    [[_26RMQClientViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @27,
                @"title": @"MQTT",
                @"action": ^{
                    _27MQTTClientViewController *vc =
                    [[_27MQTTClientViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @27,
                @"title": @"AXChoosePayVC",
                @"action": ^{
                    AXPayVC *vc = [[AXPayVC alloc] init];
                    vc.orderText = @"订单1111";
                    vc.amountText = @"3.2元";
                    [self ax_showVC:vc];
                    
                },
            },
            @{
                @"index": @27,
                @"title": @"AXDateVC",
                @"action": ^{
                    AXDateVC *vc = [[AXDateVC alloc] init];
                    [vc didSelectDate:NSDate.date confirm:^(NSDate * _Nonnull date) {
                        NSLog(@"date %@",date);
                    } cancel:^{
                        
                    }];
                    [self ax_showVC:vc];
                    
                },
            },
            @{
                @"index": @27,
                @"title": @"AXSinglePickVC",
                @"action": ^{
                    AXSinglePickVC *vc = [[AXSinglePickVC alloc] init];
                    [vc didSelected:@[@"A",@"B"] showRow:1 confirm:^(NSInteger index) {
                        
                    } cancel:^{
                        
                    }];
                    [self ax_showVC:vc];
                    
                },
            },
            
            @{
                @"index": @28,
                @"title": @"预览文件",
                @"action": ^{
                    _28ShareFileViewController *vc =
                    [[_28ShareFileViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @28,
                @"title": @"权限",
                @"action": ^{
                    self.authorizerManager = [AXSystemAuthorizerManager
                                              requestAuthorizedWithType:AXSystemAuthorizerTypeLocation
                                              completion:^(AXSystemAuthorizerStatus status) {
                        NSLog(@"status == %ld", (long)status);
                    }];
                },
            },
            
            @{
                @"index": @29,
                @"title": @"仿微信小程序右滑关闭",
                @"action": ^{
                    _01ContentViewController *vc = [_01ContentViewController ax_init];
                    vc.view.backgroundColor = UIColor.orangeColor;
                    [AXPresentGesturesBack injectDismissTransitionForViewController:vc];
                    [self ax_showVC:vc];
                },
            },
            @{
                @"index": @29,
                @"title": @"音频",
                @"action": ^{
                    _29AudioViewController *vc = [_29AudioViewController ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @30,
                @"title": @"IGList",
                @"action": ^{
                    _30IGListViewController *vc = [_30IGListViewController ax_init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @31,
                @"title": @"多线程",
                @"action": ^{
                    _31GCDViewController *vc = [_31GCDViewController ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @32,
                @"title": @"Lottie动画",
                @"action": ^{
                    _32LottieVC *vc = [_32LottieVC ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @33,
                @"title": @"剪切图片",
                @"action": ^{
                    _33CropViewController *vc = [_33CropViewController ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @34,
                @"title": @"CTMediator路由",
                @"action": ^{
                    _34ViewController *vc = [_34ViewController ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @35,
                @"title": @"ProtobufVC",
                @"action": ^{
                    _35ProtobufVC *vc = [_35ProtobufVC ax_init];
                    [self ax_pushVC:vc];
                },
            },
            
            @{
                @"index": @36,
                @"title": @"YYKit",
                @"action": ^{
                    _36YYKitTestVC *vc = [_36YYKitTestVC ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @37,
                @"title": @"NSFileManager",
                @"action": ^{
                    _37FileManagerVC *vc = [_37FileManagerVC ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @38,
                @"title": @"屏幕旋转-push",
                @"action": ^{
                    _38DirectionVC *vc = [_38DirectionVC ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @38,
                @"title": @"屏幕旋转-show",
                @"action": ^{
                    _38DirectionVC *vc = [_38DirectionVC ax_init];
                    [self ax_showVC:vc];
                },
            },
            @{
                @"index": @39,
                @"title": @"Masonry布局",
                @"action": ^{
                    _39MasonryViewController *vc = [_39MasonryViewController ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @40,
                @"title": @"监测截屏,并删除",
                @"action": ^{
                    _40ScreenshotsVC *vc = [_40ScreenshotsVC ax_init];
                    [self ax_pushVC:vc];
                },
            },
            @{
                @"index": @41,
                @"title": @"滑动头部",
                @"action": ^{
                    _41SlideHeadVC *vc = [_41SlideHeadVC ax_init];
                    [self ax_pushVC:vc];
                },
            },
            
            
        ].mutableCopy;
    }
    return _dataArray;
}


// 是否支持设备自动旋转
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//// 支持屏幕显示方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}

@end
