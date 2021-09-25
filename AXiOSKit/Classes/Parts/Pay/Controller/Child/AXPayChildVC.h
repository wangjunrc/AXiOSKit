//
//  AXPayChildVC.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/22.
//

#import <UIKit/UIKit.h>
@class AXChoosePayModel;

NS_ASSUME_NONNULL_BEGIN

@interface AXPayChildVC : UIViewController

@property(nonatomic,strong)NSArray <AXChoosePayModel *>*payArray;

@property(nonatomic,copy)NSString *orderText;

@property(nonatomic,copy)NSString *amountText;

@property(nonatomic,copy)void(^confirmPayBlock)(AXChoosePayModel *payModel);

@property(nonatomic,copy)void(^cancelBlock)(void);

@end

NS_ASSUME_NONNULL_END
