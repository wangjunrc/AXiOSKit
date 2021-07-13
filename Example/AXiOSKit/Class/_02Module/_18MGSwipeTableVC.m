//
//  _18MGSwipeTableVC.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/17.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_18MGSwipeTableVC.h"
#import "_01ContentViewController.h"
@import MGSwipeTableCell;
@import AXiOSKit;

@interface _18MGSwipeTableVC ()<MGSwipeTableCellDelegate>

@end

@interface _18MGSwipeTableVC ()

@property(nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation _18MGSwipeTableVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"侧滑删除,ax_setEmptyDataWithConfig";
    
    [self.tableView registerClass:MGSwipeTableCell.class forCellReuseIdentifier:@"cellID"];
    self.tableView.tableFooterView = UIView.alloc.init;
    
    [self.tableView ax_setEmptyDataWithConfig:^(AXEmptyDataSetConfig *config) {
        
        config.image = [UIImage imageNamed:@"西瓜"];
        NSString *str1 = @"没有朋友发照片";
        NSString *str2 = @"您可以现在就拍一张";
        NSString *str3 = [NSString stringWithFormat:@"%@\n%@",str1,str2];
        NSMutableAttributedString *title = [NSMutableAttributedString.alloc initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
        
        [title addAttributes:@{
            NSForegroundColorAttributeName:[UIColor ax_colorFromHexString:@"#9D9D9D"],
            NSFontAttributeName:[UIFont systemFontOfSize:15]
        } range: [str3 rangeOfString:str1]];
        
        [title addAttributes:@{
            NSForegroundColorAttributeName:[UIColor ax_colorFromHexString:@"#9D9D9D"],
            NSFontAttributeName:[UIFont systemFontOfSize:12]
        } range: [str3 rangeOfString:str2]];
        config.attributedTitle =title;
        
                config.reload = ^{
                    NSLog(@"点击刷新");
                };
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:0 target:self action:@selector(itemActon)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"复原" style:0 target:self action:@selector(itemActon2)];
    
    self.navigationItem.rightBarButtonItems = @[item,item2];
    
}
-(void)itemActon{
    NSLog(@"itemActon======");
    self.dataArray = @[].mutableCopy;
    [self.tableView reloadData];
}

-(void)itemActon2{
    NSLog(@"itemActon======");
    self.dataArray = nil;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _01ContentViewController *vc = _01ContentViewController.alloc.init;
    
    [self ax_pushVC:vc];
    
}


#pragma mark - 侧滑 代理
-(BOOL) swipeTableCell:(nonnull MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction fromPoint:(CGPoint) point{
    return  direction == MGSwipeDirectionRightToLeft;
}

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*) expansionSettings {
    
    
    //    swipeSettings.transition = MGSwipeTransitionBorder;
    //
    //    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //    CGSize size =  [UIImage imageNamed:@"cell_right_delete_confirm"].size;
    //    MGSwipeButton * button = [MGSwipeButton buttonWithType:UIButtonTypeCustom];
    //
    //
    //    [button setEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    //
    //    button.frame = CGRectMake(0, 0, size.width+10, size.height);
    //    [button setImage:[UIImage imageNamed:@"cell_right_delete"] forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:@"cell_right_delete_confirm"] forState:UIControlStateSelected];
    
    
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    CGFloat padding = 10;
    UIImage *normalImage =  [UIImage imageNamed:@"cell_right_delete"];
    UIImage *selectedImage =  [UIImage imageNamed:@"cell_right_delete_confirm"];
    
    CGFloat max_width = normalImage.size.width;
    if (normalImage.size.width < selectedImage.size.width) {
        max_width = selectedImage.size.width;
    }
    
    CGFloat max_height = normalImage.size.height;
    if (normalImage.size.height < selectedImage.size.height) {
        max_height = selectedImage.size.height;
    }
    
    
    MGSwipeButton * button = [MGSwipeButton buttonWithType:UIButtonTypeCustom];
    [button setEdgeInsets:UIEdgeInsetsMake(0, 0, 0, padding)];
    button.frame = CGRectMake(0, 0, max_width+padding, max_height);
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    
    //    __block typeof(button)weakButton = button;
    __block typeof(self)weakSelf = self;
    button.callback = ^BOOL(MGSwipeTableCell * _Nonnull cell) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        /// 解决强引用
        MGSwipeButton * btn = ( MGSwipeButton *)cell.rightButtons.firstObject;
        if(btn.selected){
            NSIndexPath *indexPath = [strongSelf.tableView indexPathForCell:cell];
            [strongSelf deleteRowAction:indexPath];
        }
        btn.selected = !btn.selected;
        return  !btn.selected;
    };
    return @[button];
    
    
}

- (void)deleteRowAction:(NSIndexPath *)indexPath{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

-(void)swipeTableCellWillEndSwiping:(nonnull MGSwipeTableCell *) cell{
    
    NSLog(@"swipeTableCellWillEndSwiping %ld",cell.rightButtons.count);
    
    for ( MGSwipeButton * button in  cell.rightButtons) {
        button.selected = NO;
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        
        for (int i=0; i<10; i++) {
            [_dataArray addObject:[NSString stringWithFormat:@"data-%d",i]];
        }
        
    }
    return _dataArray;
}

- (void)dealloc {
    axLong_dealloc;
}
@end
