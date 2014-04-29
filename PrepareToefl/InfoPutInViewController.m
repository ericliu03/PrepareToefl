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
    
    //显示已存信息
    self.textFieldDate1.text     = self.UserInfoToEdit.date[0];
    self.textFieldDate2.text     = self.UserInfoToEdit.date[1];
    self.textFieldDate3.text     = self.UserInfoToEdit.date[2];
    
    self.textFieldProvince1.text = self.UserInfoToEdit.province[0];
    self.textFieldProvince2.text = self.UserInfoToEdit.province[1];
    self.textFieldProvince3.text = self.UserInfoToEdit.province[2];
    
    
    [self.textFieldID becomeFirstResponder];
    self.textFieldID.delegate   = self;
    self.textFieldPassword.delegate  = self;
    self.textFieldDate1.delegate      = self;

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
        [self.textFieldDate1 becomeFirstResponder];
    }
    else if (textField == self.textFieldDate3){
        [self.textFieldProvince1 becomeFirstResponder];
    }
    return YES;
}

- (IBAction)Done:(id)sender {
    UserInfo *userInfo = [[UserInfo alloc]init];
    
    userInfo.neeaid = self.textFieldID.text ;
    userInfo.password = self.textFieldPassword.text;
    userInfo.date = [NSArray arrayWithObjects: self.textFieldDate1.text, self.textFieldDate2.text, self.textFieldDate3.text, nil];
    userInfo.province = [NSArray arrayWithObjects: self.textFieldProvince1.text, self.textFieldProvince2.text, self.textFieldProvince3.text, nil];

    [self.delegate InfoPutInViewController:self DidDone:userInfo];
}
@end
