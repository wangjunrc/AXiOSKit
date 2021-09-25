//
//  NSBundle+AXBundle.h
//  AXiOSKit
//
//  Created by axing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AXBundle)


/**
 AXiOSKitMain.bundle 路径
 
 @return NSBundle
 */
+ (NSBundle *)ax_mainBundle;


/**
 # html,css,js 放在一个bundle中,放这里,
 # 如果放resource_bundles,会bundle嵌套,模拟器有缓存,不好实时更新,所以这样写,这里的.bundle与AXiOSKit_ax_mainBundle同级别
 
 @return NSBundle
 */
+ (NSBundle *)ax_HTMLBundle;

/**
 当前 Bundle
 
 @param name Bundle名
 @return NSBundle
 */
+ (NSBundle *)ax_currentBundleWithName:(NSString *)name;

-(NSArray *)ax_arrayForResource:(NSString *)name;
-(NSArray *)ax_arrayForResource:(NSString *)name ofType:(NSString *)ext;

-(NSDictionary *)ax_dictionaryForResource:(NSString *)name;

-(NSDictionary *)ax_dictionaryForResource:(NSString *)name ofType:(NSString *)ext;


/// AXiOSKit 资源包
/// @param name name
+ (NSBundle *)axkit_bundleWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

NSString* __nullable AXPathForFile(NSString* fileName, Class inBundleForClass);


NSString* __nullable AXPathForFileInBundle(NSString* fileName, NSBundle* bundle);


NSString* __nullable AXPathForFileInDocumentsDir(NSString* fileName);


NSBundle* __nullable AXResourceBundle(NSString* bundleBasename, Class inBundleForClass);

NS_ASSUME_NONNULL_END
