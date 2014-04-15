//
//  UserInfo.h
//  PrepareToefl
//
//  Created by Eric on 14-3-31.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject <NSCoding>
@property(nonatomic, copy) NSString *neeaid;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *province;

@end
