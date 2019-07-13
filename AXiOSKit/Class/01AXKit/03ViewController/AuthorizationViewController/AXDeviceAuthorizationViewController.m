//
//  AXDeviceAuthorizationViewController.m
//  AXiOSKit
//
//  Created by AXing on 2019/7/13.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXDeviceAuthorizationViewController.h"
#import "AXExternFunction.h"

@interface AXDeviceAuthorizationViewController ()


@property(nonatomic,assign)AXDeviceFunctionType type;

@property(nonatomic,assign)AXDeviceFunctionDisableType disableType;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;

@end

@implementation AXDeviceAuthorizationViewController

-(instancetype)initWithType:(AXDeviceFunctionType )type
                disableType:(AXDeviceFunctionDisableType )disableType {
    
    if (self = [self init]) {
        self.type = type;
        self.disableType = disableType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSString *typeStr = nil;

    switch (self.type) {
        case AXDeviceFunctionTypeCamera:{
              typeStr = @"相机";
        }
            break;
        case AXDeviceFunctionTypeAlbumRead:{
            typeStr = @"相册读";
        }
            break;
        case AXDeviceFunctionTypeAlbumWrite:{
            typeStr = @"相册写";
        }
            break;
        default:
            break;
    }

    switch (self.disableType) {
        case AXDeviceFunctionDisableTypeNotSupport:{
             self.titleLabel.text = [NSString stringWithFormat:@"该设备不支持%@功能",typeStr];
             self.openBtn.hidden = YES;
        }
            break;
        case AXDeviceFunctionDisableTypeNotAuthorize:{
             self.titleLabel.text = [NSString stringWithFormat:@"该设备未授权使用%@功能",typeStr];
           self.openBtn.hidden = NO;
        }
            break;
        default:
            break;
    }
}


- (IBAction)opneAction:(id)sender {
    AXOpenSettings();
}

@end
