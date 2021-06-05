//
//  _00SecondTableViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/9.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_AXThemeCell.h"
#import "_02RootVC.h"

#import "AXUserSwiftImport.h"
#import "AppDelegate.h"
#import "_AXThemeCell.h"
#import "Person.h"
#import "RouterManager.h"
#import "TestObj.h"
#import <AXiOSKit/UIScrollView+AXEmptyDataSet.h>
#import <AXiOSKit/UIViewController+AXNavBarConfig.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <SSZipArchive/SSZipArchive.h>
#import <TABAnimated/TABAnimated.h>
#import <mach/mach.h>
#import "AXDemoUser.h"
#import "AXDemoUser2.h"
@import AssetsLibrary;

static __attribute__((always_inline)) void asm_exit() {
#ifdef __arm64__
    __asm__ ("mov X0, #0\n"
             "mov w16, #1\n"
             "svc #0x80\n"
             
             "mov x1, #0\n"
             "mov sp, x1\n"
             "mov x29, x1\n"
             "mov x30, x1\n"
             "ret");
#endif
}

#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
// 使用新版本
//#ifdef DEBUG
//    static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
//#else
//    static const DDLogLevel ddLogLevel = DDLogLevelWarning;
//#endif

static const DDLogLevel ddLogLevel = DDLogLevelDebug;

#endif



//#import "CocoaDebugTool.h"

#if __has_include(<CocoaDebug/CocoaDebugTool.h>)
#import <CocoaDebug/CocoaDebugTool.h>
#endif

#import "_01ContentViewController.h"

@interface _02RootVC ()

@property (nonatomic, strong) NSMutableArray<AXDataSourceOption *> *dataArray;

@end

@implementation _02RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
    [TABAnimated sharedAnimated].openLog = YES;
    
    self.navigationItem.title = @"主题2";
    [self ax_setNavBarBackgroundImageWithColor:UIColor.cyanColor];
    [self _configItem];
    self.tableView.tableFooterView = UIView.alloc.init;
    [self.tableView registerClass:_AXThemeCell.class forCellReuseIdentifier:@"_AXThemeCell"];
    self.dataArray = nil;
    [self.tableView reloadData];
    /// 多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    // 设置tabAnimated相关属性
    // 可以不进行手动初始化，将使用默认属性
    self.tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[_AXThemeCell class] cellHeight:120];
    self.tableView.tabAnimated.canLoadAgain = YES;
    self.tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
        //        manager.animation(1).down(3).height(12);
        //        manager.animation(2).height(12).reducedWidth(70);
        //        manager.animation(3).down(-5).height(12).radius(0.).reducedWidth(-20);
        
        //        manager.animationN(@"textLabel").right(50).radius(12);
        //            manager.animationN(@"nameLabel").height(12).width(110);
        //            manager.animationN(@"timeButton").down(-5).height(12);
        //        manager.animationN(@"logoImgView").height(40).width(40);
        manager.animationN(@"titleLabel").height(20).right(10);
        manager.animationN(@"detailLabel").height(20).reducedWidth(70);
        //        manager.animationN(@"statusBtn").down(-5).height(12).radius(0.).reducedWidth(-20);
        
        
    };
    
}

-(void)_configItem {
    __weak typeof(self) weakSelf = self;
    NSMutableArray <UIBarButtonItem *> *temp = NSMutableArray.array;
    
    {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.blueColor;
        [btn ax_addTargetBlock:^(UIButton * _Nullable button) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.tableView setEditing:!strongSelf.tableView.isEditing animated:YES];
        }];
        [temp addObject:[UIBarButtonItem ax_itemByButton:btn]];
    }
    
    {
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.blueColor;
        [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [temp addObject:[UIBarButtonItem ax_itemByButton:btn]];
    }
    
    {
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"刷新" forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.blueColor;
        [btn addTarget:self action:@selector(reloadViewAnimated) forControlEvents:UIControlEventTouchUpInside];
        [temp addObject:[UIBarButtonItem ax_itemByButton:btn]];
    }
    self.navigationItem.rightBarButtonItems = temp;
}

- (void)reloadViewAnimated {
    self.tableView.tabAnimated.canLoadAgain = YES;
    [self.tableView tab_startAnimationWithCompletion:^{
        [self afterGetData];
    }];
}
/**
 获取到数据后
 */
- (void)afterGetData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 停止动画,并刷新数据
        [self.tableView tab_endAnimationEaseOut];
    });
}

-(void)deleteAction:(UIButton *)btn {
    
}
// 实现UITableViewDelegate的两个代理

/// iOS13是否允许多指选中

-(BOOL)tableView:(UITableView *)tableView shouldBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

