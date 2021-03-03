//
//  NSBundle+CLLanguage.h
//  CLDemo
//
//  Created by AUG on 2018/11/7.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 没有生效，这是因为设置AppleLanguages字段的话，只会在下次启动App才会生效，
 在App启动后就已经生成了一个Bundle，里面识别好了对应着AppleLanguages的国际化文件，
 在App运行期间设置这个字段，是不生效的，所以我们去修改这个Bundle，写一个NSBundle的扩展

 作者：翻炒吧蛋滚饭
 链接：https://www.jianshu.com/p/c7e8e999c8c7
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
@interface NSBundle (CLLanguage)

/**
 是否是中文
 */
+ (BOOL)isChineseLanguage;

/**
 查询当前语言

 @return 当前语言
 */
+ (NSString *)currentLanguage;

@end

NS_ASSUME_NONNULL_END
