//
//  UIScrollView+AXEmptyDataSet.m
//  AXiOSKit
//
//  Created by liuweixing on 2017/2/20.
//  Copyright © 2017年 liuweixing All rights reserved.
//

//#if __has_include("UIScrollView+EmptyDataSet.h")

#import "UIScrollView+AXEmptyDataSet.h"
#import "AXMacros.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UIImage+AXKit.h"

typedef void(^ReloadBlock)(void);

@interface AXEmptyDataHelper : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong)ReloadBlock reloadBlock;
/**
 * 占位图片名称
 */
@property (nonatomic, strong) UIImage *placeImageName;
/**
 * 占位文字
 */
@property (nonatomic, copy) NSString *placeTitle;

@end

@implementation AXEmptyDataHelper

///**
// *调用UITableView或者UICollectionView的［-reloadData］方法便会相应此方法。
// *并且 当且仅当列表数据源为空的时候才会触发。
// */
//- (void)reloadEmptyDataSet;

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.placeImageName;
}

/**
 * 设置默认空白界面图片的动画效果。
 */
//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
//
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
//
//    animation.duration = 0.25;
//    animation.cumulative = YES;
//    animation.repeatCount = MAXFLOAT;
//
//    return animation;
//}

//标题文本，详细描述，富文本样式
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.placeTitle;
    NSDictionary *attributes = @{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0f],
        NSForegroundColorAttributeName: [UIColor darkGrayColor]
    };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

////标题文本，详细描述，富文本样式
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
//
//    NSString *text = @"请下拉刷新数据";
//
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
//                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
//                                 NSParagraphStyleAttributeName: paragraph};
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}


//按钮文本或者背景样式
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.reloadBlock) {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
        return [[NSAttributedString alloc] initWithString:AXKitLocalizedString(@"点击刷新") attributes:attributes];
    }else{
        return nil;
        
    }
}

//刷新按钮背景图片,能显示按钮文字
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    
    switch (state) {
        case UIControlStateNormal:
            return  [UIImage ax_imageRectangleWithSize:CGSizeMake(100, 40) color:[UIColor blueColor]];
            break;
        case UIControlStateDisabled:
            return  [UIImage ax_imageRectangleWithSize:CGSizeMake(100, 40) color:[UIColor grayColor]];
            break;
        default:
            return nil;
            break;
    }
}

/**
 * 设置默认空白界面布局图片的前景色，默认为nil.
 */
//- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView{
//    return [UIColor redColor];
//}

//此外,您还可以调整垂直对齐的内容视图(即:有用tableHeaderView时可见):
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
////    if ([self isKindOfClass:[UITableView class]]) {
////        UITableView *view = (UITableView*)self;
////         return -view.tableHeaderView.frame.size.height/2.0f;
////    }
//    return -150;
//}

////每个控件的间隙
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
//    return 150;
//}

//委托实现

//要求知道空的状态应该渲染和显示 (默认是 YES) :
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{ return YES;}
//
////是否允许点击 (默认是 YES) :
//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{ return YES;}
//
////是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
//
////空白区域点击响应:
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{ // Do something}

//点击button 响应
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}
@end


@interface UIScrollView()


@property(nonatomic, strong) AXEmptyDataHelper *helper;

@end

@implementation UIScrollView (AXEmptyDataSet)


/**
 设置空集合view
 
 @param reloadBlock 刷新回调
 */
- (void)ax_emptyDataSetWithReloadBlock:(void(^)(void))reloadBlock{
    
    if (!self.helper) {
        self.helper =[[AXEmptyDataHelper alloc]init];
    }
    
    if (!self.helper.placeImageName) {
        self.helper.placeImageName = [UIImage imageNamed:@"ax_emptyData"];
    }
    if (self.helper.placeTitle.length==0) {
        self.helper.placeTitle = @"亲,该页面暂无数据";
    }
    
    self.emptyDataSetSource = self.helper;
    self.emptyDataSetDelegate = self.helper;
    self.helper.reloadBlock = reloadBlock;
    
}

/**
 设置空集合view
 
 @param imageName 占位图片名称
 @param title 占位文字
 @param reloadBlock 刷新回调
 */
- (void)ax_emptyDataWithImage:(UIImage *)image titlte:(NSString *)title reloadBlock:(void(^)(void))reloadBlock{
    
    self.helper =[[AXEmptyDataHelper alloc]init];
    self.helper.placeImageName =image;
    self.helper.placeTitle =title;
    [self ax_emptyDataSetWithReloadBlock:reloadBlock];
}


#pragma mark - set and get

- (AXEmptyDataHelper *)helper {
    return objc_getAssociatedObject(self,@selector(helper));
//    AXEmptyDataHelper * obj = objc_getAssociatedObject(self,@selector(helper));
//
//    if (obj == nil) {
//        NSLog(@"obj == nil");
//        obj = [[AXEmptyDataHelper alloc]init];
//    }
//    NSLog(@"obj == nil %@",obj);
//    return obj;
}
- (void)setHelper:(AXEmptyDataHelper *)helper {
    objc_setAssociatedObject(self, @selector(helper),helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
//#endif
