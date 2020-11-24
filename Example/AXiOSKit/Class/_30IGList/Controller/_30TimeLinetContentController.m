//
//  _30TimeLinetContentController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_30TimeLinetContentController.h"
#import "_20TimeLineContentCell.h"
@implementation _30TimeLinetContentController

-(NSInteger)numberOfItems{
    
    if (self.model.luserName.length < 1) {
        return 0;
    }
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    
//    dgListCellModel *cm = [[dgListCellModel alloc]initWithModel:_object];
//    return CGSizeMake(SCREEN_WIDTH, cm.cellHeight);
    
    if (index==1) {
        return CGSizeMake(self.viewController.view.size.width/4.0, 120);
    }
    
    
    return CGSizeMake(self.viewController.view.size.width/4.0, 150);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    _20TimeLineContentCell *cell = [self.collectionContext dequeueReusableCellOfClass:[_20TimeLineContentCell class] forSectionController:self atIndex:index];
    [cell bindViewModel:self.model];
    return cell;
    
}

-(void)didUpdateToObject:(id)object{
    _model = object;
}

@end
