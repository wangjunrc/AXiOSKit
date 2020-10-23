//
//  AXiOSKitTests.m
//  AXiOSKitTests
//
//  Created by axinger on 10/21/2020.
//  Copyright (c) 2020 axinger. All rights reserved.
//

@import XCTest;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}
- (void)testLogin {
    
//    NSString *name = @"admin";
//    NSString *pwd = @"123";
//    
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    //获取 name 输入框
//    XCUIElement *nameTextField = app.textFields[@"nameTextField"];
//    [nameTextField tap];
//    [nameTextField typeText:name]; //输入框中写入文字
//    
//    //获取 pwd 输入框
//    XCUIElement *pwdTextField = app.secureTextFields[@"pwdTextField"];
//    [pwdTextField tap];
//    [pwdTextField typeText:pwd];
//    
//    //点击 login 按钮
//    [app.buttons.staticTexts[@"login"] tap];
//    
//    //登录需要网络请求，等待一段时间。登录成功 push 到下一个页面
//    //这里判断在规定的时间内导航栏是否 push 过去
//    XCUIElement *nav = app.navigationBars[name].staticTexts[name];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"exists == 1"];
//    [self expectationForPredicate:predicate evaluatedWithObject:nav handler:nil];
//    [self waitForExpectationsWithTimeout:6 handler:nil];
}


@end

