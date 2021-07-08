//
//  _43ColorVC.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_43ColorVC.h"
//@import DynamicColor;
#import "AXUserSwiftImport.h"
@interface _43ColorVC ()

@end

@implementation _43ColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        UILabel *label1 = [self _titlelabel:@"UILabel 背景添加渐变，文字消失"];
        [label1 layoutIfNeeded];
        [label1 ax_gradientColors:@[UIColor.redColor,UIColor.greenColor,UIColor.orangeColor]];
        
    }
    
    
    {
        UILabel *label2 = [self _titlelabel:@"颜色图片,平铺背景色"];
        [label2 layoutIfNeeded];
        UIImage *image2 = [UIImage ax_imageFromGradientColors:@[UIColor.redColor,UIColor.greenColor,UIColor.orangeColor]
                                                 gradientType:AXGradientTypeLeftToRight
                                                      imgSize:label2.bounds.size];
        label2.backgroundColor = [UIColor colorWithPatternImage:image2];
        
        
    }
    
    
    {
        
        UIImageView *imgView = UIImageView.alloc.init;
        [self.containerView addSubview:imgView];
        imgView.image = [UIImage ax_imageFromGradientColors:@[UIColor.redColor,UIColor.greenColor,UIColor.orangeColor]
                                               gradientType:AXGradientTypeLeftToRight
                                                    imgSize:CGSizeMake(100, 50)];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
        self.bottomAttribute =  imgView.mas_bottom;
    }
    
    
    [self _lastLoadBottomAttribute];
}



@end
