#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AXAlertCentreAnimation.h"
#import "AXAlertTransitioningObserver.h"
#import "AXAlerUpwardAnimation.h"
#import "AXBaseAlertDefine.h"
#import "AXPresentationController.h"
#import "UIViewController+AXTransitioning.h"

FOUNDATION_EXPORT double AXTransitioningObserverVersionNumber;
FOUNDATION_EXPORT const unsigned char AXTransitioningObserverVersionString[];

