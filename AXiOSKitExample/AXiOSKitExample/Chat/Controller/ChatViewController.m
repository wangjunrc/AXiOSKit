//
//  ChatViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/5.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "ChatViewController.h"
//#import <AXiOSKit/AXWebSocketEngine.h>
//#import "NSObject+AXKit.h"
#import "AXiOSKit/AXiOSKit.h"
#import "AXiOSKit/AXiOSFoundation.h"

#import "AXWebSocketEngine.h"
#import "ChatTextMessageModel.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@property (weak, nonatomic) IBOutlet UITextField *sendTF;

@end

@implementation ChatViewController


#define USER_A 100
#define USER_B 200


//#define USER_A 200
//#define USER_B 100

- (IBAction)sendAction:(id)sender {
    
    ChatTextMessageModel *model = [[ChatTextMessageModel alloc]init];
    model.userid = USER_A;
    model.toUserId = USER_B;
    model.content = self.sendTF.text;
    
    NSString *msg =[model mj_JSONString];
    
    AXWebSocketEngine.shared.sendMesssage = msg;
    self.toLabel.text = model.content;
    self.sendTF.text = nil;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [AXWebSocketEngine.shared connectServer:USER_A];
    
    AXWebSocketEngine.shared.didReceiveMessage = ^(NSString   * _Nonnull message) {
        NSLog(@"message>> %@",message);
       ChatTextMessageModel *model = [ChatTextMessageModel mj_objectWithKeyValues:message];
         NSLog(@"model>> %@",model);
         NSLog(@"model.content>> %@",model.content);
        
        self.fromLabel.text = model.content;
    };
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
