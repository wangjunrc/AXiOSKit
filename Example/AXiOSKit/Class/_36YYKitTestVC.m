//
//  _36YYKitTestVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/17.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_36YYKitTestVC.h"
#import <YYKeyboardManager/YYKeyboardManager.h>
#import <YYText/YYText.h>
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>
#import <SDWebImageWebPCoder/UIImage+WebP.h>
@interface YYTextExampleEmailBindingParser :NSObject <YYTextParser>
@property (nonatomic, strong) NSRegularExpression *regex;
@end

@implementation YYTextExampleEmailBindingParser

- (instancetype)init {
    self = [super init];
    NSString *pattern = @"[-_a-zA-Z@\\.]+[ ,\\n]";
    self.regex = [[NSRegularExpression alloc] initWithPattern:pattern options:kNilOptions error:nil];
    return self;
}
- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)range {
    __block BOOL changed = NO;
    [_regex enumerateMatchesInString:text.string options:NSMatchingWithoutAnchoringBounds range:text.yy_rangeOfAll usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (!result) return;
        NSRange range = result.range;
        if (range.location == NSNotFound || range.length < 1) return;
        if ([text attribute:YYTextBindingAttributeName atIndex:range.location effectiveRange:NULL]) return;
        
        NSRange bindlingRange = NSMakeRange(range.location, range.length - 1);
        YYTextBinding *binding = [YYTextBinding bindingWithDeleteConfirm:YES];
        [text yy_setTextBinding:binding range:bindlingRange]; /// Text binding
        [text yy_setColor:[UIColor colorWithRed:0.000 green:0.519 blue:1.000 alpha:1.000] range:bindlingRange];
        changed = YES;
    }];
    return changed;
}

@end

@interface _36YYKitTestVC ()<YYKeyboardObserver,YYTextViewDelegate>

@end

@implementation _36YYKitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self _keyboard];
    [self _textView];
    [self _textLabel];
    
    [self _loadBottomAttribute];
}

-(void)_keyboard {
    // 获取键盘管理器
    YYKeyboardManager *manager = [YYKeyboardManager defaultManager];
    
    // 获取键盘的 view 和 window
    UIView *view = manager.keyboardView;
    UIWindow *window = manager.keyboardWindow;
    
    // 获取键盘当前状态
    BOOL visible = manager.keyboardVisible;
    CGRect frame = manager.keyboardFrame;
    NSLog(@"keyboardFrame = %@",NSStringFromCGRect(frame));
    frame = [manager convertRect:frame toView:self.view];
    NSLog(@"keyboardFrame convertRect = %@",NSStringFromCGRect(frame));
    
    
    // 监听键盘动画
    [manager addObserver:self];
    
    
    
    UITextField *tf = UITextField.alloc.init;
    tf.backgroundColor = UIColor.orangeColor;
    tf.placeholder = @"好好好";
    [self.containerView addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(40);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(60);
    }];
    self.bottomAttribute = tf.mas_bottom;
}

-(void)_textLabel {
    
    
    YYLabel *label = YYLabel.alloc.init;
    label.userInteractionEnabled = YES;
    label.numberOfLines = 3;
    label.font = [UIFont systemFontOfSize:16];
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [label layoutIfNeeded];
    label.preferredMaxLayoutWidth = label.width;
    
    self.bottomAttribute = label.mas_bottom;
    
    
    // 内置简单的表情解析
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser.alloc init];
    NSMutableDictionary *mapper = [NSMutableDictionary dictionary];
    mapper[@"[哈哈]"] = [UIImage imageNamed:@"learning_index_page_control_image_normal"];
    parser.emoticonMapper = mapper;
    
    label.textParser = parser;
    
    NSString *string = @"[哈哈]我已阅读并同意服务平台相关协议和条款《用户服务协议》《法律声明》";
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    [attributed setAttributes:@{
        NSForegroundColorAttributeName:UIColor.blueColor}
                        range:[string rangeOfString:@"《用户服务协议》"]];
    [attributed setAttributes:@{
        NSForegroundColorAttributeName:UIColor.systemPinkColor}
                        range:[string rangeOfString:@"《法律声明》"]];
    
    UIImage *image = [UIImage imageNamed:@"learning_index_page_control_image_current"];
    NSAttributedString *attrStr_image = [NSAttributedString yy_attachmentStringWithContent:image
                                                                               contentMode:UIViewContentModeScaleAspectFit
                                                                            attachmentSize:CGSizeMake(16, 16)
                                                                               alignToFont:label.font
                                                                                 alignment:YYTextVerticalAlignmentCenter];
    [attributed appendAttributedString:attrStr_image];
    
