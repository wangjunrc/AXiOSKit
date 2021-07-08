//
//  _35ProtobufVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/15.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_35ProtobufVC.h"
#import "Student.pbobjc.h"
/**
 protoc --proto_path=. --objc_out=. UpDriverPosition.proto

 protoc 为proto的生成指令 后面添加 参数

 参数的形式为: --参数命令名=参数

 ​--proto_path=.​ 指出proto文件所在的根目录是哪里, 如果用​.​说明是当前目录

 ​--objc_out=.​ 指出 生成目录在哪里, 如果用​.​说明是当前目录
 */
@interface _35ProtobufVC ()

@end

@implementation _35ProtobufVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _buttonTitle:@"解析" handler:^(UIButton * _Nonnull btn) {
        
        Student *student = Student.alloc.init;
        student.name = @"jim";
        student.age = 10;
        student.gender = @"男";
        NSData *data = [student data];
        NSLog(@"data = %@", data);
        
        Student *student2=  [Student parseFromData:data error:nil];
        NSLog(@"student2 = %@", student2);
        student2.name = @"Tom";
        NSLog(@"student2 = %@", student2);
        
    }];
    
    [self _lastLoadBottomAttribute];
}



@end
