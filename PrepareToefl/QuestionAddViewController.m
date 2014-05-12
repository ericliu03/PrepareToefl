//
//  QuestionAddViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-4-14.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "QuestionAddViewController.h"

@interface QuestionAddViewController ()
@end

@implementation QuestionAddViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleTextField.delegate = self;
    self.Question1TextView.delegate = self;
    self.Question2TextView.delegate = self;

    
    if (self.questionToEdit != nil) {
        self.titleTextField.text = self.questionToEdit.title;
        self.Question1TextView.text = self.questionToEdit.question1;
        self.Question2TextView.text = self.questionToEdit.question2;
        self.doneButton.enabled = YES;
        self.navigationItem.title = @"Edit Question";
    }
    else {
        
        self.doneButton.enabled = NO;
        self.navigationItem.title = @"New Question";
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    if (textField == self.titleTextField) {
        [self.Question1TextView becomeFirstResponder];
    }
    return NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneButton.enabled = ([newText length] > 0);
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    self.doneButton.enabled = ([newText length] > 0);
    return YES;

}

- (IBAction)Done:(id)sender {
    if (self.questionToEdit == nil) {
        Questions *question = [[Questions alloc]init];
        question.title = self.titleTextField.text;
        question.question1 = self.Question1TextView.text;
        question.question2 = self.Question2TextView.text;
        
        [self.delegate QuestionAddViewController:self DidFinishAdding:question];
    }
    else {
        self.questionToEdit.title = self.titleTextField.text;
        self.questionToEdit.question1 = self.Question1TextView.text;
        self.questionToEdit.question2 = self.Question2TextView.text;
        
        [self.delegate QuestionAddViewController:self DidFinishEditing:self.questionToEdit];
    }
    
}
@end
