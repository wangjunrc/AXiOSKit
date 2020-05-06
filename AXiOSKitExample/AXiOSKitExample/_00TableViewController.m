//
//  TableViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/6.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "_00TableViewController.h"
#import "ViewController.h"
#import "ChatViewController.h"
#import <AXiOSKit/UIViewController+AXKit.h>
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
#import "_20ViewController_webp.h"

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
    self.title = @"主题";
    //    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellid"];
    
    
    self.name = @"-1";
    self.count = 0;
    //
    //    //
    //    //    struct rebinding nsLog;
    //    //    nsLog.name = "NSLog";
    //    //    nsLog.replacement = mySLog;
    //    //    nsLog.replaced = (void *)&replacedLog;
    //    //    struct rebinding rebinds[1] = {nsLog};
    //    //    rebind_symbols(rebinds, 1);
    //    //
    //
    //     NSLog(@"runLoop 1 = %p",[NSRunLoop currentRunLoop]);
    //     NSLog(@"runLoop 1 = %p",[NSRunLoop mainRunLoop]);
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    //
    //        NSLog(@"2");
    //
    //        [[NSThread currentThread] setName:@"AFNetworking"];
    //
    //
    //
    //        [self performSelector:@selector(test) withObject:nil afterDelay:1];
    //
    //
    //        NSRunLoop *runLoop2 = [NSRunLoop currentRunLoop];
    //
    //
    //        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //        //        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    //        [runLoop run];
    //
    //
    //        NSLog(@"runLoop = %p",runLoop);
    //        NSLog(@"runLoop2 = %p",runLoop2);
    //          NSLog(@"runLoop 2 = %p",[NSRunLoop mainRunLoop]);
    //        //          [[NSRunLoop currentRunLoop] run];
    //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    //                    NSLog(@"runLoop 6 = %p",[NSRunLoop currentRunLoop]);
    //                });
    //        NSLog(@"3");
    //    });
    //
    
    
    //    [self.tableView setEditing:YES animated:YES];
}


- (void)test
{
    
    NSLog(@"5");
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cellid"
                             ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                      reuseIdentifier: @"cellid"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dict[@"index"]];
    cell.detailTextLabel.text = dict[@"title"];
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
                @"index":@1,
                @"title":@"暗黑主题-ViewController",
                @"action":  ^{
                    ViewController *vc = [[ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            @{
                @"index":@2,
                @"title":@"聊天-ChatViewController",
                @"action":  ^{
                    ChatViewController *vc = [[ChatViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            
            @{
                @"index":@3,
                @"title":@"隐藏导航栏",
                @"action":  ^{
                    ViewController *vc = [[ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    vc.ax_shouldNavigationBarHidden = YES;
                },
            },
            
            @{
                @"index":@4,
                @"title":@"NSRunLoop模式",
                @"action":  ^{
                    RunLoopViewController *vc = [[RunLoopViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            
            
            @{
                @"index":@5,
                @"title":@"对象未实现方法",
                @"action":  ^{
                    [self ax_showAlertByTitle:@"是否调用" confirm:^{
                        UIButton *testButton = [[UIButton alloc] init];
                        [testButton performSelector:@selector(someMethod:)];
                    }];
                },
            },
            @{
                @"index":@6,
                @"title":@"WCDB",
                @"action":  ^{
                    
                    WCDBViewController *vc = [[WCDBViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                
                
            },
            @{
                @"index":@7,
                @"title":@"视频",
                @"action":  ^{
                    
                    VideoViewController *vc = [[VideoViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
            },
            
            @{
                @"index":@8,
                @"title":@"网页",
                @"action":  ^{
                    
                    AXWKWebVC *vc = [[AXWKWebVC alloc]init];
                    vc.loadURLString = @"http://127.0.0.1:8091";
                    [self.navigationController pushViewController:vc animated:YES];
                },
                
                
            },
            
            @{
                @"index":@9,
                @"title":@"AFN",
                @"action":  ^{
                    
                    AFNViewController *vc = [[AFNViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                },
                
                
            },
            
            @{
                @"index":@10,
                @"title":@"多行textview",
                @"action":  ^{
                    
                    TextFViewController *vc = [[TextFViewController alloc]init];
                    [self ax_showVC:vc];
                },
                
                
            },
            
            
            @{
                @"index":@11,
                @"title":@"objc_msgSend调用方法",
                @"action":  ^{
                    
                    id person   = objc_msgSend(objc_getClass("Person"),sel_registerName("alloc"),sel_registerName("init"));
                    objc_msgSend(person, sel_registerName("logShowTest"));
                    
                    
                },
                
                
            },
            
            
            @{
                @"index":@12,
                @"title":@"fishhook调用方法",
                @"action":  ^{
                    
                    NSLog(@"fish_log");
                    
                    
                },
                
                
            },
            
            
            @{
                @"index":@13,
                @"title":@"webp图片",
                @"action":  ^{
                    _20ViewController_webp *vc = [[_20ViewController_webp alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
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

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

@end
