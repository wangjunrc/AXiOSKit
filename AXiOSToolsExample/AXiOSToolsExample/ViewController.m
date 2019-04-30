//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//
#import "ViewController.h"
#import "AAViewController.h"
#import "AXiOSTools.h"
#import "Person.h"
#import "Dog.h"
#import "NSString+AXTool.h"
#import "NSObject+AXRuntime.h"
#import "AAView.h"
#import "MSWeakTimer.h"
#import "BubbleLayer.h"

#define kPopupTriangleHeigh 5

#define kPopupTriangleWidth 6

#define kPopupTriangleTopPointX 3 * (self.frame.size.width - kPopupTriangleWidth)/ 20.0f

#define kBorderOffset       0//0.5f

@interface PopView : UIView

@property(nonatomic,strong)UILabel *label;

@end


@implementation PopView


- (instancetype)initWithFrame:(CGRect)frame

{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
        
    }
    
    return self;
    
}

- (void)initUI

{
    
    _label = [[UILabel alloc] init];
    
    _label.textColor = [UIColor ax_colorFromHexString:@"0x666666"];
    
    _label.font = [UIFont systemFontOfSize:11];
    
    _label.numberOfLines = 0;
    
    _label.text = @"地址作为评估贷款额度的重要依据，需精确到门牌号\n请按如下格式填写：\n小区类：XX路XX号XX小区XX栋XX室\n农村类：XX县XX镇XX村XX组\n大厦类：XX路XX号XX大厦XX层XX室";
    
    [self addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        
        make.centerX.mas_equalTo(self.mas_centerX);
        
        make.top.mas_equalTo(self.mas_top).mas_equalTo(20);
        
    }];
    
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    
    
    CGFloat viewW = rect.size.width;
    
    CGFloat viewH = rect.size.height;
    
    
    
    CGFloat strokeWidth = 0.2;
    
    CGFloat borderRadius = 5;
    
    CGFloat offset = strokeWidth + kBorderOffset;
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(context, kCGLineJoinRound); //
    
    CGContextSetLineWidth(context, strokeWidth); // 设置画笔宽度
    
    CGContextSetStrokeColorWithColor(context, [UIColor  ax_colorFromHexString:@"0x3082f2"].CGColor); // 设置画笔颜色
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // 设置填充颜色
    
    
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, borderRadius+offset, kPopupTriangleHeigh + offset);
    
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX - kPopupTriangleWidth / 2.0 + offset, kPopupTriangleHeigh + offset);
    
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX, offset);
    
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX + kPopupTriangleWidth / 2.0 +offset, kPopupTriangleHeigh+offset);
    
    
    
    CGContextAddArcToPoint(context, viewW-offset, kPopupTriangleHeigh+offset, viewW-offset, kPopupTriangleHeigh+offset + borderRadius, borderRadius-strokeWidth);
    
    CGContextAddArcToPoint(context, viewW-offset, viewH - offset, viewW-borderRadius-offset, viewH - offset, borderRadius-strokeWidth);
    
    CGContextAddArcToPoint(context, offset, viewH - offset, offset, viewH - borderRadius - offset, borderRadius-strokeWidth);
    
    CGContextAddArcToPoint(context, offset, kPopupTriangleHeigh + offset, viewW - borderRadius - offset, kPopupTriangleHeigh + offset, borderRadius-strokeWidth);
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

- (void)dismiss

{
    
    __weak __typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        weakSelf.alpha = 0;
        
        weakSelf.frame = CGRectMake(weakSelf.frame.origin.x + kPopupTriangleTopPointX , weakSelf.frame.origin.y, 0, 0);
        
    } completion:^(BOOL finished) {
        
        [_label removeFromSuperview];
        
        [weakSelf removeFromSuperview];
        
        
        
    }];
    
}


@end


@interface ViewController ()

@property(nonatomic, strong) Person* person;

@property(nonatomic, strong) Dog* dog;

@property(weak, nonatomic) IBOutlet UILabel* label;

@property(weak, nonatomic) IBOutlet UITextField* tf;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, strong) MSWeakTimer *timeer;
@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
    
    dispatch_queue_t ma =dispatch_get_main_queue();
    
//   self.timeer = [MSWeakTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(testActino) userInfo:nil repeats:YES dispatchQueue:ma];
}
-(void)testActino{
    
//    self.name = [NSString stringWithFormat:@"%ld",ax_randomFromTo(1, 1000)];
    
//    NSLog(@"self.name %@",self.name);
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {

//    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
//    aView.backgroundColor =[UIColor redColor];
//    [self.view addSubview:aView];
//    
//    BubbleLayer *bbLayer = [[BubbleLayer alloc]initWithSize:aView.size];
//   
//    
//    // 矩形框的圆角半径
//    bbLayer.cornerRadius = 5;
//    
//    // 凸起那部分暂且称之为“箭头”，下面的参数设置它的形状
//    bbLayer.arrowDirection = ArrowDirectionBottom;
//    bbLayer.arrowHeight = 15;   // 箭头的高度（长度）
//    bbLayer.arrowWidth = 15;    // 箭头的宽度
//    bbLayer.arrowPosition = 0.5;// 箭头的相对位置
//    bbLayer.arrowRadius = 3;    // 箭头处的圆角半径
//    
//    [aView.layer setMask:[bbLayer layer]];

    
    
    
//    self.label.backgroundColor = UIColor.greenColor;
//
    
   
//
    
}

#pragma mark - <UIPopoverPresentationControllerDelegate>



- (IBAction)btnAction:(id)sender {
//    NSURL *path = [[NSBundle mainBundle] URLForResource:@"HTML/home" withExtension:@"html"];
//   NSURL *path =   [NSBundle.ax_mainBundle URLForResource:@"AXHTML.bundle/index" withExtension:@"html"];
//     NSBundle *ax_mainBundle = [NSBundle ax_mainBundle];
//
//    NSBundle *ax_HTMLBundle = [NSBundle ax_HTMLBundle];
//
//    
//    NSString *url =    [[NSBundle ax_HTMLBundle] pathForResource:@"index" ofType:@"html"];
    
    NSURL *path = [[NSBundle ax_HTMLBundle] URLForResource:@"index" withExtension:@"html"];
    
    
    AXWKWebVC *web = [[AXWKWebVC alloc]init];
    web.loadURL =path;
    [self.navigationController pushViewController:web animated:YES];
    
//    NSLog(@"btnAction");
//    UIViewController *testVC = [[UIViewController alloc]init];
//    testVC.view.backgroundColor = UIColor.orangeColor;
//    testVC.preferredContentSize = CGSizeMake(240, 62);
//    testVC.modalPresentationStyle = UIModalPresentationPopover;
//    testVC.popoverPresentationController.delegate = self;
//    testVC.popoverPresentationController.sourceView = sender;
//    testVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
//    testVC.popoverPresentationController.passthroughViews =@[self.view];
////    testVC.popoverPresentationController.backgroundColor = [UIColor redColor];
//
//    if (@available(iOS 9.0, *)) {
//        testVC.popoverPresentationController.canOverlapSourceViewRect = YES;
//    } else {
//
//    }
//
//    [self presentViewController:testVC animated:YES completion:nil];
}

- (IBAction)btnAc2:(id)sender {
    NSLog(@"btnAc2");
}
@end

