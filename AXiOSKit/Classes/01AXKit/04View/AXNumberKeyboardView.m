//
//  AXNumberKeyboardView.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/1/15.
//

#import "AXNumberKeyboardView.h"
#import "UIKit+AXAssistant.h"
#import "UIImage+AXBundle.h"
#import "NSBundle+AXBundle.h"
#import <Masonry/Masonry.h>

#import "UIColor+AXKit.h"

@implementation  AXNumberKeyboardConfig




@end

@interface AXNumberKeyboardNumCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIImageView *tipImageView;

@end

@implementation AXNumberKeyboardNumCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.tipImageView];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.mas_equalTo(35);
        }];
        
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return self;
}
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:26];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor ax_colorWithNormalStyle:UIColor.blackColor darkStyle:UIColor.whiteColor];
    }
    return _textLabel;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc]init];
    }
    return _tipImageView;
}

@end


@interface AXNumberKeyboardView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong,readwrite) AXNumberKeyboardConfig *config;

/// 左边 12个小的
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray<NSString*> *leftTitleArray;
@property(nonatomic, strong) UIButton *confirmBtn;
@property(nonatomic, strong) UIButton *deleteBtn;
@property(nonatomic, strong) UIView *rightView;
@property(nonatomic, copy) NSString *symbolStr;

@end

@implementation AXNumberKeyboardView


static NSString *identifier = @"AXNumberKeyboardNumCell";

static NSString *keyboardIcon = @"keyboard";


- (instancetype)initWithConfig:(AXNumberKeyboardConfig *)config {
    
    if([self init]){
        self.config = config;
        
        switch (config.inputType){
                // 浮点数键盘
            case AXNumberKeyboardTypeFloat:{
                self.symbolStr = @".";
                break;
            }
                // 身份证键盘
            case AXNumberKeyboardTypeIDCard:{
                self.symbolStr  = @"X";
                break;
            }
                // 数字键盘
            default:{
                self.symbolStr = @"";
                break;
            }
        }
        
        
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect rec = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 216+ax_safe_area_insets_bottom());
    frame = rec;
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

-(void)_initUI {
    self.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.groupTableViewBackgroundColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    [self addSubview:self.rightView];
    [self.rightView addSubview:self.deleteBtn];
    [self.rightView addSubview:self.confirmBtn];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-ax_safe_area_insets_bottom());
        make.width.equalTo(self).multipliedBy(0.75);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.collectionView);
        make.right.mas_equalTo(0);
        make.left.equalTo(self.collectionView.mas_right);
    }];
    
    [@[self.deleteBtn,self.confirmBtn] mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:1 leadSpacing:0 tailSpacing:0];
    
    [@[self.deleteBtn,self.confirmBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.equalTo(self.rightView).multipliedBy(0.5);
    }];
    
}

-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.leftTitleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AXNumberKeyboardNumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSString *text = self.leftTitleArray[indexPath.item];
    if (![text isEqualToString:keyboardIcon]) {
        cell.textLabel.hidden = NO;
        cell.tipImageView.hidden = YES;
        cell.textLabel.text = text;
    }else {
        cell.textLabel.hidden = YES;
        cell.tipImageView.hidden = NO;
        cell.textLabel.text = @"";
        cell.tipImageView.image = [UIImage axBundle_imageNamed:@"ax_resign"];
    }
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text  = self.leftTitleArray[indexPath.item];
    
    if (text.length==0) {
        return;
    }
    if ([text isEqualToString:keyboardIcon] || text.length==0) {
        [self endEditing];
        return;
    }
    
    if (self.config.inputType == AXNumberKeyboardTypeFloat) {
        
        if ([self.config.textInput.text containsString:self.symbolStr]) {
            if (![text isEqualToString:self.symbolStr]) {
                [self.config.textInput insertText:text];
            }
        }else {
            if (!(self.config.textInput.text.length==0 && [text isEqualToString:self.symbolStr])) {
                [self.config.textInput insertText:text];
            }
        }
        
    } else  if (self.config.inputType == AXNumberKeyboardTypeIDCard){
        // 身份证X 不能以x开头,包含了x就不能再输入
        if(![self.config.textInput.text containsString:self.symbolStr]){
            if (!(self.config.textInput.text.length==0 && [text isEqualToString:self.symbolStr])) {
                [self.config.textInput insertText:text];
            }
        }
        
    }else {
        
        if(self.config.interval && (self.config.textInput.text.length+1) % ([self.config.interval integerValue] + 1) == 0){
            [self.config.textInput insertText:@" "];
        }
        
        if (self.config.textInput.delegate && [self.config.textInput.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            
            NSRange range = NSMakeRange(self.config.textInput.text.length, 0);
            BOOL aBool = [self.config.textInput.delegate textField:self.config.textInput shouldChangeCharactersInRange:range replacementString:text];
            
            if (aBool) {
                [self.config.textInput insertText:text];
            }
            
        }else{
            [self.config.textInput insertText:text];
        }
        
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = collectionView.bounds.size.width/3.0;
    CGFloat height = collectionView.bounds.size.height/4.0;
    return  CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

///3、设置最小行间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

/// 4、设置最小列间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


#pragma mark - action
-(void)deleteAction:(UIButton *)btn{
    [self.config.textInput deleteBackward];
}

-(void)confirmAction:(UIButton *)btn{
    [self endEditing];
    if (self.handler) {
        self.handler();
    }
}

-(void)endEditing{
    [self.config.textInput resignFirstResponder];
    if (self.config.textInput.delegate && [self.config.textInput.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.config.textInput.delegate textFieldDidEndEditing:self.config.textInput];
    }
}

#pragma mark - get
- (NSString *)symbolStr {
    if (!_symbolStr) {
        _symbolStr = @"";
    }
    return _symbolStr;
}
- (NSMutableArray *)leftTitleArray {
    if (!_leftTitleArray) {
        _leftTitleArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",self.symbolStr,@"0",keyboardIcon].mutableCopy;
    }
    return _leftTitleArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.alloc.init;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor =[UIColor ax_colorWithNormalStyle:UIColor.groupTableViewBackgroundColor];
        [_collectionView registerClass:AXNumberKeyboardNumCell.class forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

- (UIView *)rightView {
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
        _rightView.backgroundColor = UIColor.lightGrayColor;
    }
    return _rightView;
}
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        _deleteBtn.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.groupTableViewBackgroundColor];
        [_deleteBtn setImage:[UIImage axBundle_imageNamed:@"ax_delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteBtn.layer.borderWidth = 0.5;
        _deleteBtn.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _deleteBtn;
}
- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor ax_colorFromHexString:@"#00A0E9"];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteBtn.layer.borderWidth = 0.5;
        _deleteBtn.layer.borderColor = UIColor.lightGrayColor.CGColor;
    }
    return _confirmBtn;
}
@end
