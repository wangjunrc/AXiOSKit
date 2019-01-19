//
//  SPTStyledPageControl.m
//  News
//
//  Created by zhangwei on 2018/4/28.
//  Copyright © 2018年 Suning Sports. All rights reserved.
//

#import "SPTStyledPageControl.h"


@interface SPTStyledPageControl ()

@property (nonatomic, strong) UIImageView *currentIndicatorView;
@property (nonatomic, strong) NSMutableArray *indicatorViews;
@property (nonatomic) NSUInteger oldPage;

@end


@implementation SPTStyledPageControl


- (instancetype)initWithFrame:(CGRect)frame indicatorMargin:(CGFloat)margin indicatorWidth:(CGFloat)indicatorWidth currentIndicatorWidth:(CGFloat)currentIndicatorWidth indicatorHeight:(CGFloat)indicatorHeight{
    self = [super initWithFrame:frame];
    if (self != nil) {
        _pageIndicatorColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        _currentPageIndicatorColor = [UIColor whiteColor];
        _indicatorViews = [NSMutableArray array];
        _currentPage = 0;
        _indicatorWidth = indicatorWidth;
        _indicatorMargin = margin;
        _currentIndicatorWidth = currentIndicatorWidth;
        _indicatorHeight = indicatorHeight;
    }
    return self;
}


- (void)setNumberOfPages:(NSUInteger)numberOfPages {
    if (numberOfPages == _numberOfPages) {
        return;
    }
    
    _numberOfPages = numberOfPages;
    //总宽度
    CGFloat contentViewWidth = self.currentIndicatorWidth + (CGFloat)(numberOfPages - 1) * self.indicatorWidth + ((CGFloat)(numberOfPages - 1) * self.indicatorMargin);
    CGFloat leftX = [UIScreen mainScreen].bounds.size.width - contentViewWidth - 26.0f;
    self.frame = CGRectMake(leftX, self.frame.origin.y, contentViewWidth, self.indicatorHeight);
    
    self.currentPage = 0; //设置成初始值，否则会错位
    [self setupUI];
}


- (void)setCurrentPage:(NSUInteger)currentPage {
    if (currentPage == _currentPage || currentPage < 0 || currentPage >= self.numberOfPages) {
        return;
    }
    
    UIView *currentIndicatorView = self.currentIndicatorView;
    UIView *exchangeIndicatorView = self.indicatorViews[currentPage];
    CGFloat offSetWidth = (self.currentIndicatorWidth - self.indicatorWidth) * 0.5f;
    CGFloat moreWith = self.currentIndicatorWidth + self.indicatorMargin;
    if (currentPage > _currentPage) {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint currentPoint = currentIndicatorView.center;
            currentIndicatorView.center = CGPointMake(exchangeIndicatorView.center.x - offSetWidth, exchangeIndicatorView.center.y);
            for (NSInteger i = self.currentPage + 1; i <= currentPage; i ++) {
                UIView *indicatorView = self.indicatorViews[i];
                indicatorView.center = CGPointMake(indicatorView.center.x - moreWith, currentPoint.y);
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint currentPoint = currentIndicatorView.center;
            currentIndicatorView.center = CGPointMake(exchangeIndicatorView.center.x + offSetWidth, exchangeIndicatorView.center.y);
            for (NSInteger i = currentPage; i < self.currentPage; i ++) {
                UIView *indicatorView = self.indicatorViews[i];
                indicatorView.center = CGPointMake(indicatorView.center.x + moreWith, currentPoint.y);
            }
        }];
    }
    
    [self.indicatorViews removeObjectAtIndex:_currentPage];
    [self.indicatorViews insertObject:self.currentIndicatorView atIndex:currentPage];
    
    _currentPage = currentPage;
}


- (void)setupUI {
    if (self.indicatorViews.count > 0) {
        for (UIImageView *view in self.indicatorViews) {
            [view removeFromSuperview];
        }
        [self.indicatorViews removeAllObjects];
    }
    // 添加选中的indicatorView
    [self.indicatorViews addObject:self.currentIndicatorView];
    [self addSubview:self.currentIndicatorView];
    
    // 创建普通indicatorView
    for (NSUInteger i = 0; i < self.numberOfPages - 1; i++) {
        
        UIImageView *prevImageView = self.indicatorViews[i];
        CGFloat leftX = prevImageView.frame.size.width + prevImageView.frame.origin.x + self.indicatorMargin;
        //indicatorViews
        UIImageView *indicatorView = [[UIImageView alloc]initWithFrame:CGRectMake(leftX, 0.0f, self.indicatorWidth, self.indicatorHeight)];
        indicatorView.layer.cornerRadius = self.indicatorHeight * 0.5f;
        indicatorView.layer.masksToBounds = YES;
        indicatorView.backgroundColor = self.pageIndicatorColor;
        indicatorView.center = CGPointMake(indicatorView.center.x, self.frame.size.height * 0.5f);
        [self addSubview:indicatorView];
        [self.indicatorViews addObject:indicatorView];
    }
}


- (UIView *)currentIndicatorView {
    if (_currentIndicatorView == nil) {
        _currentIndicatorView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.currentIndicatorWidth, self.indicatorHeight)];
        _currentIndicatorView.backgroundColor = self.currentPageIndicatorColor;
        _currentIndicatorView.layer.cornerRadius = self.indicatorHeight * 0.5f;
        _currentIndicatorView.layer.masksToBounds = YES;
        _currentIndicatorView.center = CGPointMake(_currentIndicatorView.center.x, self.frame.size.height * 0.5f);
    }
    return _currentIndicatorView;
}


@end
