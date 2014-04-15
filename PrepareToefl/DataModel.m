//
//  DataModel.m
//  PrepareToefl
//
//  Created by Eric on 14-4-1.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
#pragma mark 获取沙盒地址

-(id)init{
    
    if((self =[super init])){
        
        [self loadUserInfo];
        [self loadQuestions];
        
    }
    return self;
}

-(NSString*)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
}

-(NSString*)dataFilePath:(NSString*)fileName{
    
    return [[self documentsDirectory]stringByAppendingPathComponent:fileName];
}

-(void)saveUserInfo{
    
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:self.users forKey:@"UserInfo"];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath:@"UserInfo.plist"] atomically:YES];
    
    
}

-(void)loadUserInfo{
    
    NSString *path = [self dataFilePath:@"UserInfo.plist"];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
        
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        self.users = [unarchiver decodeObjectForKey:@"UserInfo"];
        
        [unarchiver finishDecoding];
    }
    else {
        self.users = [[NSMutableArray alloc]initWithCapacity:20];
        UserInfo *firsttime = [[UserInfo alloc]init];
        [self.users addObject:firsttime];
  
    }
}

-(void)saveQuestions{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:self.Questions forKey:@"Questions"];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath:@"Questions.plist"] atomically:YES];

}

-(void)loadQuestions{
    
    NSString *path = [self dataFilePath:@"Questions.plist"];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        self.Questions = [unarchiver decodeObjectForKey:@"Questions"];
        
        [unarchiver finishDecoding];
    }
    else {
        self.Questions = [[NSMutableArray alloc]initWithCapacity:20];
        
        Questions *sampleQuestion1 = [[Questions alloc]init];
        sampleQuestion1.title = @"sampleQuestion 1";
        sampleQuestion1.question1 = @"Talk about a book you have read that was important to you for some reason. Explain why the book was important to you.   Give specific details and examples to explain your answer.";
        sampleQuestion1.question2 = @"Some people believe that television has had a positive influence on society. Others believe it has had a negative influence on society. Which do you agree with and why? Use details and examples to explain your opinion.";
        [self.Questions addObject:sampleQuestion1];
        
        Questions *sampleQuestion2 = [[Questions alloc]init];
        sampleQuestion2.title = @"sampleQuestion 2";
        sampleQuestion2.question1 = @"Choose a place you go to often that is important to you and explain why it is important. Please include specific details in your explanation.";
        sampleQuestion2.question2 = @"Some college students choose to take courses in a variety of subject areas in order to get a broad education. Others choose to focus on a single subject area in order to have a deeper understanding of that area. Which approach to course selection do you think is better for students and why?";
        [self.Questions addObject:sampleQuestion2];
    }
    
    
}



@end
