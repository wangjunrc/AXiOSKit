//
//  TableViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "AFNViewController.h"
#import "ChatViewController.h"
#import "CopyActivity.h"
#import "MyActivity.h"
#import "RunLoopViewController.h"
#import "TestObj.h"
#import "TextFViewController.h"
#import "VideoViewController.h"
#import "WCDBViewController.h"
#import "_00TableViewCell.h"
#import "_00TableViewController.h"
#import "_01ViewController.h"
#import "_13WebpViewController.h"
#import "_14TFViewController.h"
#import "_15UIMenuController.h"
#import "_16KeyChainViewController.h"
#import "RouterManager.h"
#import "_17OtherShareViewController.h"
#import "_18MGSwipeTableVC.h"
#import "_19ScrollContentViewController.h"
#import "_01ContentViewController.h"
#import "_20iOS14ViewController.h"
#import "_21KVOViewController.h"
#import "_22ReactiveObjCViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "DLCompanyNewsViewController.h"

@import AssetsLibrary;

typedef void (^CollectionBlock)(void);

@interface _00TableViewController () {
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

@implementation _00TableViewController

//- (void)injected {
//    NSLog(@"I've been injected: %@", self);
//    [self viewDidLoad];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题";
    [self.tableView ax_registerNibCellClass:_00TableViewCell.class];

    //    NSLog(@"IS_PRODUCATION = %@ SERVER_HOST = %@", IS_PRODUCATION ? @"生产环境" : @"开发环境", SERVER_HOST);

    {

        NSLog(@"isEmoji = %d", [@"😝" isContainsEmoji]);
        NSLog(@"isEmoji = %d", [@"2" isContainsEmoji]);
    }
    {
        /// <正则表达式>
        NSString *regEx = @"12";
        ///<待匹配的字符串>
        NSString *string = @"1234567";

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
        BOOL matched = [predicate evaluateWithObject:string];
        NSLog(@"是否匹配 = %d", matched);
    }

    {
        NSString *regEx = @"12";
        NSString *string = @"123123";
        NSError *error;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
        if (error) {
            NSLog(@"error = %@", error);
        }

        NSUInteger number = [regularExpression numberOfMatchesInString:string options:kNilOptions range:NSMakeRange(0, string.length)];
        NSLog(@"匹配的个数 = %lu", (unsigned long) number);

        BOOL matched = (number != 0);
        NSLog(@"是否匹配 = %d", matched);


    }

