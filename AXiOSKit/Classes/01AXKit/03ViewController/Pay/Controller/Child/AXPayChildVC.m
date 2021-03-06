//
//  AXPayChildVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/10/22.
//

#import "AXPayChildVC.h"
#import <Masonry/Masonry.h>
#import "AXiOSKit.h"
#import "AXChoosePayModel.h"
#import "AXPayMethodVC.h"

@interface AXPayChildItem : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *content;

@property (nonatomic) UITableViewCellAccessoryType accessoryType;

@end

@implementation AXPayChildItem

@end

@interface AXPayChildCell : UITableViewCell


@end

@implementation AXPayChildCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
@end


@interface AXPayChildVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *actionBtn;

@property(nonatomic, strong) NSArray<AXPayChildItem *> *dataArray;
@end

@implementation AXPayChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.ax_shouldNavigationBarHidden = YES;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    [self _footView];
//    self.navigationController.navigationBar.topItem.title = @"";
    
    
    UIImage *rightItme = [UIImage axBundle_imageNamed:@"ax_close"];
    self.navigationItem.rightBarButtonItem =  [UIBarButtonItem ax_itemOriginalImage:rightItme target:self action:@selector(closeBtnAction)];
    
}

-(void)_footView {
    UIView *footView = [UIView.alloc initWithFrame:CGRectMake(0, 0, 0, 80)];
    [self.view addSubview:footView];
    [footView addSubview:self.actionBtn];
    
    self.tableView.tableFooterView = footView;
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.actionBtn ax_addTargetBlock:^(UIButton * _Nullable button) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AXChoosePayModel *payModel = nil;
        
        for ( AXChoosePayModel *temp in strongSelf.payArray) {
            if(temp.isSelect){
                payModel= temp;
                break;;
            }
        }
        if (strongSelf.confirmPayBlock) {
            strongSelf.confirmPayBlock(payModel);
        }
        
    }];
}
- (void)closeBtnAction{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AXPayChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    AXPayChildItem *item = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =item.title;
    cell.detailTextLabel.text =item.content;
    cell.accessoryType =  self.dataArray[indexPath.row].accessoryType;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray[indexPath.row].accessoryType == UITableViewCellAccessoryNone ) {
        return;
    }
    
    AXPayMethodVC *payStyleVC = [AXPayMethodVC ax_init];
    payStyleVC.dataArray = self.payArray;
    payStyleVC.ax_controllerObserve.hiddenNavigationBar = YES;
    [self ax_pushVC:payStyleVC];
    __weak typeof(self) weakSelf = self;
    payStyleVC.didSelectBlock = ^(NSInteger row) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.dataArray[1].content = strongSelf.payArray[row].name;
        [strongSelf.tableView reloadData];
    };
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.rowHeight = 80;
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [tableView registerClass:AXPayChildCell.class forCellReuseIdentifier:@"cellID"];
        _tableView = tableView;
    }
    return _tableView;
}

- (UIButton *)actionBtn {
    if (!_actionBtn) {
        _actionBtn = [UIButton.alloc initWithFrame:CGRectMake(0, 0, 0, 60 )];
        [_actionBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        _actionBtn.backgroundColor = UIColor.orangeColor;
        _actionBtn.layer.cornerRadius = 10;
        _actionBtn.layer.masksToBounds = YES;
    }
    return _actionBtn;
}

- (NSArray<AXPayChildItem *> *)dataArray {
    if (!_dataArray) {
        NSMutableArray<AXPayChildItem *> *temp = [NSMutableArray array];
        {
            AXPayChildItem *item = [AXPayChildItem.alloc init];
            item.accessoryType = UITableViewCellAccessoryNone;
            item.title = @"订单信息";
            item.content = self.orderText;
            [temp addObject:item];
        }
        {
            AXPayChildItem *item = [AXPayChildItem.alloc init];
            item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            item.title = @"支付方式";
            if (self.payArray.count==0) {
                item.content = @"暂无";
            }else{
                for (AXChoosePayModel * pay in self.payArray ) {
                    if (pay.isSelect) {
                        item.content = pay.name;
                        break;
                    }
                }
            }
            
            [temp addObject:item];
        }
        {
            AXPayChildItem *item = [AXPayChildItem.alloc init];
            item.accessoryType = UITableViewCellAccessoryNone;
            item.title = @"金额";
            item.content = self.amountText;
            [temp addObject:item];
        }
        _dataArray = temp.copy;
    }
    return _dataArray;
}
@end
