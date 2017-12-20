//
//  NSObject+locationService.m
//  CommonApp
//
//  Created by Mac Mini on 2017/12/20.
//  Copyright © 2017年 ZTE. All rights reserved.
//

#import "NSObject+locationService.h"
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>

@interface NSObject()<CLLocationManagerDelegate>

@property(nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation NSObject (locationService)

-(void)locationService{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                
                //决定优先使用的方式
                //使用期间定位
                [manager requestWhenInUseAuthorization];
                //                //始终定位
                //                [manager requestAlwaysAuthorization];
                
            }
            break;
        default:
            break;
    }
}

-(void)setLocationManager:(CLLocationManager *)locationManager{
    objc_setAssociatedObject(self, @selector(locationManager),locationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CLLocationManager *)locationManager{
    return objc_getAssociatedObject(self,@selector(locationManager));
}

@end
