//
//  DLCompanyNewsViewController.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import "DLCompanyNewsViewController.h"
#import "DLCompanyNewsModel.h"
#import <Masonry/Masonry.h>
#import "DLCompanyNewsViewModel.h"
#define kCompanyNewsCacheData @"DLCompanyNewsCacheData"
#define kCompanyNewsCacheFileName @"DLCompanyNewscache.plist"

@interface DLCompanyNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) DLCompanyNewsViewModel *viewModel;

@property (nonatomic,strong)NSMutableArray<DLCompanyNewsModel *> *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic, assign)NSUInteger startNum;
@property(nonatomic, assign)NSUInteger endNum;

@end

@implementation DLCompanyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.viewModel =[[DLCompanyNewsViewModel alloc]initWithTableView:self.tableView];

    
    [self loadUI];
    
    [self getNewsListsNetwork];
}

-(CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [self.viewModel dequeueReusableCellWithModel:self.dataArray[indexPath.row] cellForRowAtIndexPath:indexPath];
}


-(void)loadUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



#pragma mark -- 获取公司要闻列表网络请求
- (void)getNewsListsNetwork{
    self.startNum = 0;
    self.endNum = 15;
    
    
    for (int i=0; i<2; i++) {
        DLCompanyNewsModel *model = [[DLCompanyNewsModel alloc]init];
        model.type = DLCompanyNewsTypeOneSamllPicture;
        model.TITLE = @"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题";
        model.PUB_DATE = @"2020-01-01";
        model.TITLE_IMG_URL_ARRAY =@[ [NSString stringWithFormat:@"https://bing.ioliu.cn/v1/rand?key=b%d&w=200&h=100",i]].mutableCopy;
        [self.dataArray addObject:model];
    }
    
    for (int i=0; i<3; i++) {
        DLCompanyNewsModel *model = [[DLCompanyNewsModel alloc]init];
        model.type = DLCompanyNewsTypeMoreSamllPicture;
        model.TITLE = @"三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图三个图";
        model.PUB_DATE = @"2020-01-01";
        
        for (int j=0; j<3; j++) {
            [model.TITLE_IMG_URL_ARRAY addObject:[NSString stringWithFormat:@"https://bing.ioliu.cn/v1/rand?key=b%d&w=200&h=100",i]];
        }
        
        [self.dataArray addObject:model];
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    return;;
    
    
    
}

#pragma mark - set and get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = UIView.alloc.init;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 18, 0, 18);
        _tableView.separatorColor = [UIColor redColor];
        
    }
    return _tableView;
}

- (NSMutableArray<DLCompanyNewsModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
