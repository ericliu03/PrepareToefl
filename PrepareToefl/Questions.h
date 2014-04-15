//
//  Questions.h
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Questions : NSObject <NSCoding>
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *question1;
@property(nonatomic, copy)NSString *question2;

@end
