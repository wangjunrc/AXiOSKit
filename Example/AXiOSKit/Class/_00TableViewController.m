
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
#import "_00TableViewController.h"
#import "_01ContentViewController.h"
#import "_01ThemeViewController.h"
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
#import "_26RMQClientViewController.h"
#import "_27MQTTClientViewController.h"
#import "_28ShareFileViewController.h"
#import "_29AudioViewController.h"
#import "_30IGListViewController.h"
#import <AXiOSKit/AXPayVC.h>
#import <AXiOSKit/AXPresentGesturesBack.h>
#import <AXiOSKit/AXSystemAuthorizerManager.h>
#import <AXiOSKit/NSMutableArray+AXKVO.h>
#import <AXiOSKit/NSMutableArray+AXKVO.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <mach/mach.h>

@import AssetsLibrary;

typedef void (^CollectionBlock)(void);

@interface _00TableViewController ()
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

@implementation _00TableViewController

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
    
#if TARGET_IPHONE_SIMULATOR
    // 模拟器
    AXLoger(@"模拟器");
#elif TARGET_OS_IPHONE
    // 真机
    AXLoger(@"真机");
#endif
    
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
    
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem ax_itemByButton:btn],[UIBarButtonItem ax_itemByButton:btn2]];
}


-(void)deleteAction:(UIButton *)btn{
    
    [self.tableView beginUpdates];
    NSMutableArray *temp = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView.indexPathsForSelectedRows
     enumerateObjectsUsingBlock:^(NSIndexPath *_Nonnull obj, NSUInteger idx,
                                  BOOL *_Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"obj.row %ld",obj.row);
        [temp addObject:strongSelf.dataArray[obj.row]];
        
    }];
    
    [self.dataArray removeObjectsInArray:temp];
    [self.tableView
     deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows
     withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
    
    //    NSString *title = @"置顶";
    //    if (indexPath.section == 0) {
    //        title = @"取消置顶";
    //    } else {
    //        title = @"置顶";
    //    }
    //    UIContextualAction *topAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:title handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {            // 这句很重要，退出编辑模式，隐藏左滑菜单
    //        [tableView setEditing:NO animated:YES];
    //        completionHandler(true);
    //    }];
    
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        action.title =@"删除1";
        action.image = [UIImage imageNamed:@"cell_right_delete"];
        // 这句很重要，退出编辑模式，隐藏左滑菜单
        [tableView setEditing:NO animated:YES];
        completionHandler(true);
    }];
    deleteAction.title =@"删除1";
    deleteAction.image = [UIImage imageNamed:@"cell_right_delete"];
    UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    // 禁止侧滑无线拉伸
    actions.performsFirstActionWithFullSwipe = NO;
    return actions;
}

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
                @"title": @"暗黑主题-ViewController",
                @"action": ^{
                    _01ThemeViewController *vc = [[_01ThemeViewController alloc] init];
                    [self ax_pushVC:vc];
                },
            },
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
                    _01ThemeViewController *vc = [[_01ThemeViewController alloc]init];
                    
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
                @"title": @"权分享文件",
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
                    _01ThemeViewController *vc = [_01ThemeViewController ax_init];
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
            
            
            
            
        ].mutableCopy;
    }
    return _dataArray;
}

@end
