//
//  PrepareViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "SpeakingChooseTableViewController.h"
@class PrepareViewController;

@protocol PrepareViewControllerDelegate <NSObject>

-(void)PrepareViewControllerDidCancel:(PrepareViewController*)controller;

@end

@interface PrepareViewController : UIViewController <SpeakingChooseTableViewControllerDelegate>

@property(nonatomic, strong)DataModel *dataModel;
@property(nonatomic,weak) id <PrepareViewControllerDelegate> delegate;

@end
