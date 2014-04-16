//
//  CheckSeatViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-3-31.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoPutInViewController.h"
#import "GoCheckViewController.h"
#import "DataModel.h"
#import "UserInfo.h"
@class CheckSeatViewController;


@protocol CheckSeatViewControllerDelegate <NSObject>

-(void)CheckSeatViewControllerDidCancel:(CheckSeatViewController*)controller;

@end

@interface CheckSeatViewController : UITableViewController<InfoPutInViewControllerDelegate>

- (IBAction)Cancel:(id)sender;

@property(nonatomic,weak) id <CheckSeatViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *TextViewUserInfo;
@property(nonatomic, strong) DataModel *dataModel;
@end
