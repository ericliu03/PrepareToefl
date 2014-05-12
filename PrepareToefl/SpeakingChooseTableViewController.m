//
//  SpeakingChooseTableViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "SpeakingChooseTableViewController.h"

@interface SpeakingChooseTableViewController ()

@end

@implementation SpeakingChooseTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.questions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Questions" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *label = (UILabel *)cell;
    Questions *question;
    question = self.questions[indexPath.row];
    label.text = question.title;
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"Speaking"]) {
        SpeakingViewController *controller = (SpeakingViewController*)segue.destinationViewController;
        //controller.delegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Questions *question = self.questions[indexPath.row];
        controller.question = question;
    }
    else if ([segue.identifier isEqualToString:@"AddQuestion"]){
        QuestionAddViewController *controller = (QuestionAddViewController*)segue.destinationViewController;
        controller.delegate = self;
        controller.questionToEdit = nil;
        
    }
    else if ([segue.identifier isEqualToString:@"EditQuestion"]){
        QuestionAddViewController *controller = (QuestionAddViewController*)segue.destinationViewController;
        controller.delegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Questions *question = self.questions[indexPath.row];
        controller.questionToEdit = question;
    }
}

-(void)QuestionAddViewController:(QuestionAddViewController*)controller DidFinishEditing:(Questions*)question{
    [self.delegate SpeakingChooseTableViewController:self saveQuestion:self.questions];
    [self.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)QuestionAddViewController:(QuestionAddViewController*)controller DidFinishAdding:(Questions*)question{
    [self.questions addObject:question];
    [self.delegate SpeakingChooseTableViewController:self saveQuestion:self.questions];
    [self.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.questions removeObjectAtIndex:indexPath.row];
    [self.delegate SpeakingChooseTableViewController:self saveQuestion:self.questions];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