//
//        [attributed yy_setTextHighlightRange:[string rangeOfString:@"《法律声明》"]
//                                       color:[UIColor yellowColor]
//                             backgroundColor:[UIColor grayColor]
//                                   tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//            NSString *string = [text.string substringWithRange:range];
//            NSLog(@"点击高亮 = %@", string);
//        }];
    
    {
        YYTextHighlight *layHightlight = [[YYTextHighlight alloc] init];
//        YYTextHighlight *layHightlight = [YYTextHighlight highlightWithBackgroundColor:UIColor.blueColor];
        
        layHightlight.userInfo = @{@"title":@"第一个高亮"};
        [layHightlight setColor:UIColor.redColor];
        
        /// 长按的时候背景颜色
        YYTextShadow *layShadow = [YYTextShadow new];
        layShadow.color = UIColor.greenColor;
        layShadow.radius = 5;
        [layHightlight setShadow:layShadow];
        [attributed yy_setTextHighlight:layHightlight range:[string rangeOfString:@"《用户服务协议》"]];
        
    }
    {
        YYTextHighlight *layHightlight = [[YYTextHighlight alloc] init];
        layHightlight.userInfo = @{@"title":@"第二个高亮"};
        [layHightlight setColor:UIColor.orangeColor];
        
        YYTextShadow *layShadow = [YYTextShadow new];
        layShadow.color = UIColor.greenColor;
        layShadow.radius = 5;
        [layHightlight setShadow:layShadow];
        [attributed yy_setTextHighlight:layHightlight range:[string rangeOfString:@"《法律声明》"]];
    }
    
    
    label.attributedText = attributed;
    
    label.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        YYTextHighlight *highlight = [text yy_attribute:YYTextHighlightAttributeName atIndex:range.location];
        NSDictionary *userInfo = highlight.userInfo;
        NSString *string2 =  [text attributedSubstringFromRange:range].string;
        NSLog(@"string2 = %@, ",string2);
        NSString *string = [text.string substringWithRange:range];
        NSLog(@"点击高亮 = %@, userInfo = %@", string,userInfo);
    };
    
}
-(void)_textView {
    YYTextView *textView = YYTextView.alloc.init;
    textView.backgroundColor = [UIColor orangeColor];
    [self.containerView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(150);
    }];
    self.bottomAttribute = textView.mas_bottom;
    
    // 内置简单的 markdown 解析
//    YYTextSimpleMarkdownParser *parser = [YYTextSimpleMarkdownParser new];
//    [parser setColorWithDarkTheme];
    
    NSMutableDictionary *mapper = [NSMutableDictionary dictionary];
    
    ///根据不同的URL显示GIF
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3972" ofType:@"GIF"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *img = [UIImage sd_imageWithGIFData:data];
    mapper[@"[哈哈]"] = img;
    mapper[@"[pia]"] = [UIImage imageNamed:@"pia"];
    
//    mapper[@"[哈哈]"] = [UIImage imageNamed:@"learning_index_page_control_image_normal"];
    
    YYTextSimpleEmoticonParser *parser = YYTextSimpleEmoticonParser.alloc.init;
    parser.emoticonMapper = mapper;
    textView.textParser = parser;
    
//    textView.textParser = [YYTextExampleEmailBindingParser new];
    
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"aa[哈哈][pia]报表"];

//
//    [attributed setAttributes:@{
//        NSFontAttributeName:[UIFont systemFontOfSize:40],
//    }
//                        range:[attributed.string rangeOfString:@"[哈哈]"]];
    
    
    textView.attributedText = attributed;
    
}


- (void)keyboardChangedWithTransition:(YYKeyboardTransition)transition {
    CGRect fromFrame = [YYKeyboardManager.defaultManager convertRect:transition.fromFrame toView:self.view];
    CGRect toFrame =  [YYKeyboardManager.defaultManager convertRect:transition.toFrame toView:self.view];
    BOOL fromVisible = transition.fromVisible;
    BOOL toVisible = transition.toVisible;
    NSTimeInterval animationDuration = transition.animationDuration;
    UIViewAnimationCurve curve = transition.animationCurve;
    
    NSLog(@"fromFrame = %@",NSStringFromCGRect(fromFrame));
    
    CGRect frame = YYKeyboardManager.defaultManager.keyboardFrame;
    NSLog(@"keyboardFrame = %@",NSStringFromCGRect(frame));
    frame = [YYKeyboardManager.defaultManager convertRect:frame toView:self.view];
    NSLog(@"keyboardFrame convertRect = %@",NSStringFromCGRect(frame));
    
    
}


- (void)dealloc {
    [[YYKeyboardManager defaultManager] removeObserver:self];
}

@end
