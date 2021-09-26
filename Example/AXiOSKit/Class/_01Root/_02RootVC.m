//
//  _02RootVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/9/24.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_02RootVC.h"
#import "AXDemoUser.h"
#import "AXDemoUser2.h"
#import "AXUserSwiftImport.h"
#import "AppDelegate.h"
#import "TestObj.h"
#import "_02CollectionViewCell.h"
#import "_AXCellItem.h"
#import "_AXTestPerson.h"
#import "_AXTestRouterManager.h"
#import "_AXThemeCell.h"
#import "_AXThemeCell.h"
#import "_Person.h"
#import <AXiOSKit/UIScrollView+AXEmptyDataSet.h>
#import <AXiOSKit/UIViewController+AXNavBarConfig.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <MJExtension/MJExtension.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <SSZipArchive/SSZipArchive.h>
#import <TABAnimated/TABAnimated.h>
#import <mach/mach.h>
#import <AXiOSKit/UIView+AXHUD.h>

@import AssetsLibrary;
@import CocoaDebug;

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

@interface _02RootVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<_AXCellItem *> *dataArray;

@end

@interface _02Layout : UICollectionViewFlowLayout


@end

@implementation _02Layout

- (CGSize)fixedCollectionCellSize:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    return CGSizeMake(round(scale * size.width) / scale, round(scale * size.height) / scale);
}
- (void)invalidateLayout{
    [super invalidateLayout];
    
    self.sectionInset = UIEdgeInsetsZero;//分区间的内边距
    //minimumLineSpacing = 0;这个是水平的间距 minimumInteritemSpacing
    self.minimumInteritemSpacing = 0;//列间距
    self.minimumLineSpacing = 10;//行间距
    
    //    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width/3.0, 50); //item尺寸
    self.scrollDirection =UICollectionViewScrollDirectionVertical;//滚动方向
    //    self.scrollDirection =UICollectionViewScrollDirectionHorizontal;//滚动方向
    /// ios10 api
    //    self.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    
    
    
    //    self.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    ////    estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    ///
    //    self.estimatedItemSize = CGSizeMake(self.collectionView.bounds.size.width/3.0, 50); //item尺寸
    
    
    
    self.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    self.itemSize = UICollectionViewFlowLayoutAutomaticSize;
}


@end
@implementation _02RootVC
static NSString *cellID = @"cellID";


- (CGSize)fixedCollectionCellSize:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    return CGSizeMake(round(scale * size.width) / scale, round(scale * size.height) / scale);
}

//只要itemSize的width的小数点后只有1位且最小为5也就是满足1px=0.5pt这个等式。
- (CGFloat )fixSlitWith:(CGRect)rect colCount:(CGFloat)colCount space:(CGFloat)space {
    //    space = 0;
    CGFloat totalSpace = (colCount - 1) * space;//总共留出的距离
    CGFloat itemWidth = (rect.size.width - totalSpace) / colCount;// 按照真实屏幕算出的cell宽度 （iPhone6 375*667）93.75
    CGFloat fixValue = 1 / [UIScreen mainScreen].scale; //(6为1px=0.5pt,6Plus为3px=1pt)1个点有两个像素
    CGFloat realItemWidth = floor(itemWidth) + fixValue;//取整加fixValue  floor:如果参数是小数，则求最大的整数但不大于本身.
    if (realItemWidth < itemWidth) {// 有可能原cell宽度小数点后一位大于0.5
        realItemWidth += fixValue;
    }
    
    CGFloat realWidth = colCount * realItemWidth + totalSpace;//算出屏幕等分后满足`1px=0.5pt`实际的宽度
    CGFloat pointX = (realWidth - rect.size.width) / 2; //偏移距离
    rect.origin.x = -pointX;//向左偏移
    rect.size.width = realWidth;
    
    return realItemWidth;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.collectionView registerClass:_02CollectionViewCell.class forCellWithReuseIdentifier:cellID];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat margin  = self.view.bounds.size.width -[self fixSlitWith:self.view.bounds colCount:3 space:0]*3;
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, margin, 0,0));
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _02CollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    _AXCellItem *item = self.dataArray[indexPath.item];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld-%@",(long)indexPath.row,item.title];
    cell.detaLabel.text = item.detail;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _AXCellItem *option  = self.dataArray[indexPath.item];
    if (option.action) {
        option.action();
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _02Layout *layout = _02Layout.alloc.init;
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}

#pragma mark -  数据源

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [self doData].mutableCopy;
    }
    return _dataArray;
}

