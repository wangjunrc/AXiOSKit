//
//  BAFileHeader.h
//  BigApple
//
//  Created by Mole Developer on 2016/11/28.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#ifndef BAFileHeader_h
#define BAFileHeader_h
#import <AXiOSKit/AXiOSKit.h>
#import "BAUserInfo.h"

//1，游戏,2，绘本,3,卡拉ok,4,故事录音
typedef NS_ENUM( NSInteger ,BAContentType){
    BAContentTypeNone=0,
    BAContentTypeGame=1,
    BAContentTypeBook=2,
    BAContentTypeMusic=3,
    BAContentTypeBroadcast=4,
};

typedef NS_ENUM(NSInteger, BAContentState) {
    ContentStateNone,//显示下载图标,
    ContentStateFinish,//显示下载完成图标
    ContentStateLoading,//显示正在下载 label
    ContentStateOnline,//在线播放 不显示图片
};

typedef NS_ENUM(NSInteger, PayState) {
    PayStateNone = 0,
    PayStateWait = 1,//待付款
    PayStateSuccess = 2,
};



//#define H_toLoginVC BALoginVC *vc = [[BALoginVC alloc]init];\
//AXNaviC *myNav = [[AXNaviC alloc]initWithRootViewController:vc];\
//[self presentViewController:myNav animated:YES completion:nil];\

#define H_isLoginVC  if (![BAUserData sharedBAUserData].isLogin) {\
BALoginVC *vc = [[BALoginVC alloc]init];\
AXNaviC *myNav = [[AXNaviC alloc]initWithRootViewController:vc];\
[self presentViewController:myNav animated:YES completion:nil];\
return;\
}\


#define H_pageSize @"20"

#define H_LoginDic @"BALoginDict"

#define BA_DefultImage     [UIImage imageNamed:@"defaultImage"]

//#define BA_HeadImage       [UIImage imageNamed:@"defaulthead"]

#define BA_defaulHead      [UIImage imageNamed:@"defaulHead"]

#define BA_defaulHead_bg      [UIImage imageNamed:@"defaulHead_bg"]

#define MAIN_TINT_COLOR [UIColor ax_colorRed:58 green:164 blue:249]



/**
 * 游戏应用,保存文件夹
 */
#define H_Game [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"Game"]

/**
 * 游戏应用,下载文件
 */
#define H_Game_down [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"Game/down"]

/**
 * 儿童绘本,保存文件夹
 */
#define H_Book [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"Book"]

/**
 * 儿童绘本,下载文件
 */
#define H_Book_down [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"Book/down"]

/**
 * 儿童绘本,录音文件
 */
#define H_Book_record [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"Book/record"]

/**
 * 我爱音乐,保存文件夹
 */
#define H_MyMusic [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"MyMusic"]

/**
 * 我爱音乐,下载文件
 */
#define H_MyMusic_down [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"MyMusic/down"]
/**
 * 我爱音乐,录音文件
 */
#define H_MyMusic_record [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"MyMusic/record"]

/**
 * 我来播音,保存文件夹
 */
#define H_MyBroadcast  [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"MyBroadcast"]

/**
 * 我来播音,,下载文件
 */
#define H_MyBroadcast_down [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"MyBroadcast/down"]
/**
 * 我来播音,,录音文件
 */
#define H_MyBroadcast_record [[BAUserInfo sharedBAUserInfo].userInfo.userId stringByAppendingPathComponent:@"MyBroadcast/record"]


/**
 * db 路径
 */
#define BA_DB_PATH [BAUserInfo sharedBAUserInfo].user.userId ? [NSString stringWithFormat:@"data/%@/user.db",[BAUserInfo sharedBAUserInfo].user.userId] :  @"data/guest/user.db"


/**
 * db 路径
 */
#define BA_DB_DOCUMENT_PATH [[NSString ax_documentPath] stringByAppendingPathComponent:BA_DB_PATH]



#endif /* BAFileHeader_h */
