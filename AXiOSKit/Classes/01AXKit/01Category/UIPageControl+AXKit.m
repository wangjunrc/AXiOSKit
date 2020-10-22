//
//  UIPageControl+AXKit.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/5.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "UIPageControl+AXKit.h"

@implementation UIPageControl (AXKit)


-(void)ax_setPageImage:(UIImage *)pageImage currentPageImage:(UIImage *)currentPageImage {
    
    if(@available(iOS 14.0, *)) {
        UIView*fview1 =self;
        UIView*subView1 = fview1.subviews.firstObject;
        fview1 = subView1;
        subView1 = fview1.subviews.firstObject;
        fview1 = subView1;
        subView1 = fview1.subviews.firstObject;
        if(subView1 && [subView1 isKindOfClass:[UIImageView class]]) {
            [self modfinPageControlSubViews:fview1 pageImage:pageImage currentPageImage:currentPageImage];
        }
        
    }else{
        
        [self setValue:pageImage forKeyPath:@"pageImage"];
        [self setValue:currentPageImage forKeyPath:@"currentPageImage"];
        
    }
    
}
- (void)modfinPageControlSubViews:(UIView *)fView pageImage:(UIImage *)pageImage  currentPageImage:(UIImage *)currentPageImage{
    
    
    UIImage *inactiveImage =pageImage ;
    
    UIImage *activeImage = currentPageImage;
    
    for(int i =0; i < [fView.subviews count]; i++)  {
        
        UIImageView *dot = [fView.subviews objectAtIndex:i];
        
        [dot.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        dot.backgroundColor = [UIColor clearColor];
        
        if (i == self.currentPage) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, activeImage.size.width, activeImage.size.height)];
            
            imageView.image= activeImage;
            
            [dot addSubview:imageView];
        }else{
            UIImageView*imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, inactiveImage.size.width, inactiveImage.size.height)];
            imageView.image= inactiveImage;
            [dot addSubview:imageView];
        }
        
    }
    
}

@end
