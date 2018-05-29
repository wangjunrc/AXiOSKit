//
//  AXSinglePickVC.m
//  BigApple
//
//  Created by liuweixing on 2016/10/21.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXSinglePickVC.h"

typedef void(^Selectblock)(NSInteger index);

@interface AXSinglePickVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
/**
 * <#注释#>
 */
@property(nonatomic,copy)Selectblock selectblock;

@property (nonatomic, strong) NSArray  *dataArray;

/**
 * <#注释#>
 */
@property(nonatomic,assign)NSInteger showRow;


@end

@implementation AXSinglePickVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
       return self.dataArray[row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    if (component == 0) {
//        //        [pickerView selectedRowInComponent:1];
//        [pickerView reloadComponent:1];
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)caccelBtnEvents:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)enterBtnEvents:(UIButton *)sender {
    if (self.selectblock) {
        
        NSInteger selectComp = [self.pickerView selectedRowInComponent:0];
        self.selectblock(selectComp);
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}



/**
 单选

 @param dataArray 内容
 @param row 当前row
 @param block 回调
 */
-(void)didSelected:(NSArray <NSString *>*)dataArray showRow:(NSInteger )row block:(void(^)(NSInteger index))block{
    
    self.dataArray = dataArray;
    self.selectblock  = block;
    self.showRow = row;
    [self.pickerView reloadComponent:0];
    
    if (row<self.dataArray.count) {
        [self.pickerView selectRow:row inComponent:0 animated:YES];
    }
    
}


@end
