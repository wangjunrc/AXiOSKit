
//
//  TableViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "CopyActivity.h"
#import "MyActivity.h"
#import "RouterManager.h"
#import "TestObj.h"
#import "_00TableViewCell.h"
#import "_00FirstViewController.h"
#import "_01ContentViewController.h"
#import "_02ChatViewController.h"
#import "_04RunLoopViewController.h"
#import "_06WCDBViewController.h"
#import "_07VideoViewController.h"
#import "_09AFNViewController.h"
#import "_10TextFViewController.h"
#import "_13WebpViewController.h"
#import "_13WeImageTableViewController.h"
#import "_14TFViewController.h"
#import "_15UIMenuController.h"
#import "_16KeyChainViewController.h"
#import "_17OtherShareViewController.h"
#import "_18MGSwipeTableVC.h"
#import "_19ScrollContentViewController.h"
#import "_20iOS14ViewController.h"
#import "_21KVOViewController.h"
#import "_22ReactiveObjCViewController.h"
#import "_23FullViewController.h"
#import "_24NoteViewController.h"
#import "_25LayoutViewController.h"
#import "_25FlowLayoutVC1.h"
#import "_25CompLayoutVC1.h"
#import "_25CompLayoutVC2.h"
#import "_25CompLayoutVC3.h"
#import "_25CompLayoutVC4.h"
#import "_25CompLayoutVC5.h"
#import "_26RMQClientViewController.h"
#import "_27MQTTClientViewController.h"
#import "_28ShareFileViewController.h"
#import "_29AudioViewController.h"
#import "_30IGListViewController.h"
#import "_31GCDViewController.h"
#import <AXiOSKit/AXPayVC.h>
#import <AXiOSKit/AXPresentGesturesBack.h>
#import <AXiOSKit/AXSystemAuthorizerManager.h>
#import <AXiOSKit/NSMutableArray+AXKVO.h>
#import <AXiOSKit/NSMutableArray+AXKVO.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <mach/mach.h>
#import "_00HeaderView.h"

@import AssetsLibrary;

typedef void (^CollectionBlock)(void);

@interface _00FirstViewController ()
{
    NSInteger _count;
}

@property (atomic, assign) NSInteger count;
@property (atomic, copy) NSString *name;
@property (nonatomic, copy) NSMutableString *copyedMStr;
@property (nonatomic, copy) NSString *copyedStr;
@property (nonatomic, strong) AXSystemAuthorizerManager *authorizerManager;
@property (nonatomic, strong) NSMutableArray<NSDictionary*> *dataArray;
@property (nonatomic, strong) NSMutableString *strongMStr;
@property (nonatomic, strong) NSString *strongStr;

@end

@implementation _00FirstViewController

//- (void)injected {
//    NSLog(@"重启了 InjectionIII: %@", self);
//    
//    [self viewDidLoad];
//}

//- (instancetype)initWithStyle:(UITableViewStyle)style {
//    return [super initWithStyle:UITableViewStyleGrouped];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题";
    self.tableView.tableFooterView = UIView.alloc.init;
    [self.tableView ax_registerNibCellClass:_00TableViewCell.class];
    self.dataArray = nil;
    [self.tableView reloadData];
    /// 多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
#if TARGET_IPHONE_SIMULATOR
    // 模拟器
    AXLoger(@"模拟器");
#elif TARGET_OS_IPHONE
    // 真机
    AXLoger(@"真机");
#endif
    
    NSLog(@"启动图缓存路径 %@",NSString.ax_launchImageCacheDirectory);
    
    __weak typeof(self) weakSelf = self;
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_addTargetBlock:^(UIButton * _Nullable button) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView setEditing:!strongSelf.tableView.isEditing animated:YES];
    }];
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"删除" forState:UIControlStateNormal];
    btn2.backgroundColor = UIColor.blueColor;
    [btn2 addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 ax_constraintButtonItemWidth:120 height:30];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem ax_itemByButton:btn],[UIBarButtonItem ax_itemByButton:btn2]];
    
    self.tableView.tableHeaderView =[_00HeaderView.alloc init];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self _updateHeaerLauout];
}

