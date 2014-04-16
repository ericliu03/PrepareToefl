//
//  ListeningChooseViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-4-15.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "ListeningChooseViewController.h"

@interface ListeningChooseViewController (){
    NSMutableArray *listeningFileArray;
}

@end

@implementation ListeningChooseViewController

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
    [self fileManagerController];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
}


-(void) fileManagerController {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSString *filePath = [self documentsDirectory];
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc]init];
    listeningFileArray = [[NSMutableArray alloc]initWithArray:[fileManager contentsOfDirectoryAtPath:filePath error:&error]];
    
    for (int i = [listeningFileArray count] - 1; i >= 0; i --) {
        if ([listeningFileArray[i] rangeOfString:@"mp3"].length <= 0) {
            [indexSet addIndex:i];
        }
    }
    [listeningFileArray removeObjectsAtIndexes:indexSet];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [listeningFileArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListeningFiles" forIndexPath:indexPath];
 
 // Configure the cell...
    UILabel *label = (UILabel *)cell;
    label.text = listeningFileArray[indexPath.row];
 
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    ListeningViewController *controller = (ListeningViewController*)segue.destinationViewController;
    //controller.delegate = self;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

    controller.fileName = listeningFileArray[indexPath.row];
}


@end
