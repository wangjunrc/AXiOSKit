
#import <UIKit/UIKit.h>
/**
 * VC导航栏 pop时,选择是否pop,vc重写该方法
 
 
 - (BOOL)navigationShouldPopOnBackButton
 {
 UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"是否退出" message:@"退出提示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
 [view show];
 return NO;
 }
 
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 {
 if (buttonIndex == 1) {
 //处理返回事件
 [self.navigationController popViewControllerAnimated:YES];
 }
 }
 
 
 
 
 */
@protocol BackButtonHandlerProtocol <NSObject>
@optional


- (BOOL)ax_navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end

