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

@protocol GoCheckViewControllerDelegate <NSObject>

-(void)GoCheckViewControllerDidCancel:(GoCheckViewController*)controller;

@end

@interface GoCheckViewController : UITableViewController <SimulateLoginDelegate, UITextFieldDelegate>

@property(nonatomic,weak) id <GoCheckViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *identifyCodeImage;
@property (weak, nonatomic) IBOutlet UITextView *statesTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *codeInputFeild;
@property (strong, nonatomic) UserInfo *userInfo;

- (IBAction)sendIdentifyCode:(id)sender;

- (IBAction)beginButton:(id)sender;

- (IBAction)Cancel:(id)sender;


@end
