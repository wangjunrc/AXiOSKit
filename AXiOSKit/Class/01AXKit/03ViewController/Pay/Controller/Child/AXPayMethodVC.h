//
//  AXPayMethodVC.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/22.
//

#import <UIKit/UIKit.h>
#import "AXChoosePayModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXPayMethodVC : UIViewController

@property(nonatomic,strong)NSArray <AXChoosePayModel *>*dataArray;

@property(nonatomic,copy)void(^didSelectBlock)(NSInteger row);

@end

NS_ASSUME_NONNULL_END
