//
//  UserInfo.m
//  PrepareToefl
//
//  Created by Eric on 14-3-31.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if((self = [super init])) {
        self.neeaid = [aDecoder decodeObjectForKey:@"neeaid"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.neeaid forKey:@"neeaid"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.province forKey:@"province"];
}

@end
