//
//  _00SecondTableViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/9.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_00SecondTableViewController.h"
#import "MyActivity.h"
#import "RouterManager.h"
#import "TestObj.h"
#import "_00TableViewCell.h"
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

@interface _00SecondTableViewController ()

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataArray;

@end

@implementation _00SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题";
    self.tableView.tableFooterView = UIView.alloc.init;
    [self.tableView ax_registerNibCellClass:_00TableViewCell.class];
    self.dataArray = nil;
    [self.tableView reloadData];
    
}

- (void)test {
    NSLog(@"5");
}

///保存系统函数地址
static void (*replacedLog)(NSString *format, ...);

void mySLog(NSString *format, ...)
{
    replacedLog(@"%@", [format stringByAppendingString:@"被HOOK了"]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"测试";
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
                @"title": @"单元测试",
                @"action": ^{
                    //                    dispatch_queue_t queue =
                    //                    dispatch_get_global_queue(0, 0);
                    //                    dispatch_apply(10, queue, ^(size_t insex) {
                    //                        NSLog(@"insex = %zu",insex);
                    //                    });
                    //                    NSLog(@"insex = 完成");
                    
                    NSMutableArray *array =
                    [NSMutableArray arrayWithObjects:@"2", @"3", @"4", @"4", nil];
                    
                    //                    for (NSString *str in array) {
                    //                        if ([str isEqualToString:@"4"]) {
                    //                            [array removeObject:str];
                    //                        }
                    //                    }
                    
                    for (int i = 0; i < array.count; i++) {
                        NSString *str = array[i];
                        if ([str isEqualToString:@"4"]) {
                            [array removeObject:str];
                        }
                    }
                    
                    //                    NSEnumerator *enumerator = [array
                    //                    reverseObjectEnumerator]; NSLog(@"enumerator =
                    //                    %@",enumerator); for (NSString *str in
                    //                    array.reverseObjectEnumerator) {
                    //                       if ([str isEqualToString:@"4"]) {
                    //                           [array removeObject:str];
                    //                       }
                    //                    }
                    ////
                    ////
                    //                    NSLog(@"array = %@",array);
                    
                    NSMutableArray *tempArray =
                    [NSMutableArray arrayWithArray:@[ @"A", @"B", @"C" ]];
                    //                    for (NSString *number in
                    //                    tempArray.reverseObjectEnumerator) {
                    //                        if ([number isEqualToString:@"B"]) {
                    //                            [tempArray removeObject:number];
                    //                        }
                    //                    }
                    //                    NSLog(@"tempArray = %@",tempArray);
                    [tempArray
                     enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                                  BOOL *_Nonnull stop) {
                        if ([obj isEqualToString:@"B"]) {
                            [tempArray removeObject:obj];
                        }
                    }];
                    NSLog(@"tempArray = %@", tempArray);
                    NSDictionary *dict = @{
                        @"1": @"A",
                        @"1": @"AA",
                        @"2": @"B",
                        @"3": @"C",
                    };
                    //                    [dict enumerateKeysAndObjectsUsingBlock:^(id
                    //                    key, id value, BOOL *stop) {
                    //                        NSLog(@"key:%@->value%@",key,value);
                    //                    }];
                    
                    [dict.rac_sequence.signal subscribeNext:^(id x) {
                        RACTupleUnpack(NSString * key, NSString * value) = x;
                        NSLog(@"key=%@ value=%@", key, value);
                    }];
                    [dict.rac_keySequence.signal subscribeNext:^(id x) {
                        NSLog(@"x2 = %@", x);
                    }];
                    [dict.rac_valueSequence.signal subscribeNext:^(id x) {
                        NSLog(@"x3 = %@", x);
                    }];
                },
            },
            @{
                @"index": @2,
                @"title": @"UIAlertController 颜色",
                @"action": ^{
                    //                        [self ax_showAlertByTitle:@"A"
                    //                                          message:@"B"
                    //                                          confirm:^{
                    //                                          }
                    //                                           cancel:^{
                    //                                           }];
                    //                        [self ax_showAlertByTitle:@""
                    //                                          message:@""
                    //                                          confirm:^{
                    //                                          }
                    //                                           cancel:^{
                    //                                           }];
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"tile" message:@"msg" preferredStyle:UIAlertControllerStyleAlert];
                    
                    // 修改message字体及颜色
                    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
                    [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor redColor] range:NSMakeRange(0, alert.message.length)];
                    [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, alert.message.length)];
                    [alert setValue:messageStr forKey:@"attributedMessage"];
                    
                    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"确定") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    }]];
                    
                    
                    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                },
            },
            
            @{
                @"index": @3,
                @"title": @"对象未实现方法",
                @"action": ^{
                    [self ax_showAlertByTitle:@"是否调用"
                                      confirm:^{
                        UIButton *testButton = [[UIButton alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                        [testButton
                         performSelector:@selector(someMethod:)];
#pragma clang diagnostic pop
                    }];
                },
            },
            @{
                @"index": @4,
                @"title": @"路由 - RouterManager",
                @"action": ^{
                    [RouterManager
                     openURL:routeNameWith01ViewController
                     withUserInfo:@{ @"navigationController": self.navigationController }
                     completion:^(id _Nonnull result) {
                    }];
                },
            },
            
            @{
                @"index": @5,
                @"title": @"退出",
                @"action": ^{
                    //                         exit和abort都是终止程序执行退出的处理函数，其中exit是正常退出，abort是异常退出，退出时会输出错误信息，然后再调用exit退出。
                    //
                    //                         用户体验来说，exit就像是程序崩溃了，直接退出程序。
                    //                         abort就像是点击了home键，有过渡动画，一般我们在使用的时候会选择abort();
                    //                         abort();
                    
                    exit(0);
                },
            },
            
            @{
                @"index": @6,
                @"title": @"fishhook调用方法",
                @"action": ^{
                    NSLog(@"fish_log");
                },
            },
            
            @{
                @"index": @7,
                @"title": @"objc_msgSend调用方法",
                @"action": ^{
                    //                    id person =
                    //                    (objc_getClass("Person"),
                    //                    sel_registerName("alloc"),
                    //                                 sel_registerName("init"));
                    //                    objc_msobjc_msgSendgSend(person,
                    //                    sel_registerName("logShowTest"));
                },
            },
            
            @{
                @"index": @8,
                @"title": @"网页 - AXWKWebVC",
                @"action": ^{
                    AXWKWebVC *vc = [[AXWKWebVC alloc] init];
                    //                vc.URL = [NSURL
                    //                URLWithString:@"https://www.baidu.com/"]; vc.URL =
                    //                [NSURL URLWithString:@"错误地址"];
                    //                    vc.URL = [NSBundle.mainBundle
                    //                    URLForResource:@"H5.bundle/index.html"
                    //                    withExtension:nil];
                    //                vc.HTML = @"<p style='font-size: 20px'>测试</p>";
                    //                ///第三方 framework 内部的 ,看第三方 NSBundle
                    //                是怎么放置的
                    //                    vc.URL = [NSBundle.mainBundle
                    //                    URLForResource:@"Frameworks/AXiOSKit.framework/AXHTML.bundle/index.html"
                    //                    withExtension:nil];
                    //                /// AXiOSKit 放置方式不一样
                    vc.URL = [NSBundle.ax_HTMLBundle URLForResource:@"index.html"
                                                      withExtension:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
        ].mutableCopy;
    }
    return _dataArray;
}

@end
