//
//  DLCompanyNewsModel.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,DLCompanyNewsType) {
    /// 纯文字
    DLCompanyNewsTypeText,
    /// 左文 右小图片
    DLCompanyNewsTypeOneSamllPicture,
    /// 上文 中多图
    DLCompanyNewsTypeMoreSamllPicture,
    /// 一个大图
    DLCompanyNewsTypeOneBigPicture,
    /// 视频
    DLCompanyNewsTypeOneVideo,
};

@interface DLCompanyNewsModel : NSObject

@property (nonatomic,assign)DLCompanyNewsType type;
@property (nonatomic,copy)NSString *TITLE;

//@property (nonatomic,copy)NSString *TITLE_IMG_URL;
@property (nonatomic,copy)NSMutableArray<NSString *> *TITLE_IMG_URL_ARRAY;
@property (nonatomic,copy)NSString *PUB_DATE;
@property (nonatomic,copy)NSString *SUB_URL;


@property (nonatomic,copy)NSString *PUB_COMPANY;

@end

NS_ASSUME_NONNULL_END
