//
//  InfoPutInViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-3-31.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "InfoPutInViewController.h"

@interface InfoPutInViewController ()

@end

@implementation InfoPutInViewController

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
    //userinfotoedit是这个view的属性，是userinfo类的，这个类包含一个属性叫userinfodic，里面有内容
    self.textFieldID.text       = self.UserInfoToEdit.neeaid;
    self.textFieldPassword.text = self.UserInfoToEdit.password;
    self.textFieldDate.text     = self.UserInfoToEdit.date;
    self.textFieldProvince.text = self.UserInfoToEdit.province;
    [self.textFieldID becomeFirstResponder];
    self.textFieldID.delegate   = self;
    self.textFieldPassword.delegate  = self;
    self.textFieldDate.delegate      = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//按next键到下一行

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    if (textField == self.textFieldID) {
        [self.textFieldPassword becomeFirstResponder];
    }
    else if (textField == self.textFieldPassword) {
        [self.textFieldDate becomeFirstResponder];
    }
    else if (textField == self.textFieldDate){
        [self.textFieldProvince becomeFirstResponder];
    }
    return YES;
}

- (IBAction)Done:(id)sender {
    UserInfo *userInfo = [[UserInfo alloc]init];
    
    userInfo.neeaid = self.textFieldID.text ;
    userInfo.password = self.textFieldPassword.text;
    userInfo.date = self.textFieldDate.text;
    userInfo.province = self.textFieldProvince.text;

    [self.delegate InfoPutInViewController:self DidDone:userInfo];
}
@end