/// iOS13多指选中开始，这里可以做一些UI修改，比如修改导航栏上按钮的文本

-(void)tableView:(UITableView *)tableView didBeginMultipleSelectionInteractionAtIndexPath:(NSIndexPath *)indexPath {
    
    // 最后当用户选择完，要做某些操作的时候，我们可以用 tableView.indexPathsForSelectedRows 获取用户选择的 rows。
    
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
-(CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return UITableViewAutomaticDimension;
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return UITableViewAutomaticDimension;
    return 120;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor groupTableViewBackgroundColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //   header.contentView.backgroundColor=UIColor.whiteColor;
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    header.textLabel.font = [UIFont systemFontOfSize:20];
    [header.textLabel setTextColor:UIColor.redColor];
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _AXThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"_AXThemeCell" forIndexPath:indexPath];
    
    AXDataSourceOption *option = self.dataArray[indexPath.row];
    cell.option = option;
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld-%@",(long)indexPath.row,option.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.isEditing) {
        return;
    }
    AXDataSourceOption *option  = self.dataArray[indexPath.row];
    if (option.action) {
        option.action();
    }
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat contentOffsetY = scrollView.contentOffset.y;
//  CGFloat sectionHeiderHeight = 400; //tabler section 悬停在指定位置处理
//    if (scrollView.contentOffset.y < sectionHeiderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }else {
//        scrollView.contentInset = UIEdgeInsetsMake(sectionHeiderHeight, 0, 0, 0);
//   }
//}



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


