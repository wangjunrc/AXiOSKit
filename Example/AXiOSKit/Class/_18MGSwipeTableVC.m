//
//  _18MGSwipeTableVC.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/17.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_18MGSwipeTableVC.h"
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface MyTableViewCell : UITableViewCell
@property(nonatomic, strong)UIImageView *imageView1;
@end

@implementation MyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"instruction.jpg"]];
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView1];
        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view);
            make.top.left.right.equalTo(self.contentView);
            make.width.equalTo(self.contentView);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.imageView1);
        }];
        
    }
    return self;
}
@end
@interface _18MGSwipeTableVC ()<MGSwipeTableCellDelegate>

@end

@interface MyMGSwipeTableCell : MGSwipeTableCell

@end

@implementation MyMGSwipeTableCell

@end

@interface _18MGSwipeTableVC ()<UISearchControllerDelegate,UISearchResultsUpdating,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UISearchController *searchController;


@property(nonatomic,copy)NSString *searchText;
@property(nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation _18MGSwipeTableVC
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIImage imageNamed:@"chongshe"];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:MyMGSwipeTableCell.class forCellReuseIdentifier:@"cellID"];
    self.tableView.tableFooterView = UIView.alloc.init;
    

//    self.tableView.emptyDataSetSource = tt;
//        self.tableView.emptyDataSetDelegate = tt;
    
//    [self.tableView ax_emptyDataWithImage:[UIImage imageNamed:@"chongshe"] titlte:@"刷新" reloadBlock:^{
//        NSLog(@"reloadBlockreloadBlockreloadBlockreloadBlockreloadBlock");
//    }];
    
//    AXEmptyDataSetConfig *config = AXEmptyDataSetConfig.alloc.init;
//    config.image = [UIImage imageNamed:@"no_data"];
//    NSString *str1 = @"没有朋友发照片";
//    NSString *str2 = @"您可以现在就拍一张";
//    NSString *str3 = [NSString stringWithFormat:@"%@\n%@",str1,str2];
//
//    NSMutableAttributedString *title = [NSMutableAttributedString.alloc initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
//
//    [title addAttributes:@{
//        NSForegroundColorAttributeName:[UIColor ax_colorFromHexString:@"#9D9D9D"],
//        NSFontAttributeName:[UIFont systemFontOfSize:15]
//    } range: [str3 rangeOfString:str1]];
//
//    [title addAttributes:@{
//        NSForegroundColorAttributeName:[UIColor ax_colorFromHexString:@"#9D9D9D"],
//        NSFontAttributeName:[UIFont systemFontOfSize:12]
//    } range: [str3 rangeOfString:str2]];
//
//    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragrahStyle setAlignment:NSTextAlignmentRight];
//        [title addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, str3.length)];
//
//    config.attributedTitle =title;
//    [self.tableView ax_emptyDataSetWithConfig:config];
    
   
    [self.tableView ax_setEmptyDataWithConfig:^(AXEmptyDataSetConfig *config) {
       
        config.image = [UIImage imageNamed:@"no_data"];
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
    
//        config.reload = ^{
//          
//        };
    }];
    
    
    
    
    
    //创建UISearchController
        self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        //设置代理
        self.searchController.delegate= self;
        self.searchController.searchResultsUpdater = self;
        //包着搜索框外层的颜色
        // self.searchController.searchBar.barTintColor = [UIColor lig];
        // self.searchController.searchBar.tintColor = [UIColor orangeColor];
        //提醒字眼
        self.searchController.searchBar.placeholder= @"搜索";
        //提前在搜索框内加入搜索词
//        self.searchController.searchBar.text = @"123";
        //设置UISearchController的显示属性，以下3个属性默认为YES
        //搜索时，背景变暗色
//        self.searchController.dimsBackgroundDuringPresentation = NO;
        //搜索时，背景变模糊
        //  self.searchController.obscuresBackgroundDuringPresentation = YES;

        //点击搜索的时候,是否隐藏导航栏
//        self.searchController.hidesNavigationBarDuringPresentation = YES;
        //位置
//        [_searchController.searchBar sizeToFit];
    
    
   
//    self.searchController.searchBar.top = 100;
    self.definesPresentationContext = YES;
    
//    if (@available(iOS 11.0, *)) {
//        self.navigationItem.searchController = self.searchController;
//    } else {
//        self.tableView.tableHeaderView = self.searchController.searchBar;
//    }
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.showsScopeBar = NO;
//    self.searchController.searchBar.showsSearchResultsButton = YES;
//    self.searchController.searchBar.showsCancelButton = YES;
//    self.searchController.searchBar.showsBookmarkButton = YES;
//    self.searchController.searchBar.shouldGroupAccessibilityChildren = YES;
    
    
    
    
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    //    if (self.searchController.active) {
    //        return 3;
    //    }
    
    
    NSLog(@"text = %@, active = %d",searchController.searchBar.text,self.searchController.active);
    self.searchText =searchController.searchBar.text;
    if (self.searchText.length>0) {
        int count = ax_randomFromTo(1, 5);
          [self.dataArray removeAllObjects];
          for (int i=0; i<count; i++) {
              [self.dataArray addObject:searchController.searchBar.text];
          }
          [self.tableView reloadData];
    }

}
- (void)didDismissSearchController:(UISearchController *)searchController{
//    searchController.searchBar.text = @"22";
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.searchController.active) {
//        return 3;
//    }
//    return 10;
    
    return self.dataArray.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%@",indexPath.row,self.searchText];
    cell.delegate = self;
    return cell;
}

#pragma mark - 侧滑 代理
-(BOOL) swipeTableCell:(nonnull MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction fromPoint:(CGPoint) point{
    return  direction == MGSwipeDirectionRightToLeft;
}
-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*) expansionSettings {
    
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  CGSize size =  [UIImage imageNamed:@"cell_right_delete_confirm"].size;
    MGSwipeButton * button = [MGSwipeButton buttonWithType:UIButtonTypeCustom];
    
    
    [button setEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    
    button.frame = CGRectMake(0, 0, size.width+10, size.height);
    [button setImage:[UIImage imageNamed:@"cell_right_delete"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"cell_right_delete_confirm"] forState:UIControlStateSelected];
    __block typeof(button)weakButton = button;
    __block typeof(self)weakSelf = self;
    button.callback = ^BOOL(MGSwipeTableCell * _Nonnull cell) {
        weakButton.selected = !weakButton.selected;
        if(weakButton.selected){
            
        }
        return  !weakButton.selected;
    };
    return @[button];
    
   
}

-(void) swipeTableCellWillEndSwiping:(nonnull MGSwipeTableCell *) cell{
    NSLog(@"swipeTableCellWillEndSwiping %ld",cell.rightButtons.count);
    MGSwipeButton * button =( MGSwipeButton *) cell.rightButtons.firstObject;
    button.selected = NO;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
@end
