//
//  BAThemeListModel.h
//  BigApple
//
//  Created by Mole Developer on 2016/11/7.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAFileHeader.h"

@interface BAThemeListModel : NSObject

@property(nonatomic,copy)NSString *resourceId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *playTime;

@property(nonatomic,strong)NSDate *date;
@end
