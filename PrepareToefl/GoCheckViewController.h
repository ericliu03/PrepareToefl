//
//  GoCheckViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-4-4.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimulateLogin.h"
#import "UserInfo.h"

@class GoCheckViewController;


@interface GoCheckViewController : UITableViewController <SimulateLoginDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UserInfo *userInfo;

#pragma mark interface
@property (weak, nonatomic) IBOutlet UIImageView *identifyCodeImage;
@property (weak, nonatomic) IBOutlet UITextView *statesTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *codeInputFeild;

- (IBAction)sendIdentifyCode:(id)sender;
- (IBAction)beginButton:(id)sender;
- (IBAction)stopButton:(id)sender;




@end
