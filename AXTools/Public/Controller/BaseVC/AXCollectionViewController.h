//
//  AXCollectionViewController.h
//  AXTools
//
//  Created by Mole Developer on 16/5/26.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXNaviC.h"
@interface AXCollectionViewController : UICollectionViewController

+(AXNaviC *)navigationVC;
/**
 * <#注释#>
 */
@property(nonatomic,assign)BOOL showDisItem;
@end
