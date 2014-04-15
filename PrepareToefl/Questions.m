//
//  Questions.m
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "Questions.h"

@implementation Questions

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if((self = [super init])) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.question1 = [aDecoder decodeObjectForKey:@"question1"];
        self.question2 = [aDecoder decodeObjectForKey:@"question2"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.question1 forKey:@"question1"];
    [aCoder encodeObject:self.question2 forKey:@"question2"];
}

@end
