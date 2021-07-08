//
//  _30TimeLineNinePhotoView.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_30TimeLineNinePhotoView.h"
#import "_30TimeLineNinePhotoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation _30TimeLineNinePhotoView

- (instancetype)initWithFrame:(CGRect)frame {

        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
        fl.minimumInteritemSpacing = 5;
        fl.minimumLineSpacing = 5;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"dgNinePhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"dgNinePhotoCollectionViewCell"];
    
        return [super initWithFrame:frame collectionViewLayout:fl];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picAry.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    _30TimeLineNinePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dgNinePhotoCollectionViewCell" forIndexPath:indexPath];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:self.picAry[indexPath.item]]];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.picAry.count == 1) {
        return CGSizeMake((self.bounds.size.width - 10) / 2, 180);
    }
    
    return CGSizeMake(60, 60);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //图片浏览功能，成熟优秀的轮子已很多，此处不在重复造
}
- (void)setPicAry:(NSArray *)picAry {
    
    _picAry = picAry;
    [self reloadData];
    
}
@end
