//
//  ViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "ViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import "AAViewController.h"
#import <AXiOSKit/NSData+AXKit.h>
#import "AXMultiSelectViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date1 = [@"2019-01-01 01:59:00" ax_toDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date2 = [@"2019-01-02 01:00:00" ax_toDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSLog(@">> %ld",[date1 ax_apartDayTo:date2]);
    
    NSLog(@">> %ld",[date1 ax_apartDateComponents:date2].day);
    
}

- (IBAction)btnAction1:(id)sender {
    
//    AXWKWebVC *vc = [[AXWKWebVC alloc]init];
//    vc.loadHTMLFilePath = [NSBundle.mainBundle pathForResource:@"H5.bundle/index.html" ofType:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc addScriptMessageWithName:@"person" handler:^(NSString * _Nonnull name, id  _Nonnull body) {
//        NSLog(@"body>> %@",body);
//    }];
    
//    AXDateVC *vc = [[AXDateVC alloc]init];
//    [self ax_showVC:vc];
    
    
    
    AXMultiSelectConfig *cg = [[AXMultiSelectConfig alloc]init];
    cg.column = 5;
//    cg.allowsSelectionEmpty = NO;
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int index_1 = 0; index_1<2; index_1++) {
        
        AXMultiSelectViewModel *svm = [[AXMultiSelectViewModel alloc]init];
        
        svm.sectionTitle = [NSString stringWithFormat:@"head %d",index_1];
        
        NSMutableArray *temp2 = [NSMutableArray array];
        for (int index = 0; index<12; index++) {
            AXMultiSelectRowViewModel *vm = [[AXMultiSelectRowViewModel alloc]init];
            vm.title = [NSString stringWithFormat:@"A%d--%d",index_1,index];
            
            if (index_1 == 0) {
                vm.selected = index%3;
            }else{
                vm.selected = index%2;
            }
            
            [temp2 addObject:vm];
        }
        
        svm.rowArray = temp2.copy;
        
        [temp addObject:svm];
    }
    
    
    AXMultiSelectViewController *vc = [[AXMultiSelectViewController alloc]initWithConfig:cg viewModels:temp didSelectRow:^(NSArray<NSIndexPath *> * _Nonnull selectedItems) {
        NSLog(@"indexPathsForSelectedItems>>> %@",selectedItems);
    }];
    
     [self ax_showVC:vc];
    
}

@end
