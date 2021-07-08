//
//  _40ScreenshotsVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/11.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_40ScreenshotsVC.h"
#import <Photos/Photos.h>
@interface _40ScreenshotsVC ()<PHPhotoLibraryChangeObserver>

@property(nonatomic, strong) PHFetchResult<PHAsset *> *fetchRequest;
@property(nonatomic, assign) BOOL isScreenShot;

@end

@implementation _40ScreenshotsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"监听截屏" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf didStatuCanEdit:^(BOOL isCan, NSString *msg) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!isCan) {
                [MBProgressHUD ax_showError:msg];
            }else {
                [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(screenshotsNote:) name:UIApplicationUserDidTakeScreenshotNotification  object:nil];
                [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:strongSelf];
            }
        }];
        
        
    }];
    
    [self _buttonTitle:@"取消监听截屏" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification  object:nil];
        [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:strongSelf];
    }];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    options.includeHiddenAssets = YES;
    options.includeAllBurstAssets = YES;
    /// 只要图片
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    options.includeAssetSourceTypes = PHAssetSourceTypeUserLibrary;
    options.fetchLimit = 1;
    PHFetchResult<PHAsset *> *fetchRequest = [PHAsset fetchAssetsWithOptions:options];
    
    //    PHAsset *phasset =  fetchRequest.firstObject;
    //    self.phasset = fetchRequest.firstObject;
    self.fetchRequest = fetchRequest;
    
    [self _lastLoadBottomAttribute];
}



-(void)screenshotsNote:(NSNotification *)note {
    NSLog(@"监听截屏通知========%@",note.userInfo);
    self.isScreenShot = YES;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    
    if (!self.isScreenShot) {
        return;
    }
    self.isScreenShot = NO;
    dispatch_async(dispatch_get_main_queue (), ^{
        __weak typeof(self) weakSelf = self;
        [self didStatuCanEdit:^(BOOL isCan, NSString *msg) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (isCan) {
                [strongSelf deleteImage:changeInstance];
            }else {
                [MBProgressHUD ax_showError:msg];
            }
        }];
    });
}

-(void)deleteImage:(PHChange *)changeInstance {
    
    PHFetchResultChangeDetails *det =  [changeInstance  changeDetailsForFetchResult:self.fetchRequest];
    if (det) {
        
        //相册内的元素变化，如相片的增减
        self.fetchRequest = det.fetchResultAfterChanges;
        
        if (det.hasIncrementalChanges) {
            
            [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
                ///这里,只删除一张
                if (self.fetchRequest.count>0) {
                    NSMutableArray<NSFastEnumeration> *assets = [NSMutableArray array];
                    PHAsset *obj = self.fetchRequest.lastObject;
                    BOOL b = [obj canPerformEditOperation:PHAssetEditOperationDelete];
                    if (b) {
                        [assets addObject:obj];
                    }
                    
                    if (assets.count>0) {
                        [PHAssetChangeRequest deleteAssets:assets];
                        
                    }
                }
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                
                NSLog(@"删除 = %d,error = %@",success,error);
            }];
        }
        
        
    }else{
        
        //相册的增删，如用户自定义的相册
        
    }
    
}

-(void)didStatuCanEdit:(void(^)(BOOL isCan,NSString *msg))result {
    
    PHAuthorizationStatus statu = PHAuthorizationStatusNotDetermined;
    if (@available(iOS 14, *)) {
        statu = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
    } else {
        statu =  PHPhotoLibrary.authorizationStatus;
    }
    
    if (statu == PHAuthorizationStatusAuthorized) {
        if (result) {
            result(YES,nil);
        }
    }
    // 如果没决定, 弹出指示框, 让用户选择
    else if (statu == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            // 如果用户选择授权, 则保存图片iOS14的状态不考虑,截图存在全部相册中
            if (status == PHAuthorizationStatusAuthorized) {
                if (result) {
                    result(YES,nil);
                }
            }else {
                if (result) {
                    result(NO,@"相册权限不足");
                }
            }
        }];
    } else {
        if (result) {
            result(NO,@"相册权限不足");
        }
    }
}



- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification  object:nil];
}

@end
