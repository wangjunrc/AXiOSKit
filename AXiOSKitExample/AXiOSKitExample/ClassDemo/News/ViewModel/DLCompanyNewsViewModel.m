//
//  DLCompanyNewsViewModel.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import "DLCompanyNewsViewModel.h"

#import <AXiOSKit/AXiOSKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface DLCompanyNewsViewModel ()

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic, assign)NSUInteger startNum;
@property(nonatomic, assign)NSUInteger endNum;

@end

@implementation DLCompanyNewsViewModel


-(instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView =tableView;
        [tableView registerClass:DLCompanyNewsOneSmallPictureCell.class forCellReuseIdentifier:DLCompanyNewsOneSmallPictureCell.identifier];
        [tableView registerClass:DLCompanyNewsMoreSmallPictureCell.class forCellReuseIdentifier:DLCompanyNewsMoreSmallPictureCell.identifier];
    }
    return self;
    
}


- (nonnull UITableViewCell *)dequeueReusableCellWithModel:(DLCompanyNewsModel *)model cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    UITableViewCell *resCell = nil;
    
    switch (model.type) {
        case DLCompanyNewsTypeText:
        {
            
        }
            break;
        case DLCompanyNewsTypeOneSamllPicture:
        {
            DLCompanyNewsOneSmallPictureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:DLCompanyNewsOneSmallPictureCell.identifier forIndexPath:indexPath];
            cell.titleLabel.text = model.TITLE;
            cell.dateLabel.text = model.PUB_DATE;
            [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.TITLE_IMG_URL_ARRAY.firstObject] placeholderImage:[UIImage imageNamed:@"1029x1029"]];
            resCell=cell;
        }
            break;
        case DLCompanyNewsTypeMoreSamllPicture:
        {
            DLCompanyNewsMoreSmallPictureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:DLCompanyNewsMoreSmallPictureCell.identifier forIndexPath:indexPath];
            cell.titleLabel.text = model.TITLE;
            cell.dateLabel.text = model.PUB_DATE;
            
            [model.TITLE_IMG_URL_ARRAY enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"URL = %@",obj);
                [cell.imageViewArray[idx] sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"1029x1029"]];
            }];
            resCell=cell;
            
        }
            break;
        case DLCompanyNewsTypeOneBigPicture:
        {
            
        }
            break;
        case DLCompanyNewsTypeOneVideo:
        {
            
        }
            break;
        default:
            break;
    }
    
    
    
    return resCell;
}



@end