-(NSMutableArray *)doData {
    
    NSMutableArray<_AXCellItem *> *tempArray = NSMutableArray.array;
    
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
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
        
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"UIAlertController单个";
        option.action = ^{
            
            [self ax_showAlertByTitle:@"title123" message:@"msg" confirm:^{
                
            }];
        };
        
    }
    
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
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
        _AXCellItem *option = _AXCellItem.alloc.init;
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
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"数组nil";
        option.action = ^{
            
            [self ax_showAlertByTitle:@"是否调用"
                              message:@"数组nil"
                              confirm:^{
                //                    Person *per = [[Person alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
                NSMutableArray *arr = NSMutableArray.array;
                [arr addObject:nil];
                NSLog(@"array=%@",arr);
#pragma clang diagnostic pop
                
                
            } cancel:^{
                
            }];
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"对象未实现方法,内部处理";
        option.action = ^{
            
            [self ax_showAlertByTitle:@"是否调用"
                              message:@"对象未实现方法"
                              confirm:^{
                _AXTestPerson *per = [[_AXTestPerson alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                [per performSelector:@selector(test:)];
#pragma clang diagnostic pop
                
                
            } cancel:^{
                
            }];
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"对象未实现方法,AvoidCrash处理";
        option.action = ^{
            
            [self ax_showAlertByTitle:@"是否调用"
                              message:@"对象未实现方法"
                              confirm:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                [self performSelector:@selector(test2:)];
#pragma clang diagnostic pop
                
                
            } cancel:^{
                
            }];
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"路由 - RouterManager";
        option.action = ^{
            [_AXTestRouterManager
             openURL:routeNameWith01ViewController
             withUserInfo:@{ @"navigationController": self.navigationController }
             completion:^(id _Nonnull result) {
            }];
        };
    }
    
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"退出-方法1";
        option.action = ^{
            
            [self ax_showAlertByTitle:@"退出-方法1" message:nil confirm:^{
                
                AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIWindow *window = app.window;
                [UIView animateWithDuration:0.4f animations:^{
                    CGAffineTransform curent =  window.transform;
                    CGAffineTransform scale = CGAffineTransformScale(curent, 0.1,0.1);
                    [window setTransform:scale];
                } completion:^(BOOL finished) {
                    exit(0);
                }];
            } cancel:^{
                
            }];
            
            
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"退出方式-asm_exit,真机有效";
        option.action = ^{
            
            [self ax_showAlertByTitle:@"退出方式-asm_exit,真机有效" message:nil confirm:^{
                asm_exit();
            } cancel:^{
            }];
            
            
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"退出方式3";
        option.action = ^{
            
            [self ax_showAlertByTitle:@"退出方式-asm_exit,真机有效" message:nil confirm:^{
                if([[UIApplication sharedApplication] respondsToSelector:@selector(terminateWithSuccess)]) {
                    [[UIApplication sharedApplication] performSelector:@selector(terminateWithSuccess)];
                }
            } cancel:^{
            }];
            
            
        };
    }
    
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"fishhook调用方法";
        option.action = ^{
            NSLog(@"fish_log");
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
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
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"NSMutableDictionary,nil";
        option.action = ^{
            NSMutableDictionary *dict=NSMutableDictionary.dictionary;
            [dict setObject:nil forKeyedSubscript:@"name"];
            NSLog(@"dict nil = %@",dict);
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"NSMutableDictionary,forKeyedSubscript";
        option.action = ^{
            NSMutableDictionary *dict=NSMutableDictionary.dictionary;
            [dict setObject:@"jim" forKeyedSubscript:@"name"];
            NSLog(@"dict = %@",dict);
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
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
        _AXCellItem *option = _AXCellItem.alloc.init;
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
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"oc调用swift";
        option.action = ^{
            DogSwift *dog =  [DogSwift.alloc init];
            [dog show];
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"解压";
        option.action = ^{
            NSString *path = [NSString.ax_documentDirectory stringByAppendingPathComponent:@"sudian.zip"];
            NSString *targetPath = NSString.ax_documentDirectory;
            BOOL succ = [SSZipArchive unzipFileAtPath:path toDestination:targetPath];
            NSLog(@"解压 = %d",succ);
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"CocoaLumberjack日志,注册";
        option.action = ^{
#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
            // Uses os_log
            //[DDLog addLogger:[DDASLLogger sharedInstance]]; //iOS10之前
            [DDLog addLogger:DDOSLogger.sharedInstance]; //iOS10之后
            [DDLog addLogger:DDTTYLogger.sharedInstance];
            [DDLog addLogger:DDTTYLogger.sharedInstance withLevel:ddLogLevel];
            
            // 先创建一个文件日志, 定义好相关配置信息
            //                DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
            
            
            NSString *path = [[[NSString ax_cachesDomainMask] stringByAppendingPathComponent:@"axlog"] stringByAppendingPathComponent:@"CocoaLumberjack"];
            
            DDLogFileManagerDefault * documentsFileManager = [[DDLogFileManagerDefault alloc]
                                                              initWithLogsDirectory:path];
            
            DDFileLogger *fileLogger =  [[DDFileLogger alloc] initWithLogFileManager:documentsFileManager];
            
            
            fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
            fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
            [DDLog addLogger:fileLogger];
            
            
            
            
            
#endif
        };
    }
    
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"CocoaLumberjack日志,打印";
        option.action = ^{
#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
            
            DDLogVerbose(@"Verbose====123");
            DDLogDebug(@"Debug====123");
            DDLogInfo(@"Info====123");
            DDLogWarn(@"Warn====123");
            DDLogError(@"Error====123");
#endif
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"CocoaDebugTool,打印";
        option.action = ^{
#if __has_include(<CocoaDebug/CocoaDebugTool.h>)
            
            [CocoaDebugTool logWithString:@"Custom Messages...."];
            [CocoaDebugTool logWithString:@"Custom Messages...,有颜色" color:[UIColor redColor]];
            NSLog(@"需要设置打开 App logs 才能看见");
            
#endif
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"pushViewControllerPresentStyle";
        option.action = ^{
            
            _01ContentViewController *vc = [_01ContentViewController.alloc init];
            [self.navigationController ax_pushViewControllerPresentStyle:vc animated:YES];
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
        [tempArray addObject:option];
        option.title = @"presentViewControllerPushStyle";
        option.action = ^{
            
            _01ContentViewController *vc = [_01ContentViewController.alloc init];
            [self ax_presentViewControllerPushStyle:vc animated:YES completion:nil];
        };
    }
    {
        _AXCellItem *option = _AXCellItem.alloc.init;
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
        
    }
    [tempArray addTitle:@"单例宏" detail:nil action:^(_AXCellItem *option) {
        NSDictionary *dict = @{@"name":@"jim",@"age":@(20)};
        [AXDemoUser mj_objectWithKeyValues:dict];
        
        
        NSLog(@"AXDemoUser age=%@",[AXDemoUser.sharedUser mj_JSONObject]);
        
    }];
    [tempArray addTitle:@"单例宏,取消单例" detail:nil action:^(_AXCellItem *option) {
        [AXDemoUser cancelSingleton];
        NSLog(@"AXDemoUser age=%@",[AXDemoUser.sharedUser mj_JSONObject]);
        
    }];
    
    [tempArray addTitle:@"单例能继承" detail:nil action:^(_AXCellItem *option) {
        [AXDemoUser testSub];
        [AXDemoUser2 testSub];
        NSLog(@"AXDemoUser=%p",AXDemoUser.sharedUser);
        NSLog(@"AXDemoUser2=%p",AXDemoUser2.sharedUser);
        NSLog(@"AXDemoUser2=%p",AXDemoUser2.alloc.init);
    }];
    
    [tempArray addTitle:@"数组深复制 NSMutableCopy" detail: @"对象数组," action:^(_AXCellItem *option) {
        
        NSArray *arr = @[
            @{@"name":@"jim",@"age":@12},
            @{@"name":@"tom",@"age":@12},
        ];
        
        NSMutableArray<_Person *> *arr1 = [_Person mj_objectArrayWithKeyValuesArray:arr];
        
        /// 这个才可以,切内部必须实现协议
        NSArray  *deepCopyAry = [[NSArray alloc]initWithArray:arr1 copyItems:YES];
        
        ///这个地址不同,但不走 copy协议
        //                NSArray  *deepCopyAry = arr1.mutableCopy;
        
        arr1[0].name = @"jim-2";
        NSLog(@"地址:arr1=%p,\n deepCopyAry=%p",arr1,deepCopyAry);
        NSLog(@"地址[0]arr1=%p,\n deepCopyAry=%p",arr1[0],deepCopyAry[0]);
        NSLog(@"arr1=%@,\n deepCopyAry=%@",arr1,deepCopyAry);
    }];
    
    [tempArray addTitle:@"dispatch_barrier_async" detail:nil action:^(_AXCellItem *option) {
        
        dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
        //dispatch_get_global_queue(0, 0);
        
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:1.1];
            NSLog(@"task 1");
        });
        
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"task 2");
        });
        
        dispatch_barrier_async(queue, ^{
            NSLog(@"=========barrier==============%@",[NSThread currentThread]);
        });
        
        
        dispatch_async(queue, ^{
            NSLog(@"task 3");
        });
        dispatch_async(queue, ^{
            NSLog(@"task 4");
        });
        
    }];
    
    [tempArray addTitle:@"MBProgressHUD" detail: @"ax_showSuccess" action:^(_AXCellItem *option) {
        [self.view ax_showSuccess:@"成功,会自动消失"];
    }];
    
    [tempArray addTitle:@"MBProgressHUD" detail: @"ax_showError" action:^(_AXCellItem *option) {
        [self.view ax_showError:@"失败,会自动消失"];
    }];
    [tempArray addTitle:@"MBProgressHUD" detail: @"ax_showWarning" action:^(_AXCellItem *option) {
        [self.view ax_showWarning:@"警告,会自动消失"];
    }];
    
    return tempArray;
}

@end
