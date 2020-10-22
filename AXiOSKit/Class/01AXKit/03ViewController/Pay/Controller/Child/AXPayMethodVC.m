//
//  AXPayMethodVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/22.
//

#import "AXPayMethodVC.h"
#import <Masonry/Masonry.h>
#import "AXChoosePayStyleCell.h"
#import "AXiOSKit.h"

@interface AXPayMethodVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation AXPayMethodVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AXChoosePayStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:k_axCellID forIndexPath:indexPath];
    
    AXChoosePayModel *model = self.dataArray[indexPath.row];
    
    cell.logoImageView.image = model.iconImage;
    cell.nameLabel.text = model.name;
    
    if (self.dataArray[indexPath.row].isSelect) {
        
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray[indexPath.row].isSelect) {
        return;
    }
    for (AXChoosePayModel *pay in self.dataArray) {
        pay.select = NO;
    }
    self.dataArray[indexPath.row].select = YES;
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.didSelectBlock) {
        self.didSelectBlock(indexPath.row);
    }
}


- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.rowHeight = 80;
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [tableView registerNib:ax_NibClass(AXChoosePayStyleCell.class) forCellReuseIdentifier:k_axCellID];
        _tableView = tableView;
    }
    return _tableView;
}

@end
