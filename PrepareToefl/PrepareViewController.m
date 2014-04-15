//
//  PrepareViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "PrepareViewController.h"
#import "SpeakingChooseTableViewController.h"

@interface PrepareViewController ()

@end

@implementation PrepareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Cancel:(id)sender {
    [self.delegate PrepareViewControllerDidCancel:self];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Speaking"]) {
        SpeakingChooseTableViewController *controller = segue.destinationViewController;
        controller.questions = self.dataModel.Questions;
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"Listening"]){
        
    }
    // Pass the selected object to the new view controller.
}

-(void)SpeakingChooseTableViewController:(SpeakingChooseTableViewController*)controller saveQuestion:(NSMutableArray*)questions{
    self.dataModel.Questions = questions;
    [self.dataModel saveQuestions];

}

@end
