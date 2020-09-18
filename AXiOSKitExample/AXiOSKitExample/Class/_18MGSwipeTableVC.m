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

@interface _18MGSwipeTableVC ()

@end


@implementation _18MGSwipeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:MyMGSwipeTableCell.class forCellReuseIdentifier:@"cellID"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
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
    MGSwipeButton * button = cell.rightButtons.firstObject;
    button.selected = NO;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
