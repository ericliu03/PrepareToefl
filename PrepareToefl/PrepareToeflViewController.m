//
//  PrepareToeflViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-3-31.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "PrepareToeflViewController.h"

@interface PrepareToeflViewController ()

@end

@implementation PrepareToeflViewController{
    DataModel *_dataModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
        UINavigationController *navigationController = segue.destinationViewController;
        CheckSeatViewController *controller = (CheckSeatViewController*)navigationController.topViewController;
        _dataModel = [[DataModel alloc]init];
        controller.dataModel = _dataModel;
        controller.delegate = self;
}

- (void)CheckSeatViewControllerDidCancel:(CheckSeatViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PrepareViewControllerDidCancel:(PrepareViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
