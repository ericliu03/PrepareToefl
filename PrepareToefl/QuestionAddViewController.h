//
//  QuestionAddViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-4-14.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"

@class QuestionAddViewController;

@protocol QuestionAddViewControllerDelegate <NSObject>

-(void)QuestionAddViewController:(QuestionAddViewController*)controller DidFinishEditing:(Questions*)question;
-(void)QuestionAddViewController:(QuestionAddViewController*)controller DidFinishAdding:(Questions*)question;
@end

@interface QuestionAddViewController : UITableViewController < UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic,weak) id <QuestionAddViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *Question1TextView;
@property (weak, nonatomic) IBOutlet UITextView *Question2TextView;

@property (retain, nonatomic) Questions *questionToEdit;

- (IBAction)Done:(id)sender;

@end
