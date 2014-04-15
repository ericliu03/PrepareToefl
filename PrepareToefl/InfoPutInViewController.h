//
//  InfoPutInViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-3-31.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@class InfoPutInViewController;

@protocol InfoPutInViewControllerDelegate <NSObject>

-(void)InfoPutInViewControllerDidCancel:(InfoPutInViewController*)controller;
-(void)InfoPutInViewController:(InfoPutInViewController*)controller DidDone:(UserInfo*)userInfo;

@end

@interface InfoPutInViewController : UITableViewController<UITextFieldDelegate>

@property(nonatomic,weak) id <InfoPutInViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *textFieldID;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDate;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProvince;
@property (strong, nonatomic) UserInfo *UserInfoToEdit;
- (IBAction)Cancel:(id)sender;
- (IBAction)Done:(id)sender;

@end
