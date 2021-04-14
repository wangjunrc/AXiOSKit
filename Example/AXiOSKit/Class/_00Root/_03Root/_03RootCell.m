//
//  _03RootCell.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/4/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_03RootCell.h"

@implementation _03RootCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColor.orangeColor;
    }
    return self;
}

//UITableViewCell设置左右两边间距
- (void)setFrame:(CGRect)frame {
    frame.origin.x += 50;
    frame.size.width -= 2 * 50;
    [super setFrame:frame];
}


@end