    {

        NSString *regEx = @"12";
        NSString *string = @"123123";
        NSError *error;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
        if (error) {
            NSLog(@"error = %@", error);
        }

        NSTextCheckingResult *firstMatch = [regularExpression firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        if (firstMatch) {
            // NSTextCheckingResult 的 range 属性即匹配的字符串的位置
            NSString *matchedString = [string substringWithRange:firstMatch.range];
            NSLog(@"匹配的字符串 = %@", matchedString);
        } else {
            NSLog(@"匹配的字符串 = 错误");
        }

    }

    {
        NSString *regEx = @"<正则表达式>";
        NSString *string = @"<待匹配的字符串>";
        NSError *error;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
        if (error) {
            NSLog(@"error = %@", error);
        }

        NSArray *matchArray = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        for (NSTextCheckingResult *match in matchArray) {
            NSString *matchedString = [string substringWithRange:match.range];
            NSLog(@"匹配的字符串 = %@", matchedString);
        }

    }
    
    NSLog(@"identifierForVender = %@",[UIDevice currentDevice].identifierForVendor.UUIDString);
    
    
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)
                        fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple *tuple) {
            NSLog(@"didSelectRowAtIndexPath = %@", tuple.first);
            NSLog(@"%@", tuple.second);
        }];

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _00TableViewCell *cell = [tableView ax_dequeueReusableCellWithIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSDictionary *dict = self.dataArray[indexPath.row];

    cell.indexLabel.text = [NSString stringWithFormat:@"%@", dict[@"index"]];
    cell.nameLabel.text = dict[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.row];

    void (^didSelectRowAtIndexPath)(void) = dict[@"action"];

    didSelectRowAtIndexPath();
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark -  数据源

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[

                @{
                        @"index": @1,
                        @"title": @"暗黑主题-ViewController",
                        @"action": ^{
                    _01ViewController *vc = [[_01ViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },
                @{
                        @"index": @1,
                        @"title": @"ContentViewController",
                        @"action": ^{
                    _01ContentViewController *vc = [[_01ContentViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @2,
                        @"title": @"聊天-ChatViewController",
                        @"action": ^{
                    ChatViewController *vc = [[ChatViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @3,
                        @"title": @"隐藏导航栏",
                        @"action": ^{
                    _01ViewController *vc = [[_01ViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    vc.ax_shouldNavigationBarHidden = YES;
                },
                },

                @{
                        @"index": @4,
                        @"title": @"NSRunLoop模式",
                        @"action": ^{
                    RunLoopViewController *vc = [[RunLoopViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @5,
                        @"title": @"对象未实现方法",
                        @"action": ^{
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
                        @"index": @6,
                        @"title": @"WCDB",
                        @"action": ^{
                    WCDBViewController *vc = [[WCDBViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },
                @{
                        @"index": @7,
                        @"title": @"视频",
                        @"action": ^{
                    VideoViewController *vc = [[VideoViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @8,
                        @"title": @"网页",
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

                @{
                        @"index": @9,
                        @"title": @"AFN",
                        @"action": ^{
                    //          _09AFNViewController *vc = [[_09AFNViewController alloc] init];
                    //          [self.navigationController pushViewController:vc animated:YES];

                    [RouterManager openURL:routeNameOf withUserInfo:@{@"navigationVC": self.navigationController} completion:^(id _Nonnull result) {

                    }];
                },
                },

                @{
                        @"index": @10,
                        @"title": @"多行textview",
                        @"action": ^{
                    TextFViewController *vc = [[TextFViewController alloc] init];
                    [self ax_showVC:vc];
                },
                },

                @{
                        @"index": @11,
                        @"title": @"objc_msgSend调用方法",
                        @"action": ^{
//                    id person =
//                    objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"),
//                                 sel_registerName("init"));
//                    objc_msgSend(person, sel_registerName("logShowTest"));
                },
                },

                @{
                        @"index": @12,
                        @"title": @"fishhook调用方法",
                        @"action": ^{
                    NSLog(@"fish_log");
                },
                },
                @{
                        @"index": @13,
                        @"title": @"webp/GIF",
                        @"action": ^{
                    _13WebpViewController *vc = [[_13WebpViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @14,
                        @"title": @"TextFeild",
                        @"action": ^{
                    _14TFViewController *vc = [[_14TFViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @15,
                        @"title": @"UIMenuController",
                        @"action": ^{
                    _15UIMenuController *vc = [[_15UIMenuController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @16,
                        @"title": @"系统分享",
                        @"action": ^{
                    MyActivity *item1 = [[MyActivity alloc] init];
                    CopyActivity *item2 = [[CopyActivity alloc] init];

                    // 1、设置分享的内容，并将内容添加到数组中
                    NSArray *activityItemsArray = @[@"A"];
                    NSArray *activityArray = @[item1, item2];

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
                        @"index": @16,
                        @"title": @"KeyChain",
                        @"action": ^{
                    _16KeyChainViewController *vc = [[_16KeyChainViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @17,
                        @"title": @"微信分享",
                        @"action": ^{
                    _17OtherShareViewController *vc = [[_17OtherShareViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },

                @{
                        @"index": @18,
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
                        @"index": @18,
                        @"title": @"SwipeTableVC",
                        @"action": ^{
                    _18MGSwipeTableVC *vc = [[_18MGSwipeTableVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },
                @{
                        @"index": @19,
                        @"title": @"Scroll自适应内容",
                        @"action": ^{
                    _19ScrollContentViewController *vc = [[_19ScrollContentViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },
                @{
                        @"index": @20,
                        @"title": @"打开相册",
                        @"action": ^{

                    [self ax_showCameraWithEditing:NO block:^(UIImage *originalImage, UIImage *editedImage) {

                    }];

//                    // 以下 API 仅为 iOS14 only
//                          PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
//                          configuration.filter = [PHPickerFilter videosFilter]; // 可配置查询用户相册中文件的类型，支持三种
//                        configuration.selectionLimit = 0; // 默认为1，为0时表示可多选。
//                      
//                          PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
//                          picker.delegate = self;
//                          // picker vc，在选完图片后需要在回调中手动 dismiss
//                        [self presentViewController:picker animated:YES completion:^{
//                      
//                          }];


                },
                },

                @{
                        @"index": @20,
                        @"title": @"iOS适配",
                        @"action": ^{
                    _20iOS14ViewController *vc = [[_20iOS14ViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },
                @{
                        @"index": @21,
                        @"title": @"KVO",
                        @"action": ^{
                    _21KVOViewController *vc = [[_21KVOViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },
                @{
                        @"index": @22,
                        @"title": @"ReactiveObjCViewController",
                        @"action": ^{
                            _22ReactiveObjCViewController *vc = [[_22ReactiveObjCViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                },
                
                @{
                        @"index": @22,
                        @"title": @"DLCompanyNewsViewController",
                        @"action": ^{
                            DLCompanyNewsViewController *vc = [[DLCompanyNewsViewController alloc] init];
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

@end
