 //
//  AXDottedLineView.h
//  AXiOSKitDemo
//
//  Created by liuweixing 2018/8/27.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

/*
 虚线view
 */
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface AXDottedLineView : UIView

@property (nonatomic, assign)IBInspectable int lineLength;

@property (nonatomic, assign)IBInspectable int lineSpacing;

@property (nonatomic, strong)IBInspectable UIColor *lineColor;

@end
