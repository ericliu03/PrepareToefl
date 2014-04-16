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
    


    UserInfo *user1 = self.dataModel.users[0];

    NSString *displayText = [NSString stringWithFormat:@" ID:%@ \n Password:%@ \n Date:%@ \n Province:%@", user1.neeaid, user1.password, user1.date, user1.province];
    self.TextViewUserInfo.text = displayText;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)Cancel:(id)sender{
    [self.delegate CheckSeatViewControllerDidCancel:self];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
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

-(void)InfoPutInViewController:(InfoPutInViewController*)controller DidDone:(UserInfo*)UserInfo{
    //NSLog([NSString stringWithFormat:@"%d",[self.dataModel.users count]]);
    [self.dataModel.users replaceObjectAtIndex:0 withObject:UserInfo];
    //NSLog([NSString stringWithFormat:@"%d",[self.dataModel.users count]]);
    [self.dataModel saveUserInfo];
    //读取传送来的userInfo来填入文本框
    NSString *displayText = [NSString stringWithFormat:@" ID:%@ \n Password:%@ \n Date:%@ \n Province:%@", UserInfo.neeaid, UserInfo.password, UserInfo.date, UserInfo.province];
    self.TextViewUserInfo.text = displayText;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
