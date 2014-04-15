//
//  SpeakingChooseTableViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "SpeakingViewController.h"
#import "QuestionAddViewController.h"

@class SpeakingChooseTableViewController;

@protocol SpeakingChooseTableViewControllerDelegate <NSObject>

-(void)SpeakingChooseTableViewController:(SpeakingChooseTableViewController*)controller saveQuestion:(NSMutableArray*)questions;

@end

@interface SpeakingChooseTableViewController : UITableViewController <QuestionAddViewControllerDelegate>

@property(nonatomic, retain)NSMutableArray *questions;
@property (retain, nonatomic) Questions *questionToEdit;
@property(nonatomic,weak) id <SpeakingChooseTableViewControllerDelegate> delegate;

@end