//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
//
//    //    NSString *title = @"置顶";
//    //    if (indexPath.section == 0) {
//    //        title = @"取消置顶";
//    //    } else {
//    //        title = @"置顶";
//    //    }
//    //    UIContextualAction *topAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:title handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {            // 这句很重要，退出编辑模式，隐藏左滑菜单
//    //        [tableView setEditing:NO animated:YES];
//    //        completionHandler(true);
//    //    }];
//
//    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        action.title =@"删除1";
//        action.image = [UIImage imageNamed:@"cell_right_delete"];
//        // 这句很重要，退出编辑模式，隐藏左滑菜单
//        [tableView setEditing:NO animated:YES];
//        completionHandler(true);
//    }];
//    deleteAction.title =@"删除1";
//    deleteAction.image = [UIImage imageNamed:@"cell_right_delete"];
//    UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
//    // 禁止侧滑无线拉伸
//    actions.performsFirstActionWithFullSwipe = NO;
//    return actions;
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
        
        NSMutableArray<AXDataSourceOption *> *tempArray = NSMutableArray.array;
        
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"单元测试";
            option.action = ^{
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
                
                // 相同key
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
            };
        }
        
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"UIAlertController 颜色";
            option.action = ^{
                
                NSString *title = @"title";
                NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
                [titleAtt addAttribute:NSForegroundColorAttributeName value: [UIColor redColor] range:NSMakeRange(0, title.length)];
                [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, title.length)];
                
                // 创建图片图片附件
                NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                if (@available(iOS 13.0, *)) {
                    UIImage *img = [UIImage systemImageNamed:@"sun.max.fill"];
                    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    img = [img imageWithTintColor:UIColor.redColor];
                    attach.image = img;
                    
                }
                
                attach.bounds = CGRectMake(0, 0, 50, 50);
                
                NSMutableAttributedString *attachString =   [NSMutableAttributedString attributedStringWithAttachment:attach].mutableCopy;
                
                
                
                //将图片插入到合适的位置
                //                        [titleAtt insertAttributedString:attachString atIndex:0];
                [titleAtt appendAttributedString:attachString];
                
                NSString *msg = @"消息";
                NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:msg];
                [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor orangeColor] range:NSMakeRange(0, msg.length)];
                [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, msg.length)];
                
                NSMutableArray<AXActionItem *> *temp = NSMutableArray.array;
                
                {
                    
                    
                    AXActionItem *item = [AXActionItem.alloc init];
                    item.title = @"A";
                    item.titleColor = [UIColor redColor];
                    if (@available(iOS 13.0, *)) {
                        item.image = [UIImage systemImageNamed:@"a.circle.fill"];
                    }
                    item.imageColor = UIColor.orangeColor;
                    [temp addObject:item];
                }
                {
                    
                    
                    AXActionItem *item = [AXActionItem.alloc init];
                    item.title = @"B";
                    item.titleColor = [UIColor greenColor];
                    
                    if (@available(iOS 13.0, *)) {
                        item.image = [UIImage systemImageNamed:@"b.circle.fill"];
                    }
                    
                    item.style = UIAlertActionStyleCancel;
                    [temp addObject:item];
                }
                
                
                [self ax_showAlertWithStyle:UIAlertControllerStyleActionSheet iPadView:nil title:titleAtt message:messageStr actionItems:temp confirm:^(NSInteger index) {
                    
                } cancel:^{
                    
                }];
            };
        }
        
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"sheet含有图片文字";
            option.action = ^{
                NSMutableArray<AXActionItem *> *temp = NSMutableArray.array;
                
                {
                    
                    
                    AXActionItem *item = [AXActionItem.alloc init];
                    //                        item.title = @"A";
                    item.titleColor = [UIColor redColor];
                    //
                    if (@available(iOS 13.0, *)) {
                        item.image = [UIImage systemImageNamed:@"a.circle.fill"];
                    }
                    [temp addObject:item];
                }
                {
                    
                    
                    AXActionItem *item = [AXActionItem.alloc init];
                    item.title = @"B";
                    item.titleColor = [UIColor greenColor];
                    
                    if (@available(iOS 13.0, *)) {
                        item.image = [UIImage systemImageNamed:@"b.circle.fill"];
                    }
                    [temp addObject:item];
                }
                
                
                [self ax_showSheetByTitle:@"title" message:@"msg" actionItems:temp confirm:^(NSInteger index) {
                    
                } cancel:^{
                    
                }];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"数组nil";
            option.action = ^{
                
                [self ax_showAlertByTitle:@"是否调用"
                                  confirm:^{
//                    Person *per = [[Person alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
                    NSMutableArray *arr = NSMutableArray.array;
                    [arr addObject:nil];
                    NSLog(@"array=%@",arr);
#pragma clang diagnostic pop
                    
                    
                }];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"对象未实现方法,内部处理";
            option.action = ^{
                
                [self ax_showAlertByTitle:@"是否调用"
                                  confirm:^{
                    Person *per = [[Person alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                    [per performSelector:@selector(test:)];
#pragma clang diagnostic pop
                    
                    
                }];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"对象未实现方法,AvoidCrash处理";
            option.action = ^{
                
                [self ax_showAlertByTitle:@"是否调用"
                                  confirm:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                    [self performSelector:@selector(test2:)];
#pragma clang diagnostic pop
                    
                    
                }];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"路由 - RouterManager";
            option.action = ^{
                [RouterManager
                 openURL:routeNameWith01ViewController
                 withUserInfo:@{ @"navigationController": self.navigationController }
                 completion:^(id _Nonnull result) {
                }];
            };
        }
        
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"退出-方法1";
            option.action = ^{
                AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIWindow *window = app.window;
                [UIView animateWithDuration:0.4f animations:^{
                    CGAffineTransform curent =  window.transform;
                    CGAffineTransform scale = CGAffineTransformScale(curent, 0.1,0.1);
                    [window setTransform:scale];
                } completion:^(BOOL finished) {
                    exit(0);
                }];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"退出方式-asm_exit,真机有效";
            option.action = ^{
                asm_exit();
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"退出方式3";
            option.action = ^{
                if([[UIApplication sharedApplication] respondsToSelector:@selector(terminateWithSuccess)]) {
                    [[UIApplication sharedApplication] performSelector:@selector(terminateWithSuccess)];
                }
            };
        }
        
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"fishhook调用方法";
            option.action = ^{
                NSLog(@"fish_log");
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"objc_msgSend调用方法";
            option.action = ^{
                //                    id person =
                //                    (objc_getClass("Person"),
                //                    sel_registerName("alloc"),
                //                                 sel_registerName("init"));
                //                    objc_msobjc_msgSendgSend(person,
                //                    sel_registerName("logShowTest"));
            };
        } {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"NSMutableDictionary,nil";
            option.action = ^{
                NSMutableDictionary *dict=NSMutableDictionary.dictionary;
                [dict setObject:nil forKeyedSubscript:@"name"];
                NSLog(@"dict nil = %@",dict);
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"NSMutableDictionary,forKeyedSubscript";
            option.action = ^{
                NSMutableDictionary *dict=NSMutableDictionary.dictionary;
                [dict setObject:@"jim" forKeyedSubscript:@"name"];
                NSLog(@"dict = %@",dict);
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"NSMutableArray,atIndexedSubscript";
            option.detail = @"iOS11之前：arr@[]  调用的是[__NSArrayI objectAtIndexed]\n\
            iOS11之后：arr@[]  调用的是[__NSArrayI objectAtIndexedSubscript]";
            option.action = ^{
                /// iOS11之前：arr@[]  调用的是[__NSArrayI objectAtIndexed]
                /// iOS11之后：arr@[]  调用的是[__NSArrayI objectAtIndexedSubscript]
                NSMutableArray *array = NSMutableArray.array;
                [array setObject:@"A" atIndexedSubscript:2];
                NSLog(@"array = %@",array);
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"LLDB";
            option.detail = @"断点 expr 命令";
            option.action = ^{
                NSString *name = @"123";
                /// 断点 修改 值 expr name = @"jim";
                NSLog(@"name = %@",name);
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"oc调用swift";
            option.action = ^{
                DogSwift *dog =  [DogSwift.alloc init];
                [dog show];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"解压";
            option.action = ^{
                NSString *path = [NSString.ax_documentPath stringByAppendingPathComponent:@"sudian.zip"];
                NSString *targetPath = NSString.ax_documentPath;
                BOOL succ = [SSZipArchive unzipFileAtPath:path toDestination:targetPath];
                NSLog(@"解压 = %d",succ);
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"CocoaLumberjack日志";
            option.action = ^{
#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
                // Uses os_log
                //[DDLog addLogger:[DDASLLogger sharedInstance]]; //iOS10之前
                [DDLog addLogger:DDOSLogger.sharedInstance]; //iOS10之后
                [DDLog addLogger:DDTTYLogger.sharedInstance];
                [DDLog addLogger:DDTTYLogger.sharedInstance withLevel:ddLogLevel];
                
                DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
                fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
                fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
                [DDLog addLogger:fileLogger];
                
                DDLogVerbose(@"Verbose");
                DDLogDebug(@"Debug");
                DDLogInfo(@"Info");
                DDLogWarn(@"Warn");
                DDLogError(@"Error");
#endif
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"CocoaDebugTool";
            option.action = ^{
#if __has_include(<CocoaDebug/CocoaDebugTool.h>)
                
                [CocoaDebugTool logWithString:@"Custom Messages...."];
                [CocoaDebugTool logWithString:@"Custom Messages...,有颜色" color:[UIColor redColor]];
                
#endif
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"FileBrowser 文件浏览器";
            option.action = ^{
                
                //                    NSURL *URL = NULL;
                FileBrowser *vc = [FileBrowser.alloc init];
                
                [self ax_showVC:vc];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"pushViewControllerPresentStyle";
            option.action = ^{
                
                _01ContentViewController *vc = [_01ContentViewController.alloc init];
                [self.navigationController ax_pushViewControllerPresentStyle:vc animated:YES];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"presentViewControllerPushStyle";
            option.action = ^{
                
                _01ContentViewController *vc = [_01ContentViewController.alloc init];
                [self ax_presentViewControllerPushStyle:vc animated:YES completion:nil];
            };
        }
        {
            AXDataSourceOption *option = AXDataSourceOption.alloc.init;
            [tempArray addObject:option];
            option.title = @"指定系统版本";
            option.action = ^{
                
                NSString *systemVersion = UIDevice.currentDevice.systemVersion;
                NSLog(@"systemVersion=%@",systemVersion);
                NSLog(@"systemVersion.doubleValue=%lf",systemVersion.doubleValue);
                NSLog(@"systemVersion.Replacing=%@",[systemVersion stringByReplacingOccurrencesOfString:@"." withString:@""]);
                
                if (@available(iOS 13.0, *)) {
                    NSLog(@"@available(iOS 13.0, *)");
                }
                /**
                 不过这个头文件里定义的最大的宏是NSFoundationVersionNumber_iOS_9_x_Max。不过NSFoundationVersionNumber在iOS 10.3.1上和iOS 11上输出的值分别为1349.55和1444.12，看来苹果只是没有提供对应的宏，但是却改变了NSFoundationVersionNumber的值。
                 */
                NSLog(@"NSFoundationVersionNumber=%lf",NSFoundationVersionNumber);
#if defined(__IPHONE_13_0) || defined(__IPHONE_13_1)
                NSLog(@"__IPHONE_13_0=%d",__IPHONE_13_0);
                NSLog(@"__IPHONE_13_1=%d",__IPHONE_13_1);
#endif
                
#if defined(__IPHONE_17_0)
                NSLog(@"__IPHONE_17_0=%d",__IPHONE_17_0);
#endif
                
            };
            
            {
                AXDataSourceOption *option = AXDataSourceOption.alloc.init;
                [tempArray addObject:option];
                option.title = @"单例能继承";
                option.action = ^{
                    [AXDemoUser testSub];
                    [AXDemoUser2 testSub];
                    NSLog(@"AXDemoUser=%p",AXDemoUser.sharedUser);
                    NSLog(@"AXDemoUser2=%p",AXDemoUser2.sharedUser);
                    NSLog(@"AXDemoUser2=%p",AXDemoUser2.alloc.init);
                };
            }
    
        }
        
        
        _dataArray = tempArray.mutableCopy;
    }
    return _dataArray;
}
- (BOOL)shouldAutorotate {
    
    return NO;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}



@end
