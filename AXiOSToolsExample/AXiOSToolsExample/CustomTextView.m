//
//  CustomTextView.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/4/24.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

@dynamic delegate;// .h中警告说delegate在父类已经声明过了，子类再声明也不会重新生成新的方法了。我们就在这里使用@dynamic告诉系统delegate的setter与getter方法由用户自己实现，不由系统自动生成

//#pragma Set & Get
//- (void)setDelegate:(id<CustomTextViewDelegate>)delegate
//{
//    super.delegate = delegate;
//}
//
//- (id<CustomTextViewDelegate>)delegate
//{
//    id curDelegate = super.delegate;
//    return curDelegate;
//}

@end
