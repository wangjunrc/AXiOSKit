//
//  LocationManager.h
//  Financing118
//
//  Created by Mole Developer on 15/11/9.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface LocationManager : NSObject

//-(void)Location2D:(void(^)(CLLocationCoordinate2D coordinate2D))location2D;

-(void)location:(void(^)(CLLocation *location))location;

@end
