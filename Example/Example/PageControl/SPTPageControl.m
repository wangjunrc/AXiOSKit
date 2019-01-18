//
//  SPTPageControl.m
//  SportsKit
//
//  Created by JD on 2018/4/27.
//  Copyright © 2018年 Suning Sports. All rights reserved.
//

#import "SPTPageControl.h"


@interface SPTIndicatorView : UIView

@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, strong) CALayer *indicatorLayer;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;

@end


@implementation SPTIndicatorView


static CGFloat diameter = 4;
static CGFloat selectedDiameter = 4;


- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, selectedDiameter, selectedDiameter)]) {
        self.indicatorLayer = [[CALayer alloc] init];
        [self.layer addSublayer:self.indicatorLayer];
        [self setupIndicatorLayer];
    }
    return self;
}


- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setupIndicatorLayer];
}


- (void)setupIndicatorLayer {
    if (self.selected) {
        self.indicatorLayer.frame = CGRectMake(-1.5, 0, selectedDiameter+3, selectedDiameter);
        self.indicatorLayer.cornerRadius = selectedDiameter / 2;
        self.indicatorLayer.backgroundColor = self.selectedColor.CGColor;
    } else {
        CGFloat margin = (selectedDiameter - diameter) / 2;
        self.indicatorLayer.frame = CGRectMake(margin, margin, diameter, diameter);
        self.indicatorLayer.cornerRadius = diameter / 2;
        self.indicatorLayer.backgroundColor = self.normalColor.CGColor;
    }
}


@end


@interface SPTPageControl()

@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, strong) NSMutableArray<SPTIndicatorView *> *pageIndicatorViews;

@end


@implementation SPTPageControl


@synthesize normalColor = _normalColor;
@synthesize selectedColor = _selectedColor;


- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (void)setup {
    self.spacing = 4;
    self.numberOfPages = 1;
    self.hidesForSinglePage = YES;
    self.pageIndicatorViews = [NSMutableArray array];
}


- (void)setNumberOfPages:(NSUInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self setupPageIndicators];
    [self invalidateIntrinsicContentSize];
}


- (void)setCurrentPage:(NSUInteger)currentPage {
    _currentPage = currentPage;
    [self updateSelectedPage];
}


- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self updateSelectedPage];
}


- (UIColor *)normalColor {
    if (nil == _normalColor) {
        _normalColor = [UIColor colorWithRed:184.0/255.0 green:184.0/255.0 blue:184.0/255.0 alpha:1];
    }
    return _normalColor;
}


- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [self updateSelectedPage];
}


- (UIColor *)selectedColor {
    if (nil == _selectedColor) {
        _selectedColor = [UIColor whiteColor];
    }
    return _selectedColor;
}


- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage = hidesForSinglePage;
    self.hidden = hidesForSinglePage & (self.numberOfPages <= 1);
}


- (CGSize)intrinsicContentSize {
    return CGSizeMake(self.numberOfPages*selectedDiameter + (self.numberOfPages - 1) * self.spacing, selectedDiameter);
}


- (void)setupPageIndicators {
    if (self.hidesForSinglePage && (self.numberOfPages <= 1)) {
        self.hidden = YES;
        return;
    }
    self.hidden = NO;
    for (UIView *view in self.pageIndicatorViews) {
        [view removeFromSuperview];
    }
    [self.pageIndicatorViews removeAllObjects];
    for (NSUInteger i = 0; i < self.numberOfPages; i ++) {
        SPTIndicatorView *indicatorView = [[SPTIndicatorView alloc] init];
        CGRect frame  = indicatorView.frame;
        frame.origin.x = i * (selectedDiameter + self.spacing);
        indicatorView.frame = frame;
        indicatorView.normalColor = self.normalColor;
        indicatorView.selectedColor = self.selectedColor;
        [self addSubview:indicatorView];
        [self.pageIndicatorViews addObject:indicatorView];
    }
}


- (void)updateSelectedPage {
    if (self.currentPage >= self.numberOfPages) {
        return;
    }
    [self.pageIndicatorViews enumerateObjectsUsingBlock:^(SPTIndicatorView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.normalColor = self.normalColor;
        obj.selectedColor = self.selectedColor;
        obj.selected = (self.currentPage == idx);
    }];
}


@end
