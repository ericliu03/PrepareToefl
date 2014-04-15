//
//  DataModel.h
//  PrepareToefl
//
//  Created by Eric on 14-4-1.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "Questions.h"

@interface DataModel : NSObject

@property(nonatomic, strong)NSMutableArray *users;
@property(nonatomic, strong)NSMutableArray *Questions;

-(void)saveUserInfo;
-(void)saveQuestions;
@end
