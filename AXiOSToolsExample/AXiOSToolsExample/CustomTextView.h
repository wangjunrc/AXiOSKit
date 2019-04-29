//
//  CustomTextView.h
//  AXiOSToolsExample
//
//  Created by AXing on 2019/4/24.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CustomTextView;

// 创建自己的协议，同时遵守于父类协议（也就相当于继承子父类协议，实际上协议本身是不能被继承的，遵守就相当于抄了一份过来吧）
@protocol CustomTextViewDelegate <UITextViewDelegate>
// 这里添加自己在原协议方法基础上，新增的一些协议方法
// 示例：
- (void)customTextView:(CustomTextView *)customTextView someNewAction:(BOOL)action;
@end

@interface CustomTextView : UITextView
// 因为delegate此时要遵守我们新创建的协议，而不是原本的协议，所以要重写父类中的属性（这里会有警告，稍后会在.m文件中消除）
@property (nonatomic, weak) id<CustomTextViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
