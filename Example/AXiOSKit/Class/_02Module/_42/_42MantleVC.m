//
//  _42MantleVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_42MantleVC.h"
#import "VDPersonModel.h"

@interface _42MantleVC ()

@end

@implementation _42MantleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [self _buttonTitle:@"Mantle解析" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        
        [self _test_Mantle];
    }];
    
    [self _lastLoadBottomAttribute];
}


-(void)_test_Mantle {
    
    
    NSDictionary *dictionary = @{
        @"name2" : @"Mark",
        @"birthday" : @"2016-11-23 23:59:59",
        @"age" : @99
    };
    NSError *error;
    VDPersonModel *person = [MTLJSONAdapter modelOfClass:VDPersonModel.class fromJSONDictionary:dictionary error:&error];
    
    NSLog(@"person=%@,%@",person.name,person.birthday);
    
    /// 不匹配,就会奔溃,建议不使用
//    VDPersonModel *person2 =[VDPersonModel modelWithDictionary:dictionary error:nil];
//    NSLog(@"person2=%@,%@",person2.name,person2.birthday);
    
    NSDictionary *personDictionary = [MTLJSONAdapter JSONDictionaryFromModel:person error:&error];
    NSLog(@"personDictionary=%@",personDictionary);
    
    NSLog(@"person.dictionaryValue=%@",person.dictionaryValue);
    
    
    
}
@end
