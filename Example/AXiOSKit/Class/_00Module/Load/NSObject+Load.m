//
//  NSObject+Load.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/20.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "NSObject+Load.h"
#import <Aspects/Aspects.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/NSBundle+AXBundle.h>
#import <AXiOSKit/NSObject+AXRuntime.h>
#import <objc/runtime.h>
#import <Aspects/Aspects.h>

@implementation NSObject (Load)

+ (void)load {
    /// 这个方式,是 UIAlertController init 后改变颜色, 后续使用再改变颜色,以使用颜色为主
    [UIAlertController ax_replaceClassMethodWithOriginal:@selector(alertControllerWithTitle:message:preferredStyle:) newSelector:@selector(ax_alertControllerWithTitle:message:preferredStyle:)];
    
    [UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];
    
    /// usingBlock: 第一个参数 调用对象,第二个是方法的第一次参数
//    [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo,UIViewController *presentViewController) {
//        /// aspectInfo.arguments.firstObject 就是 presentViewController
//        if (![presentViewController isKindOfClass:[UIAlertController class]]) {
//            [aspectInfo.originalInvocation invoke];
//        }else{
//            UIAlertController *alertController = (UIAlertController *)presentViewController;
//            /// 这里用 == nil ,不要用length==0,业务需求不一样
//            /// UIAlertControllerStyleAlert 才拦截
//            if (alertController.title != nil || alertController.message != nil || alertController.preferredStyle !=UIAlertControllerStyleAlert) {
//                [aspectInfo.originalInvocation invoke];
//            }
//        }
//    } error:nil];
    {
        /// hook类方法
        NSError *error;
        [object_getClass(UIImage.class) aspect_hookSelector:@selector(imageNamed:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSString *imageNamed) {
            NSInvocation  *invocation = aspectInfo.originalInvocation;
            if ([imageNamed isEqualToString:@"ax_icon_weixin"]) {
                id img= nil;
                img= [UIImage imageNamed:@"chongshe"];
                [invocation setReturnValue:&img];
                NSLog(@"替换%@为,img=%@",imageNamed,img);
            }
        } error:&error];
        NSLog(@"ax_imageNamed error== %@",error);
        
    }
    
    [NSObject ax_replaceInstanceMethodWithOriginal:@selector(setNilValueForKey:) newSelector:@selector(ax_safe_setNilValueForKey:)];
    
    __block  id  observer  = nil;
    observer = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"load UIApplicationDidFinishLaunchingNotification====2 %@ ,obj = %@",note.userInfo,note.object);
        [NSNotificationCenter.defaultCenter removeObserver:observer];
    }];
    
}


-(void)ax_addAction:(UIAlertAction *)action{
//    [action setValue:UIColor.orangeColor forKey:@"_titleTextColor"];
//    
//    if (@available(iOS 13.0, *)) {
//        UIImage *secondImage = [[UIImage systemImageNamed:@"square.and.arrow.up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [action setValue:secondImage forKey:@"image"];
//    }
    
    [self ax_addAction:action];
}

+ (UIAlertController *)ax_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIAlertController *alert =  [self ax_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (alert.title.length) {
        //修改title字体及颜色
        NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:alert.title];
        [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, titleStr.string.length)];
        [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleStr.string.length)];
        [alert setValue:titleStr forKey:@"attributedTitle"];
    }
    if(alert.message.length){
        // 修改message字体及颜色
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
        [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor greenColor] range:NSMakeRange(0, messageStr.string.length)];
        [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.string.length)];
        [alert setValue:messageStr forKey:@"attributedMessage"];
    }
    return alert;
    
}


