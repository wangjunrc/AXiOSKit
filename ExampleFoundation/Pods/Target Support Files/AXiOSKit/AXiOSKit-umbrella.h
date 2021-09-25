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

#import "AXiOSFoundation.h"
#import "AXMacros.h"
#import "AXMacros_addProperty.h"
#import "AXMacros_instance.h"
#import "AXMacros_value.h"
#import "CALayer+AXFrame.h"
#import "NSArray+AXKit.h"
#import "NSBundle+AXBundle.h"
#import "NSData+AXKit.h"
#import "NSDate+AXKit.h"
#import "NSDateComponents+AXKit.h"
#import "NSDictionary+AXKit.h"
#import "NSError+AXKit.h"
#import "NSNumber+AXKit.h"
#import "NSObject+AXAssistant.h"
#import "NSObject+AXAssociated.h"
#import "NSObject+AXKit.h"
#import "NSObject+AXKVO.h"
#import "NSObject+AXLoger.h"
#import "NSObject+AXRuntime.h"
#import "NSObject+AXSafe.h"
#import "NSObject+AXVersion.h"
#import "NSString+AXCrypto.h"
#import "NSString+AXDate.h"
#import "NSString+AXEffective.h"
#import "NSString+AXKit.h"
#import "NSString+AXURL.h"
#import "NSURL+AXKit.h"
#import "NSUserDefaults+AXKit.h"
#import "AXLogers.h"
#import "MSWeakTimer.h"

FOUNDATION_EXPORT double AXiOSKitVersionNumber;
FOUNDATION_EXPORT const unsigned char AXiOSKitVersionString[];

