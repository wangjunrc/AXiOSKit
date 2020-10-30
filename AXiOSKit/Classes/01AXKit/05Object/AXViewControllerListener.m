//
//  AXViewControllerListener.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/30.
//

#import "AXViewControllerListener.h"

@interface AXViewControllerListener ()
@property(nonatomic, weak,readwrite) UIViewController *viewController;
@end

@implementation AXViewControllerListener

- (instancetype)initWithObserve:(UIViewController *)viewController{
    if (self = [self init]) {
        self.viewController = viewController;
    }
    return self;
}


- (AXViewControllerListener *(^)(void(^)(void)))isPushed {
        __weak typeof(self) weakSelf = self;
        return ^AXViewControllerListener *(void (^isPushed)(void)) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            /// firstObject!=self 表示被push的
            if (isPushed &&
                strongSelf.viewController.navigationController &&
                ![strongSelf.viewController.navigationController.viewControllers.firstObject isEqual:strongSelf.viewController]){
                isPushed();
            }
            return strongSelf;
        };
}
- (AXViewControllerListener *(^)(void(^)(void)))isPresented {
        __weak typeof(self) weakSelf = self;
    
    __strong typeof(self.viewController) weakVC = self.viewController;
        return ^AXViewControllerListener *(void (^isPresented)(void)) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            __strong typeof(weakVC) strongVC = weakVC;
            if (isPresented){
                /// iOS13之前,没有强制设置 modalPresentationStyle 父presentingViewController
                if (strongSelf.viewController.modalPresentationStyle != UIModalPresentationFullScreen && strongSelf.viewController.presentingViewController) {
                    isPresented();
                }else{
                    /// presentationController 转场动画VC 会强引用
//                   __weak Class aCla =  NSClassFromString(@"_UIFullscreenPresentationController");
//                    if ([strongVC.presentationController isKindOfClass:aCla]) {
//                        isPresented();
//                    };
                    if (!strongSelf.viewController.navigationController) {
                        isPresented();
                    }
                }

            }
            return strongSelf;
        };
}



@end