- (void)dy_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
        
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        
        if (alertController.title == nil && alertController.message == nil) {
            return;
        } else {
            [self dy_presentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    
    [self dy_presentViewController:viewControllerToPresent animated:flag completion:completion];
}



//#pragma mark -  setValue nil 保护
//- (nullable Ivar)hc_getIvarByKey:(NSString *)key {
//    if (![key isKindOfClass:[NSString class]] || key.length <= 0) {
//        return nil;
//    }
//    // 按照_key _isKey key isKey的方式去获取ivar
//    NSString *firstCharacter = [key substringToIndex:1];
//    NSString *upperFirstKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
//
//    NSString *_keyName = [NSString stringWithFormat:@"_%@", key];
//    NSString *_isKeyName = [NSString stringWithFormat:@"_is%@", upperFirstKey];
//    NSString *keyName = key;
//    NSString *isKeyName = [NSString stringWithFormat:@"is%@", upperFirstKey];
//    Ivar ivar;
//    if ((ivar = [self hc_getIvarByIvarName:_keyName])
//        || (ivar = [self hc_getIvarByIvarName:_isKeyName])
//        || (ivar = [self hc_getIvarByIvarName:keyName])
//        || (ivar = [self hc_getIvarByIvarName:isKeyName])) {
//        return ivar;
//    }
//    return nil;
//}
//
//- (nullable Ivar)hc_getIvarByIvarName:(NSString *)ivarNameString {
//    const char *ivarName = [ivarNameString cStringUsingEncoding:NSUTF8StringEncoding];
//    Ivar ivar = class_getInstanceVariable(self.class, ivarName);
//    return ivar;
//}
//
//- (nullable Method)hc_getMethodByKey:(NSString *)key {
//    if (![key isKindOfClass:[NSString class]] || key.length <= 0) {
//        return nil;
//    }
//    NSString *firstCharacter = [key substringToIndex:1];
//    NSString *upperFirstKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstCharacter.uppercaseString];
//    NSString *setKeyName = [NSString stringWithFormat:@"set%@:", upperFirstKey];
//    NSString *_setKeyName = [NSString stringWithFormat:@"_set%@:", upperFirstKey];
//    NSString *setIsKeyName = [NSString stringWithFormat:@"setIs%@:", upperFirstKey];
//    Method method;
//#define METHOD_BY_NAME(selName) class_getInstanceMethod(self.class, NSSelectorFromString(selName))
//    if ((method = METHOD_BY_NAME(setKeyName))
//        || (method = METHOD_BY_NAME(_setKeyName))
//        || (method = METHOD_BY_NAME(setIsKeyName))) {
//        return method;
//    }
//    return nil;
//}
//
//- (void)hc_setNilValueForKey:(NSString *)key {
//    // 获取是否有set方法
//    Method method = [self hc_getMethodByKey:key];
//    const char *typeEncoding = NULL;
//    if (method != nil) {
//        typeEncoding = method_copyArgumentType(method, 2); // 获取参数的encoding信息，method有2个缺省参数 self _cmd 所以这里是2
//    } else if ([self.class accessInstanceVariablesDirectly]) {
//        // 获取ivar
//        Ivar ivar = [self hc_getIvarByKey:key];
//        if (ivar != nil) {
//            typeEncoding = ivar_getTypeEncoding(ivar);
//        }
//    }
//    if (typeEncoding == NULL) {
//        [self hc_setNilValueForKey:key];
//        return;
//    }
//    // 遍历出所有的number、value类型的encoding，针对性的处理
//    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
//    /*
//     Printing description of typeEncoding:
//     (const char *) typeEncoding = 0x000000010f4c5c7a "{_NSRange=\"location\"Q\"length\"Q}"
//     (lldb) po @encode(NSRange)
//     "{_NSRange=QQ}"
//     */
//    switch (typeEncoding[0]) {
//            // NSNumber scalar type
//        case 'q': // longlong
//        case 'Q': // unsigned longlong
//        case 'i': // int
//        case 'I': // unsigned int
//        case 'l': // long
//        case 'L': // unsigned long
//        case 's': // short
//        case 'S': // unsigned short
//        case 'd': // double
//        case 'f': // float
//            [self setValue:@(0) forKey:key];
//            break;
//        case '{': {
//            char* idx = index(typeEncoding, '='); // 获取'='字符串中第一个出现的参数'=' 地址，然后将该字符出现的地址返回
//            /*
//             eg："0x000000010bac7c7a {_NSRange=\"location\"Q\"length\"Q}" idx则为 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
//
//             Printing description of idx:
//             (char *) idx = 0x000000010bac7c83 "=\"location\"Q\"length\"Q}"
//             Printing description of typeEncoding:
//             (const char *) typeEncoding = 0x000000010bac7c7a "{_NSRange=\"location\"Q\"length\"Q}"
//             */
//            if (idx == NULL) { // 如果为空则表示没有找到'='，此时走远来的流程
//                [self hc_setNilValueForKey:key];
//            }
//            // 处理NSValue的一些场景：比如NSRange、CGRect、CGPoint、CGSize；也就是NSValue structure type
//            /*
//             int strncmp(const char *str1, const char *str2, size_t n) 把 str1 和 str2 进行比较，最多比较前 n 个字节
//             如果返回值 < 0，则表示 str1 小于 str2。
//             如果返回值 > 0，则表示 str2 小于 str1。
//             如果返回值 = 0，则表示 str1 等于 str2。
//             */
//            NSValue *value;
//            long cmpLength = idx - typeEncoding;
//#define SAME_ENCODE(name) (strncmp(typeEncoding, @encode(name), cmpLength) == 0)
//            if (SAME_ENCODE(NSRange)) {
//                value = [NSValue valueWithRange:NSMakeRange(0, 0)];
//            } else if (SAME_ENCODE(CGPoint)) {
//                value = [NSValue valueWithCGPoint:CGPointZero];
//            } else if (SAME_ENCODE(CGSize)) {
//                value = [NSValue valueWithCGSize:CGSizeZero];
//            } else if (SAME_ENCODE(CGRect)) {
//                value = [NSValue valueWithCGRect:CGRectZero];
//            } else if (SAME_ENCODE(CGVector)) {
//                value = [NSValue valueWithCGVector:CGVectorMake(0, 0)];
//            } else if (SAME_ENCODE(UIEdgeInsets)) {
//                value = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
//            } else if (SAME_ENCODE(UIOffset)) {
//                value = [NSValue valueWithUIOffset:UIOffsetZero];
//            } else if (SAME_ENCODE(CGAffineTransform)) {
//                value = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
//            }
//#ifndef FOUNDATION_HAS_DIRECTIONAL_GEOMETRY
//            else if (@available(iOS 11.0, *)) {
//                if (SAME_ENCODE(NSDirectionalEdgeInsets)) {
//                    value = [NSValue valueWithDirectionalEdgeInsets:NSDirectionalEdgeInsetsZero];
//                }
//            } else {
//                // Fallback on earlier versions
//            }
//#endif
//            if (value != nil) {
//                [self setValue:value forKey:key];
//            } else {
//                [self hc_setNilValueForKey:key];
//            }
//        }
//            break;
//        default:
//            [self hc_setNilValueForKey:key];
//            break;
//    }
//}
//
//
//
@end
