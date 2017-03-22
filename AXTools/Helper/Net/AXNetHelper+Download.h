//
//  AXNetHelper+Download.h
//  BigApple
//
//  Created by Mole Developer on 2016/11/22.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXNetHelper.h"
@interface AXNetHelper (Download)
/**
 * 下载文件,含有网络转态,已经保存下载进度
 */
+ (void )POSTDownloadWithUrl:(NSString *)url downPath:(NSString *)downPath netState:(void(^)(NetWorkStatus  WorkStatus,NSURLSessionDownloadTask *downloadTask))netState  progress:(void (^)(NSProgress *progress))progress completion:(void(^)(NSString *filePath))completion saveState:(void(^)( float downloadProgress))saveState;
@end
