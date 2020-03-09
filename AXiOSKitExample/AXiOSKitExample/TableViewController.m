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

@property(atomic, assign) NSInteger count;;




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
    
    
    AView *aview = [[AView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    aview.backgroundColor = [UIColor redColor];
    NSLog(@"11111 %p",self.view);
    [self.view addSubview:aview];
    
    NSLog(@"22222");
    
    
    
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
                    
                    UIButton *testButton = [[UIButton alloc] init];
                    [testButton performSelector:@selector(someMethod:)];
                },
            },
            @{
                @"title":@"WCDB",
                @"action":  ^{
                    
                    WCDBViewController *vc = [[WCDBViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                },
            },
            
            
            
        ];
    }
    return _dataArray;
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
@end
