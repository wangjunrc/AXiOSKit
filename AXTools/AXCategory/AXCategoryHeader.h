//
//  AXCategoryHeader.h
//  Xile
//
//  Created by Mole Developer on 2017/3/8.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#ifndef AXCategoryHeader_h
#define AXCategoryHeader_h
#import "UIView+AXFrame.h"
#import "CALayer+AXFrame.h"
#import "UIButton+AXTool.h"
#import "UILabel+AXTool.h"
#import "NSString+AXTool.h"
#import "NSString+AXEffective.h"
#import "UIImage+AXTool.h"
#import "UIImageView+AXTool.h"
#import "UIBarButtonItem+AXTool.h"
#import "UIView+AXTool.h"
#import "NSDate+AXTool.h"
#import "NSObject+AXTool.h"
#import "NSString+AXVersion.h"
#import "UIColor+AXTool.h"
#import "UIViewController+AXTool.h"
#import "NSURL+AXTool.h"
#import "NSData+AXTool.h"
#import "UITableView+AXTool.h"
#import "UIDevice+AXTool.h"
#import "UIView+Animation.h"
#import "UIViewController+AXAlert.h"
#import "NSObject+AXKVO.h"
#import "UICollectionView+AXTool.h"
#import "NSString+AXNet.h"
#import "UIScrollView+AXTool.h"
#import "NSString+AXCrypto.h"
#import "UIButton+AXTool.h"
#import "UISlider+AXTool.h"
#import "UITextField+AXTool.h"
#import "NSString+AXDate.h"
#import "UINavigationController+AXTool.h"
#import "UISwitch+AXTool.h"
#import "NSDateComponents+AXTool.h"
#import "UIScrollView+AXEmptyDataSet.h"
/*
 
 分类重写set get 方法说明
 
 OBJC_ASSOCIATION_ASSIGN;            //assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
 
 OBJC_ASSOCIATION_RETAIN;
 OBJC_ASSOCIATION_COPY;
 */
/*
 * id object 给哪个对象的属性赋值
 const void *key 属性对应的key
 id value  设置属性值为value
 objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 */


#endif /* AXCategoryHeader_h */
