# 红包雨
```
- (IBAction)btnAction1:(id)sender {
[self startTime];

UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRed:)];
[self.view addGestureRecognizer:tap];

return;
//1.设置CAEmitterLayer
CAEmitterLayer *rainLayer = [CAEmitterLayer layer];

//2.在背景图上添加粒子图层
[self.view.layer addSublayer:rainLayer];
self.rainLayer = rainLayer;

//3.发射形状--线性
rainLayer.emitterShape = kCAEmitterLayerLine;
rainLayer.emitterMode = kCAEmitterLayerSurface;
rainLayer.emitterSize = self.view.frame.size;
rainLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, -10);

//4.配置Cell
CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
;
UIImage *contentImage = [UIImage ax_imageRectangleWithSize:CGSizeMake(400, 400) color:UIColor.redColor];

UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
btn.backgroundColor = UIColor.redColor;
[btn ax_addTargetBlock:^(UIButton * _Nullable button) {
NSLog(@">>>>>>>>>>>>");
}];

snowCell.contents = (id)[contentImage CGImage];
//    snowCell.contents = (id)btn;
snowCell.birthRate = 1.0;
snowCell.lifetime = 30;
snowCell.speed = 2;
snowCell.velocity = 10.f;
snowCell.velocityRange = 10.f;
snowCell.yAcceleration = 60;
snowCell.scale = 0.05;
snowCell.scaleRange = 0.f;
/*
@property(nullable, copy) NSArray<CAEmitterCell *> *emitterCells; // 用来装粒子的数组
@property float birthRate; // 粒子产生系数，默认1.0
@property float lifetime; // 粒子的生命周期系数, 默认1.0
@property CGPoint emitterPosition; // 决定了粒子发射形状的中心点
@property CGFloat emitterZPosition;
@property CGSize emitterSize; // 发射源的尺寸大小
@property CGFloat emitterDepth;
@property(copy) NSString *emitterShape; // 发射源的形状
@property(copy) NSString *emitterMode; // 发射模式
@property(copy) NSString *renderMode; // 渲染模式
@property BOOL preservesDepth;
@property float velocity; // 粒子速度系数, 默认1.0
@property float scale; // 粒子的缩放比例系数, 默认1.0
@property float spin; // 粒子的自旋转速度系数, 默认1.0
@property unsigned int seed; // 随机数发生器


CAEmitterCell常用属性

@property(nullable, copy) NSString *name; // 粒子名字， 默认为nil
@property(getter=isEnabled) BOOL enabled;
@property float birthRate; // 粒子的产生率，默认0
@property float lifetime; // 粒子的生命周期,以秒为单位。默认0
@property float lifetimeRange; // 粒子的生命周期的范围，以秒为单位。默认0
@property CGFloat emissionLatitude;// 指定纬度,纬度角代表了在x-z轴平面坐标系中与x轴之间的夹角，默认0:
@property CGFloat emissionLongitude; // 指定经度,经度角代表了在x-y轴平面坐标系中与x轴之间的夹角，默认0:
@property CGFloat emissionRange; //发射角度范围,默认0，以锥形分布开的发射角度。角度用弧度制。粒子均匀分布在这个锥形范围内;
@property CGFloat velocity; // 速度和速度范围，两者默认0
@property CGFloat velocityRange;
@property CGFloat xAcceleration; // x,y,z方向上的加速度分量,三者默认都是0
@property CGFloat yAcceleration;
@property CGFloat zAcceleration;
@property CGFloat scale; // 缩放比例, 默认是1
@property CGFloat scaleRange; // 缩放比例范围,默认是0
@property CGFloat scaleSpeed; // 在生命周期内的缩放速度,默认是0
@property CGFloat spin; // 粒子的平均旋转速度，默认是0
@property CGFloat spinRange; // 自旋转角度范围，弧度制,默认是0
@property(nullable) CGColorRef color; // 粒子的颜色,默认白色
@property float redRange; // 粒子颜色red,green,blue,alpha能改变的范围,默认0
@property float greenRange;
@property float blueRange;
@property float alphaRange;
@property float redSpeed; // 粒子颜色red,green,blue,alpha在生命周期内的改变速度,默认都是0
@property float greenSpeed;
@property float blueSpeed;
@property float alphaSpeed;
@property(nullable, strong) id contents; // 粒子的内容，为CGImageRef的对象
@property CGRect contentsRect;
@property CGFloat contentsScale;
@property(copy) NSString *minificationFilter;
@property(copy) NSString *magnificationFilter;
@property float minificationFilterBias;
@property(nullable, copy) NSArray<CAEmitterCell *> *emitterCells; // 粒子里面的粒子
@property(nullable, copy) NSDictionary *style;
*/
//5.添加到图层上
rainLayer.emitterCells = @[snowCell];

}

- (void)startTime
{
//     [self startRedPackerts];

__block int timeout = 5;
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
dispatch_source_set_event_handler(_timer, ^{
if ( timeout <= 0 )
{
dispatch_source_cancel(_timer);
dispatch_async(dispatch_get_main_queue(), ^{
[self startRedPackerts];
});
}
else
{
NSString * titleStr = [NSString stringWithFormat:@"%d",timeout];
dispatch_async(dispatch_get_main_queue(), ^{
self.label.text = titleStr;
});
timeout--;
}
});
dispatch_resume(_timer);
}
- (void)startRedPackerts
{
//    [self touchView];

//    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1/4.0) target:self selector:@selector(showRain) userInfo:nil repeats:YES];
//    [self.timer invalidate];

self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
[self showRain];
}];

[self.timer fire];
};

- (void)showRain
{
UIImage *contentImage = [UIImage ax_imageRectangleWithSize:CGSizeMake(400, 400) color:UIColor.redColor];

UIImageView * imageV = [UIImageView new];
imageV.image = contentImage;
imageV.frame = CGRectMake(0, 0, 44 , 62.5 );

CALayer *moveLayer = [CALayer new];
moveLayer.bounds = imageV.frame;
moveLayer.anchorPoint = CGPointMake(0, 0);
moveLayer.position = CGPointMake(0, -62.5 );
moveLayer.contents = (id)imageV.image.CGImage;
[self.view.layer addSublayer:moveLayer];
[self addAnimation:moveLayer];
}

- (void)addAnimation:(CALayer *)moveLayer
{
#define SCREEN_HEIGHT 800
CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
NSValue * A = [NSValue valueWithCGPoint:CGPointMake(arc4random() % 414, 0)];
NSValue * B = [NSValue valueWithCGPoint:CGPointMake(arc4random() % 414, SCREEN_HEIGHT)];
moveAnimation.values = @[A,B];
moveAnimation.duration = arc4random() % 200 / 100.0 + 3.5;
moveAnimation.repeatCount = 1;
moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
[moveLayer addAnimation:moveAnimation forKey:nil];

CAKeyframeAnimation * tranAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
CATransform3D r0 = CATransform3DMakeRotation(M_PI/180 * (arc4random() % 360 ) , 0, 0, -1);
CATransform3D r1 = CATransform3DMakeRotation(M_PI/180 * (arc4random() % 360 ) , 0, 0, -1);
tranAnimation.values = @[[NSValue valueWithCATransform3D:r0],[NSValue valueWithCATransform3D:r1]];
tranAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
tranAnimation.duration = arc4random() % 200 / 100.0 + 3.5;
//为了避免旋转动画完成后再次回到初始状态。
[tranAnimation setFillMode:kCAFillModeForwards];
[tranAnimation setRemovedOnCompletion:NO];
[moveLayer addAnimation:tranAnimation forKey:nil];

}
- (void)endAnimation
{
[self.timer invalidate];

for (NSInteger i = 0; i < self.view.layer.sublayers.count ; i ++)
{
CALayer * layer = self.view.layer.sublayers[i];
[layer removeAllAnimations];
}
}
- (void)clickRed:(UITapGestureRecognizer *)sender
{
CGPoint point = [sender locationInView:self.view];
for (int i = 0 ; i < self.view.layer.sublayers.count ; i ++)
{
CALayer * layer = self.view.layer.sublayers[i];
if ([[layer presentationLayer] hitTest:point] != nil)
{
NSLog(@"%d",i);

BOOL hasRedPacketd = !(i % 3) ;

UIImageView * newPacketIV = [UIImageView new];
if (hasRedPacketd)
{
newPacketIV.image = [UIImage imageNamed:@"rp_yes"];
newPacketIV.frame = CGRectMake(0, 0, 63.5, 74);
}
else
{
newPacketIV.image = [UIImage imageNamed:@"rp_no"];
newPacketIV.frame = CGRectMake(0, 0, 45.5, 76.5);
}

layer.contents = (id)newPacketIV.image.CGImage;

UIView * alertView = [UIView new];
alertView.layer.cornerRadius = 5;
alertView.frame = CGRectMake(point.x - 50, point.y, 100, 30);
[self.view addSubview:alertView];

UILabel * label = [UILabel new];
label.font = [UIFont systemFontOfSize:17];

if (!hasRedPacketd)
{
label.text = @"旺旺年！人旺旺";
label.textColor = [UIColor whiteColor];
}
else
{
NSString * string = [NSString stringWithFormat:@"+%d金币",i];
NSString * iString = [NSString stringWithFormat:@"%d",i];
NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:string];

[attributedStr addAttribute:NSFontAttributeName
value:[UIFont systemFontOfSize:27]
range:NSMakeRange(0, 1)];
[attributedStr addAttribute:NSFontAttributeName
value:[UIFont fontWithName:@"PingFangTC-Semibold" size:32]
range:NSMakeRange(1, iString.length)];
[attributedStr addAttribute:NSFontAttributeName
value:[UIFont systemFontOfSize:17]
range:NSMakeRange(1 + iString.length, 2)];
label.attributedText = attributedStr;
//                label.textColor = RGBA(255,223,14, 1);
}

[alertView addSubview:label];
[label mas_makeConstraints:^(MASConstraintMaker *make) {
make.centerX.equalTo(alertView.mas_centerX);
make.centerY.equalTo(alertView.mas_centerY);
}];

[UIView animateWithDuration:1 animations:^{
alertView.alpha = 0;
alertView.frame = CGRectMake(point.x- 50, point.y - 100, 100, 30);
} completion:^(BOOL finished) {
[alertView removeFromSuperview];
}];
}
}
}
```
