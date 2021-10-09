//
//  _3rdFSPagerViewController.m
//  AXiOSKit_Example
//
//  Created by axinger on 2021/10/9.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_3rdFSPagerViewController.h"
@import FSPagerView;
@import Masonry;
@import SDWebImage;
#import "_AXTestData.h"
@interface _3rdFSPagerViewController ()<UITableViewDataSource,UITableViewDelegate,FSPagerViewDataSource,FSPagerViewDelegate>



@property (strong, nonatomic) NSArray<NSString *> *transformerNames;
@property (assign, nonatomic) NSInteger typeIndex;

@property (strong  , nonatomic)  UITableView *tableView;
@property (strong  , nonatomic)  FSPagerView *pagerView;

@property (strong  , nonatomic) FSPageControl *pageControl;

@property (strong, nonatomic) NSArray<_AXImgModel *> *imageNames;

@end

@implementation _3rdFSPagerViewController

#pragma mark - Life cycle

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

- (FSPagerView *)pagerView {
    if (!_pagerView) {
        _pagerView = [FSPagerView.alloc init];
        [_pagerView registerClass:FSPagerViewCell.class forCellWithReuseIdentifier:NSStringFromClass(FSPagerViewCell.class)];
    }
    return _pagerView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.pagerView];
    self.pagerView.delegate = self;
    self.pagerView.dataSource = self;
    
    
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(120);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pagerView.mas_bottom).mas_equalTo(0);
        make.bottom.left.right.mas_equalTo(0);
    }];
    
    
    self.imageNames = [_AXTestData imgModelsWithCount:5];
    
    
    self.transformerNames = @[@"cross fading", @"zoom out", @"depth", @"linear", @"overlap", @"ferris wheel", @"inverted ferris wheel", @"coverflow", @"cubic"];
    [self.pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.pagerView.isInfinite = YES;
    self.typeIndex = 0;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.typeIndex = self.typeIndex;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.transformerNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.transformerNames[indexPath.row];
    cell.accessoryType = indexPath.row == self.typeIndex ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.typeIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Transformers";
}

#pragma mark - FSPagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FSPagerView *)pagerView
{
    return self.imageNames.count;
}

- (FSPagerViewCell *)pagerView:(FSPagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    FSPagerViewCell * cell = [pagerView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(FSPagerViewCell.class) atIndex:index];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageNames[index].url] placeholderImage:nil];
    return cell;
}

#pragma mark - FSPagerViewDelegate

- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
    [pagerView deselectItemAtIndex:index animated:YES];
    [pagerView scrollToItemAtIndex:index animated:YES];
}

#pragma mark - Private properties

- (void)setTypeIndex:(NSInteger)typeIndex
{
    _typeIndex = typeIndex;
    FSPagerViewTransformerType type;
    switch (typeIndex) {
        case 0: {
            type = FSPagerViewTransformerTypeCrossFading;
            break;
        }
        case 1: {
            type = FSPagerViewTransformerTypeZoomOut;
            break;
        }
        case 2: {
            type = FSPagerViewTransformerTypeDepth;
            break;
        }
        case 3: {
            type = FSPagerViewTransformerTypeLinear;
            break;
        }
        case 4: {
            type = FSPagerViewTransformerTypeOverlap;
            break;
        }
        case 5: {
            type = FSPagerViewTransformerTypeFerrisWheel;
            break;
        }
        case 6: {
            type = FSPagerViewTransformerTypeInvertedFerrisWheel;
            break;
        }
        case 7: {
            type = FSPagerViewTransformerTypeCoverFlow;
            break;
        }
        case 8: {
            type = FSPagerViewTransformerTypeCubic;
            break;
        }
        default:
            type = FSPagerViewTransformerTypeZoomOut;
            break;
    }
    self.pagerView.transformer = [[FSPagerViewTransformer alloc] initWithType:type];
    switch (type) {
        case FSPagerViewTransformerTypeCrossFading:
        case FSPagerViewTransformerTypeZoomOut:
        case FSPagerViewTransformerTypeDepth: {
            self.pagerView.itemSize = FSPagerViewAutomaticSize;
            self.pagerView.decelerationDistance = 1;
            break;
        }
        case FSPagerViewTransformerTypeLinear:
        case FSPagerViewTransformerTypeOverlap: {
            CGAffineTransform transform = CGAffineTransformMakeScale(0.6, 0.75);
            self.pagerView.itemSize = CGSizeApplyAffineTransform(self.pagerView.frame.size, transform);
            self.pagerView.decelerationDistance = FSPagerViewAutomaticDistance;
            break;
        }
        case FSPagerViewTransformerTypeFerrisWheel:
        case FSPagerViewTransformerTypeInvertedFerrisWheel: {
            self.pagerView.itemSize = CGSizeMake(180, 140);
            self.pagerView.decelerationDistance = FSPagerViewAutomaticDistance;
            break;
        }
        case FSPagerViewTransformerTypeCoverFlow: {
            self.pagerView.itemSize = CGSizeMake(220, 170);
            self.pagerView.decelerationDistance = FSPagerViewAutomaticDistance;
            break;
        }
        case FSPagerViewTransformerTypeCubic: {
            CGAffineTransform transform = CGAffineTransformMakeScale(0.9, 0.9);
            self.pagerView.itemSize = CGSizeApplyAffineTransform(self.pagerView.frame.size, transform);
            self.pagerView.decelerationDistance = 1;
            break;
        }
        default:
            break;
    }
}
@end
