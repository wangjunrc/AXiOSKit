# AXTransitioningObserver

[![CI Status](https://img.shields.io/travis/axinger/AXTransitioningObserver.svg?style=flat)](https://travis-ci.org/axinger/AXTransitioningObserver)
[![Version](https://img.shields.io/cocoapods/v/AXTransitioningObserver.svg?style=flat)](https://cocoapods.org/pods/AXTransitioningObserver)
[![License](https://img.shields.io/cocoapods/l/AXTransitioningObserver.svg?style=flat)](https://cocoapods.org/pods/AXTransitioningObserver)
[![Platform](https://img.shields.io/cocoapods/p/AXTransitioningObserver.svg?style=flat)](https://cocoapods.org/pods/AXTransitioningObserver)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AXTransitioningObserver is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AXTransitioningObserver'
```

## Author

axinger, axinger@outlook.com
```
#import <AXAlertTransitioningObserver/UIViewController+AXTransitioning.h>
```
- 在对应ViewControlle 重写此方法
```
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self ax_alertObserver:^(AXAlertTransitioningObserver *observer) {
            observer.alertControllerStyle = AXAlertControllerStyleCentre;
        }];
    }
    return self;
}
```
```
/// 调用者自控制是否点击空白页面 消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
```

## License

AXTransitioningObserver is available under the MIT license. See the LICENSE file for more info.
