//
//  TableViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "AFNViewController.h"
#import "AView.h"
#import "ChatViewController.h"
#import "CopyActivity.h"
#import "MyActivity.h"
#import "RunLoopViewController.h"
#import "TestObj.h"
#import "TextFViewController.h"
#import "UIImage+AXKit.h"
#import "VideoViewController.h"
#import "WCDBViewController.h"
#import "_00TableViewCell.h"
#import "_00TableViewController.h"
#import "_01ViewController.h"
#import "_09AFNViewController.h"
#import "_13WebpViewController.h"
#import "_14TFViewController.h"
#import "_15UIMenuController.h"
#import "_16KeyChainViewController.h"
#import "fishhook-master/fishhook.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/UIViewController+AXKit.h>
#import <objc/message.h>
#import <objc/runtime.h>
@import AssetsLibrary;

typedef void (^CollectionBlock)(void);

@interface TableViewController () {
  NSInteger _count;
}

@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) NSString *strongStr;

@property(nonatomic, copy) NSString *copyedStr;

@property(nonatomic, strong) NSMutableString *strongMStr;

@property(nonatomic, copy) NSMutableString *copyedMStr;

@property(atomic, copy) NSString *name;

@property(atomic, assign) NSInteger count;

@end

@implementation TableViewController

//- (void)injected {
//    NSLog(@"I've been injected: %@", self);
//    [self viewDidLoad];
//}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"拦截====2 %@", self);
  self.title = @"主题";
  [self.tableView ax_registerNibCellClass:_00TableViewCell.class];
}

- (void)test {
  NSLog(@"5");
}

///保存系统函数地址
static void (*replacedLog)(NSString *format, ...);
void mySLog(NSString *format, ...) {
  replacedLog(@"%@", [format stringByAppendingString:@"被HOOK了"]);
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  _00TableViewCell *cell =
      [tableView ax_dequeueReusableCellWithIndexPath:indexPath];

  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  NSDictionary *dict = self.dataArray[indexPath.row];

  cell.indexLabel.text = [NSString stringWithFormat:@"%@", dict[@"index"]];
  cell.nameLabel.text = dict[@"title"];
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *dict = self.dataArray[indexPath.row];

  void (^didSelectRowAtIndexPath)(void) = dict[@"action"];

  didSelectRowAtIndexPath();
}

- (BOOL)tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"删除";
}

#pragma mark -  数据源
- (NSArray *)dataArray {
  if (!_dataArray) {
    _dataArray = @[

      @{
        @"index" : @1,
        @"title" : @"暗黑主题-ViewController",
        @"action" : ^{
          _01ViewController *vc = [[_01ViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },
      @{
        @"index" : @2,
        @"title" : @"聊天-ChatViewController",
        @"action" : ^{
          ChatViewController *vc = [[ChatViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },

      @{
        @"index" : @3,
        @"title" : @"隐藏导航栏",
        @"action" : ^{
          _01ViewController *vc = [[_01ViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
          vc.ax_shouldNavigationBarHidden = YES;
        },
      },

      @{
        @"index" : @4,
        @"title" : @"NSRunLoop模式",
        @"action" : ^{
          RunLoopViewController *vc = [[RunLoopViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },

      @{
        @"index" : @5,
        @"title" : @"对象未实现方法",
        @"action" : ^{
          [self
              ax_showAlertByTitle:@"是否调用"
                          confirm:^{
                            UIButton *testButton = [[UIButton alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                            [testButton performSelector:@selector(someMethod:)];
#pragma clang diagnostic pop
                          }];
        },
      },
      @{
        @"index" : @6,
        @"title" : @"WCDB",
        @"action" : ^{
          WCDBViewController *vc = [[WCDBViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },
      @{
        @"index" : @7,
        @"title" : @"视频",
        @"action" : ^{
          VideoViewController *vc = [[VideoViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },

      @{
        @"index" : @8,
        @"title" : @"网页",
        @"action" : ^{
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

      @{
        @"index" : @9,
        @"title" : @"AFN",
        @"action" : ^{
          _09AFNViewController *vc = [[_09AFNViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },

      @{
        @"index" : @10,
        @"title" : @"多行textview",
        @"action" : ^{
          TextFViewController *vc = [[TextFViewController alloc] init];
          [self ax_showVC:vc];
        },
      },

      @{
        @"index" : @11,
        @"title" : @"objc_msgSend调用方法",
        @"action" : ^{
          id person =
              objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"),
                           sel_registerName("init"));
          objc_msgSend(person, sel_registerName("logShowTest"));
        },
      },

      @{
        @"index" : @12,
        @"title" : @"fishhook调用方法",
        @"action" : ^{
          NSLog(@"fish_log");
        },
      },
      @{
        @"index" : @13,
        @"title" : @"webp/GIF",
        @"action" : ^{
          _13WebpViewController *vc = [[_13WebpViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },

      @{
        @"index" : @14,
        @"title" : @"TextFeild",
        @"action" : ^{
          _14TFViewController *vc = [[_14TFViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },

      @{
        @"index" : @15,
        @"title" : @"UIMenuController",
        @"action" : ^{
          _15UIMenuController *vc = [[_15UIMenuController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
        },
      },
      
      @{
        @"index" : @16,
        @"title" : @"系统分享",
        @"action" : ^{
          MyActivity *item1 = [[MyActivity alloc] init];
          CopyActivity *item2 = [[CopyActivity alloc] init];

          // 1、设置分享的内容，并将内容添加到数组中
          NSArray *activityItemsArray = @[ @"A" ];
          NSArray *activityArray = @[ item1, item2 ];

          // 2、初始化控制器，添加分享内容至控制器
          UIActivityViewController *activityVC =
              [[UIActivityViewController alloc]
                  initWithActivityItems:activityItemsArray
                  applicationActivities:activityArray];
          if (@available(iOS 13.0, *)) {
            activityVC.modalInPresentation = YES;
          } else {
            // Fallback on earlier versions
          }

          // ios8.0 之后用此方法回调
          UIActivityViewControllerCompletionWithItemsHandler itemsBlock =
              ^(UIActivityType __nullable activityType, BOOL completed,
                NSArray *__nullable returnedItems,
                NSError *__nullable activityError) {
                NSLog(@"activityType == %@", activityType);
                if (completed == YES) {
                  NSLog(@"completed");
                } else {
                  NSLog(@"cancel");
                }
              };
          activityVC.completionWithItemsHandler = itemsBlock;

          //不出现在活动项目
          activityVC.excludedActivityTypes = @[
            UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
            UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
            @"com.ax.kit"
          ];

          // 4、调用控制器
          [self presentViewController:activityVC animated:YES completion:nil];
        },
      },
      
      @{
             @"index" : @16,
             @"title" : @"KeyChain",
             @"action" : ^{
               _16KeyChainViewController *vc = [[_16KeyChainViewController alloc] init];
               [self.navigationController pushViewController:vc animated:YES];
             },
           },
      

    ];
  }
  return _dataArray;
}

- (void)testPerson {
}

- (void)testObj:(TestObj *)obj {
  NSAssert([obj respondsToSelector:@selector(log)], @"对的不对");

  NSLog(@">>>> %d == %d", [obj.class instancesRespondToSelector:@selector(log)],
        [obj.class instancesRespondToSelector:@selector(log2)]);

  NSLog(@"=== %d", [obj respondsToSelector:@selector(log)]);

  if ([obj.class instancesRespondToSelector:@selector(log)]) {
    [obj log];
  } else {
    NSLog(@"未z实现");
  }
}

@end
