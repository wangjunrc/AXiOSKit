//
//  DLCompanyNewsModel.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import "DLCompanyNewsModel.h"

@implementation DLCompanyNewsModel


- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.PUB_COMPANY forKey:@"PUB_COMPANY"];
    [coder encodeObject:self.PUB_DATE forKey:@"PUB_DATE"];
    [coder encodeObject:self.SUB_URL forKey:@"SUB_URL"];
    [coder encodeObject:self.TITLE forKey:@"TITLE"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)coder{
    
    self  = [super init];
    if(self){
        self.PUB_COMPANY = [coder decodeObjectForKey:@"PUB_COMPANY"];
        self.PUB_DATE = [coder decodeObjectForKey:@"PUB_DATE"];
        self.SUB_URL = [coder decodeObjectForKey:@"SUB_URL"];
        self.TITLE = [coder decodeObjectForKey:@"TITLE"];
//        self.TITLE_IMG_URL = [coder decodeObjectForKey:@"TITLE_IMG_URL"];
    }
    return self;
}

- (NSMutableArray<NSString *> *)TITLE_IMG_URL_ARRAY {
    if (!_TITLE_IMG_URL_ARRAY) {
        _TITLE_IMG_URL_ARRAY = [NSMutableArray array];
    }
    return _TITLE_IMG_URL_ARRAY;
}
@end
