//
//  TableViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "ChatViewController.h"
#import "UIViewController+AXKit.h"
#import "TestObj.h"
#import "RunLoopViewController.h"
#import "AView.h"
#import "WCDBViewController.h"
#import "VideoViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "AFNViewController.h"
#import "TextFViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "fishhook-master/fishhook.h"

typedef void (^CollectionBlock)(void);

@interface TableViewController (){
    NSInteger _count;
}

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic, strong) NSString *strongStr;

@property(nonatomic, copy) NSString *copyedStr;


@property(nonatomic, strong) NSMutableString *strongMStr;

@property(nonatomic, copy) NSMutableString *copyedMStr;

@property(atomic, copy) NSString *name;

@property(atomic, assign) NSInteger count;

@end

@implementation TableViewController

- (void)injected{
    NSLog(@"I've been injected: %@", self);
    [self viewDidLoad];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellid"];
    
    
    self.name = @"-1";
    self.count = 0;
    
  
    struct rebinding nsLog;
    nsLog.name = "NSLog";
    nsLog.replacement = mySLog;
    nsLog.replaced = (void *)&replacedLog;
    struct rebinding rebinds[1] = {nsLog};
    rebind_symbols(rebinds, 1);
    
}

///保存系统函数地址
static void (* replacedLog)(NSString *format, ...);
void mySLog(NSString *format, ...) {
    replacedLog(@"%@",[format stringByAppendingString:@"被HOOK了"]);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    cell.textLabel.text = dict[@"title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    void (^didSelectRowAtIndexPath)(void) = dict[@"action"];
    
    didSelectRowAtIndexPath();
    
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            
            @{
                @"title":@"暗黑主题-ViewController",
                @"action":  ^{
                    ViewController *vc = [[ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            @{
                @"title":@"聊天-ChatViewController",
                @"action":  ^{
                    ChatViewController *vc = [[ChatViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            
            @{
                @"title":@"隐藏导航栏",
                @"action":  ^{
                    ViewController *vc = [[ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    vc.ax_shouldNavigationBarHidden = YES;
                },
            },
            
            @{
                @"title":@"NSRunLoop模式",
                @"action":  ^{
                    RunLoopViewController *vc = [[RunLoopViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            
            
            @{
                @"title":@"对象未实现方法",
                @"action":  ^{
                    [self ax_showAlertByTitle:@"是否调用" confirm:^{
                        UIButton *testButton = [[UIButton alloc] init];
                        [testButton performSelector:@selector(someMethod:)];
                    }];
                },
            },
            @{
                @"title":@"WCDB",
                @"action":  ^{
                    
                    WCDBViewController *vc = [[WCDBViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                
                
            },
            @{
                @"title":@"视频",
                @"action":  ^{
                    
                    VideoViewController *vc = [[VideoViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            
            @{
                @"title":@"网页",
                @"action":  ^{
                    
                    AXWKWebVC *vc = [[AXWKWebVC alloc]init];
                    vc.loadURLString = @"http://127.0.0.1:8091";
                    [self.navigationController pushViewController:vc animated:YES];
                },
                
                
            },
            
            @{
                @"title":@"AFN",
                @"action":  ^{
                    
                    AFNViewController *vc = [[AFNViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                
                
            },
            
            @{
                @"title":@"多行textview",
                @"action":  ^{
                    
                    TextFViewController *vc = [[TextFViewController alloc]init];
                    [self ax_showVC:vc];
                },
                
                
            },
            
            
            @{
                @"title":@"objc_msgSend调用方法",
                @"action":  ^{
                    
                    id person   = objc_msgSend(objc_getClass("Person"),sel_registerName("alloc"),sel_registerName("init"));
                    objc_msgSend(person, sel_registerName("logShowTest"));
                    
                    
                },
                
                
            },
            
            
            @{
                          @"title":@"fishhook调用方法",
                          @"action":  ^{
                             
                              NSLog(@"fish_log");
                              
                              
                          },
                          
                          
                      },
            
            
            
            
        ];
    }
    return _dataArray;
}

-(void)testPerson{
    
    
}


-(void)testObj:(TestObj *)obj{
    NSAssert([obj respondsToSelector:@selector(log)], @"对的不对");
    
    NSLog(@">>>> %d == %d",[obj.class instancesRespondToSelector:@selector(log)],[obj.class instancesRespondToSelector:@selector(log2)]);
    
    NSLog(@"=== %d",[obj respondsToSelector:@selector(log)]);
    
    if ([obj.class instancesRespondToSelector:@selector(log)]) {
        
        [obj log];
    }else{
        NSLog(@"未z实现");
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(editingStyle == UITableViewCellEditingStyleDelete){
//
//        NSIndexSet *sectionIndex = [NSIndexSet indexSetWithIndex:indexPath.section];
//        [tableView deleteSections:sectionIndex withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 这里的标题我使用的 4 个空格进行占位
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"    " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 点击删除按钮需要执行的方法
        
        [tableView setEditing:NO animated:YES];
    }];
    
    // 修改背景颜色
    action.backgroundColor = UIColor.redColor;
    
    return @[action];
}
//
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 在 iOS11 以下系统,因为方法线程问题,需要放到主线程执行, 不然没有效果
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setupSlideBtnWithEditingIndexPath:indexPath];
//    });
//}
//
////MARK: 设置左滑按钮的样式
//- (void)setupSlideBtnWithEditingIndexPath:(NSIndexPath *)editingIndexPath {
//
//    // 判断系统是否是 iOS13 及以上版本
//    if (@available(iOS 13.0, *)) {
//        for (UIView *subView in self.tableView.subviews) {
//            if ([subView isKindOfClass:NSClassFromString(@"_UITableViewCellSwipeContainerView")] && [subView.subviews count] >= 1) {
//                // 修改图片
//                UIView *remarkContentView = subView.subviews.firstObject;
//                [self setupRowActionView:remarkContentView];
//            }
//        }
//        return;
//    }
//
//    // 判断系统是否是 iOS11 及以上版本
//    if (@available(iOS 11.0, *)) {
//        for (UIView *subView in self.tableView.subviews) {
//            if ([subView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subView.subviews count] >= 1) {
//                // 修改图片
//                UIView *remarkContentView = subView;
//                [self setupRowActionView:remarkContentView];
//            }
//        }
//        return;
//    }
//
//    // iOS11 以下的版本
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:editingIndexPath];
//    for (UIView *subView in cell.subviews) {
//        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subView.subviews count] >= 1) {
//            // 修改图片
//            UIView *remarkContentView = subView;
//            [self setupRowActionView:remarkContentView];
//        }
//    }
//}
//
//- (void)setupRowActionView:(UIView *)rowActionView {
//    // 切割圆角
//    rowActionView.layer.cornerRadius = 20;
//    // 改变父 View 的frame，这句话是因为我在 contentView 里加了另一个 View，为了使划出的按钮能与其达到同一高度
//    CGRect frame = rowActionView.frame;
//    frame.origin.y += 7;
//    frame.size.height -= 13;
//    rowActionView.frame = frame;
//    // 拿到按钮,设置图片
//    UIButton *button = rowActionView.subviews.firstObject;
////    [button setImage:kImageName(@"delete_col") forState:UIControlStateNormal];
//    [button setTitle:@"按钮" forState:UIControlStateNormal];
//}


@end
