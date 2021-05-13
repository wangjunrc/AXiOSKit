//
//  _25_2_DiffableDataSource.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/5/13.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25_2_DiffableDataSource.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>

@interface _25_2_Persion :NSObject
@property(nonatomic, copy) NSString *name;
@end
@implementation _25_2_Persion
@end


@interface _25_2_Cell :UITableViewCell

@property(nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UIImageView  *logoImgView;

@end
@implementation _25_2_Cell

- (void)updateConfigurationUsingState:(UICellConfigurationState *)state {
    //    var content = self.defaultContentConfiguration().updated(for: state)
    //    UIListContentConfiguration *content = [[self defaultContentConfiguration] updatedConfigurationForState:state];
    
    [super updateConfigurationUsingState:state];
    
    UIBackgroundConfiguration *backConfig = [UIBackgroundConfiguration listGroupedCellConfiguration];
    
    if (state.isHighlighted || state.isSelected) {
        backConfig.backgroundColor = [UIColor greenColor];
    }
    backConfig.cornerRadius = 9.0;
    self.backgroundConfiguration = backConfig;
    
}

- (UICellConfigurationState *)configurationState {
    UICellConfigurationState *sate = [super configurationState];
    
    NSLog(@"configurationState=========");
    return sate;
}



@end



@interface _25_2_DiffableDataSource ()


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UITableViewDiffableDataSource<NSString*,_25_2_Persion *> *dataSource;

@property(nonatomic,strong)NSDiffableDataSourceSnapshot<NSString*,_25_2_Persion *> *currentSnapshot;

@end

@implementation _25_2_DiffableDataSource

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UITableViewDiffableDataSource";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    NSMutableArray<UIBarButtonItem *> *itemArr = NSMutableArray.array;
    
    {
        
        UIButton *btn = [UIButton.alloc init];
        [btn setTitle:@"row添加数据" forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.orangeColor;
        [btn addTarget:self action:@selector(_update) forControlEvents:UIControlEventTouchUpInside];
        [itemArr addObject:[UIBarButtonItem ax_itemByButton:btn]];
        
    }
    {
        
        UIButton *btn = [UIButton.alloc init];
        [btn setTitle:@"section添加数据" forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.orangeColor;
        [btn ax_addTargetBlock:^(UIButton * _Nullable button) {
            
        }];
        [itemArr addObject:[UIBarButtonItem ax_itemByButton:btn]];
        
    }
    self.navigationItem.rightBarButtonItems = itemArr;
    [self _update];
}

-(void)_update {
    
    NSMutableArray<_25_2_Persion *> *perArr0 = NSMutableArray.array;
    for (int i=0; i<1; i++) {
        _25_2_Persion *p = _25_2_Persion.alloc.init;
        p.name = [NSString stringWithFormat:@"row1-%d",i];
        [perArr0 addObject:p];
    }
    
    
    //往指定Section中添加数据
    
    [self.currentSnapshot appendItemsWithIdentifiers:perArr0 intoSectionWithIdentifier:self.currentSnapshot.sectionIdentifiers[0]];
    //往Section中添加数据，默认添加到最后一个Section中
    //    [self.currentSnapshot appendItemsWithIdentifiers:perArr0];
    NSMutableArray<_25_2_Persion *> *perArr1 = NSMutableArray.array;
    for (int i=0; i<2; i++) {
        _25_2_Persion *p = _25_2_Persion.alloc.init;
        p.name = [NSString stringWithFormat:@"row2-%d",i];
        [perArr1 addObject:p];
    }
    [self.currentSnapshot appendItemsWithIdentifiers:perArr1 intoSectionWithIdentifier:self.currentSnapshot.sectionIdentifiers[1]];
    [self.dataSource applySnapshot:self.currentSnapshot animatingDifferences:YES completion:^{
        
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"_25_2_Cell"];
    }
    return _tableView;
}

- (UITableViewDiffableDataSource<NSString *,_25_2_Persion *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[UITableViewDiffableDataSource<NSString*,_25_2_Persion *> alloc] initWithTableView:self.tableView cellProvider:^UITableViewCell * _Nullable(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, _25_2_Persion *person) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"_25_2_Cell" forIndexPath:indexPath];
            UIListContentConfiguration *contentConfig = [cell defaultContentConfiguration];
            contentConfig.text = person.name;
            cell.contentConfiguration = contentConfig;
            
            
            //            UIBackgroundConfiguration *backConfig =   [ UIBackgroundConfiguration listGroupedCellConfiguration];;
            //            UIBackgroundConfiguration *backConfig =   [cell backgroundConfiguration];;
            //            UIBackgroundConfiguration *backConfig =   [UIBackgroundConfiguration listSidebarCellConfiguration];
            //            backConfig.cornerRadius = 10;
            //            backConfig.backgroundColor = UIColor.orangeColor;
            //
            //            cell.backgroundConfiguration = backConfig;
            
            
            return cell;
        }];
        _dataSource.defaultRowAnimation = UITableViewRowAnimationFade;
        
    }
    return _dataSource;
}

- (NSDiffableDataSourceSnapshot<NSString *,_25_2_Persion *> *)currentSnapshot {
    if (!_currentSnapshot) {
        _currentSnapshot = [[NSDiffableDataSourceSnapshot<NSString *,_25_2_Persion *> alloc] init];
        
        NSArray<NSString *> *secArr = @[@"row0",@"row1"];
        
        //必须先创建Section才可以插入数据
        [_currentSnapshot appendSectionsWithIdentifiers:secArr];
    }
    return _currentSnapshot;
}
@end