//tableview tableheaderview高度自适应
-(void)_updateHeaerLauout {
    _00HeaderView *header = (_00HeaderView *)self.tableView.tableHeaderView;
    if (!header) {
        return;
    }
    CGSize size = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (header.frame.size.height != size.height) {
        CGRect frame = header.frame;
        frame.size.height = size.height;
        header.frame = frame;
        //刷新tableHeaderView
        self.tableView.tableHeaderView = header;
    }
}

-(void)_deleteCellArray:(NSArray<NSIndexPath *>*)array{
    
    /// 删除数据源
//    if (@available(iOS 11.0, *)) {
//        [self.tableView performBatchUpdates:^{
//
//        } completion:^(BOOL finished) {
//            [self.tableView reloadData];
//        }];
//    } else {
//        [self.tableView beginUpdates];
//        [self.tableView endUpdates];
//        [self.tableView reloadData];
//    }
    
    
    [self.tableView beginUpdates];
    NSMutableArray *temp = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    [array enumerateObjectsUsingBlock:^(NSIndexPath *_Nonnull obj, NSUInteger idx,
                                        BOOL *_Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [temp addObject:strongSelf.dataArray[obj.row]];
    }];
    
    [self.dataArray removeObjectsInArray:temp];
    [self.tableView
     deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows
     withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

-(void)deleteAction:(UIButton *)btn{
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
    _00TableViewCell *cell = [tableView ax_dequeueReusableCellWithIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.indexLabel.text = [dict[@"index"] stringValue];
    cell.nameLabel.text = dict[@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.isEditing) {
        return;
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    void (^ didSelectRowAtIndexPath)(void) = dict[@"action"];
    
    didSelectRowAtIndexPath();
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

-(BOOL)tableView:(UITableView *)tableView shouldBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

/// iOS13多指选中开始，这里可以做一些UI修改，比如修改导航栏上按钮的文本
-(void)tableView:(UITableView *)tableView didBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath {
    
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


- (void)testPerson {
}

- (void)testObj:(TestObj *)obj {
    //    NSAssert([obj respondsToSelector:@selector(log)], @"对的不对");
    
    //    if( [obj instancesRespondToSelector:@selector(log)] ) {
    //
    //    }
    
    NSLog(@">>>> %d == %d", [obj.class instancesRespondToSelector:@selector(log)],
          [obj.class instancesRespondToSelector:@selector(log2)]);
    
    NSLog(@"=== %d", [obj respondsToSelector:@selector(log)]);
    
    if ([obj.class instancesRespondToSelector:@selector(log)]) {
        [obj log];
    } else {
        NSLog(@"未z实现");
    }
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
                @"index": @1,
                @"title": @"隐藏导航栏",
                @"action": ^{
                    _01ContentViewController *vc = [[_01ContentViewController alloc]init];
                    
                    [self ax_pushVC:vc];
                    //                        vc.ax_shouldNavigationBarHidden = YES;
                 
                    vc.AXListener.hiddenNavigationBar = YES;
                    NSLog(@"vc.AXListener.shouldNavigationBarHidden %d",vc.AXListener.isHiddenNavigationBar);
                },
            },
            
            @{
                @"index": @2,
                @"title": @"聊天-ChatViewController",
                @"action": ^{
                    _02ChatViewController *vc = [[_02ChatViewController alloc] init];
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
                @"title": @"微信分享",
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
                @"title": @"iOS14适配",
                @"action": ^{
                    _20iOS14ViewController *vc = [[_20iOS14ViewController alloc] init];
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
                @"title": @"约束全屏-prefersStatusBarHidden,setNavigationBarHidden",
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
            
        ].mutableCopy;
    }
    return _dataArray;
}

@end
