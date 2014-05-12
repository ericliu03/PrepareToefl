//
//  CheckSeatViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-3-31.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "CheckSeatViewController.h"

@interface CheckSeatViewController ()

@end

@implementation CheckSeatViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UserInfo *user1 = self.dataModel.users[0];
    [self displayUserInfo:user1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (IBAction)Cancel:(id)sender{
    [self.delegate CheckSeatViewControllerDidCancel:self];
}

#pragma mark -Naviagtion
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"InfoPutIn"]) {
        
        InfoPutInViewController *controller = (InfoPutInViewController*)segue.destinationViewController;
        controller.UserInfoToEdit = self.dataModel.users[0];
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"GoCheck"]){
        
        GoCheckViewController *controller = (GoCheckViewController*) segue.destinationViewController;
        controller.userInfo = self.dataModel.users[0];
    }
    
}

#pragma mark - delegate

-(void)displayUserInfo:(UserInfo*)UserInfo{
    NSMutableString *dateToDisplay = [[NSMutableString alloc]init];
    NSMutableString *provinceToDisplay = [[NSMutableString alloc]init];
    
    for (NSString *date in UserInfo.date) {
        if (![date isEqualToString:@""]) {
            [dateToDisplay appendString:[NSString stringWithFormat:@"%@.", date]];
        }
    }
    
    for (NSString *province in UserInfo.province) {
        if (![province isEqualToString:@""]) {
            [provinceToDisplay appendString:[NSString stringWithFormat:@"%@.", province]];
        }
    }
    
    NSString *displayText = [NSString stringWithFormat:@" ID:%@ \n Password:%@ \n Date:%@ \n Province:%@", UserInfo.neeaid, UserInfo.password, dateToDisplay , provinceToDisplay];
    
    self.TextViewUserInfo.text = displayText;
}

-(void)InfoPutInViewController:(InfoPutInViewController*)controller DidDone:(UserInfo*)UserInfo{

    //传送来的userInfo存入文件
    [self.dataModel.users replaceObjectAtIndex:0 withObject:UserInfo];
    [self.dataModel saveUserInfo];
    //读取传送来的userInfo来填入文本框
    [self displayUserInfo:UserInfo];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
