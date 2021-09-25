//
//  NSBundle+AXBundle.m
//  AXiOSKit
//
//  Created by axing on 2019/1/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "NSBundle+AXBundle.h"

/**
 增加这个私有类，目的是不想导入其他的类
 */
@interface AXBundle : NSObject

+ (NSBundle *)ax_mainBundle;

@end


@implementation AXBundle

NSString *const kAXiOSKitBundleName = @"AXiOSKitMain";

+ (NSBundle *)ax_mainBundle {
    
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        /**
         取默认值,但是我自定义了
         NSDictionary *dic = currentBundle.infoDictionary;
         NSString *bundleName = dic[@"CFBundleExecutable"];
         NSString *resourcePath = [currentBundle pathForResource:bundleName ofType:@"bundle"];
         */
        NSString *bundlePath = [bundle pathForResource:kAXiOSKitBundleName ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:bundlePath] ?: bundle;
    }
    return resourceBundle;
    
}

+ (NSBundle *)ax_HTMLBundle {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    // 直接取 bundle 名称
    NSString *bundlePath = [bundle pathForResource:@"AXHTML" ofType:@"bundle"];
    NSBundle *tempBundle = [NSBundle bundleWithPath:bundlePath];
    if (tempBundle == nil) {
        tempBundle = bundle;
    }
    return tempBundle;
}

+ (NSBundle *)bundleWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *bundlePath = [bundle pathForResource:name ofType:@"bundle"];
    NSBundle *tempBundle = [NSBundle bundleWithPath:bundlePath];
    if (tempBundle == nil) {
        tempBundle = bundle;
    }
    return tempBundle;
}

@end

@implementation NSBundle (AXBundle)

+ (NSBundle *)ax_mainBundle {
    return AXBundle.ax_mainBundle;
}

+ (NSBundle *)ax_HTMLBundle {
    return AXBundle.ax_HTMLBundle;
}

+ (NSBundle *)ax_currentBundleWithName:(NSString *)name {
    NSString *type = @"bundle";
    if ([name.pathExtension isEqualToString:@"bundle"]) {
        type = nil;
    }
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:name ofType:type];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}

+ (NSBundle *)axkit_bundleWithName:(NSString *)name {
    
    return  [AXBundle bundleWithName:name];
}


-(NSArray *)ax_arrayForResource:(NSString *)name {
    return [self ax_arrayForResource:name ofType:nil];
}

-(NSArray *)ax_arrayForResource:(NSString *)name ofType:(NSString *)ext{
    
    NSString *path =  [self pathForResource:name ofType:ext];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    return array;
}

-(NSDictionary *)ax_dictionaryForResource:(NSString *)name {
    return [self ax_dictionaryForResource:name ofType:nil];
}

-(NSDictionary *)ax_dictionaryForResource:(NSString *)name ofType:(NSString *)ext{
    
    NSString *path =  [self pathForResource:name ofType:ext];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    return dict;
}


@end


NSString* __nullable AXPathForFile(NSString* fileName, Class inBundleForClass){
    NSBundle* bundle = [NSBundle bundleForClass:inBundleForClass];
    return AXPathForFileInBundle(fileName, bundle);
}

NSString* __nullable AXPathForFileInBundle(NSString* fileName, NSBundle* bundle){
    return [bundle pathForResource:[fileName stringByDeletingPathExtension]
                            ofType:[fileName pathExtension]];
}

NSString* __nullable AXPathForFileInDocumentsDir(NSString* fileName){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = (paths.count > 0) ? paths[0] : nil;
    return [basePath stringByAppendingPathComponent:fileName];
}

NSBundle* __nullable AXResourceBundle(NSString* bundleBasename, Class inBundleForClass){
    NSBundle* classBundle = [NSBundle bundleForClass:inBundleForClass];
    return [NSBundle bundleWithPath:[classBundle pathForResource:bundleBasename
                                                          ofType:@"bundle"]];
}

