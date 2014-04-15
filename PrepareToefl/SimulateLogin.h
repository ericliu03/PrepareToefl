//
//  SimulateLogin.h
//  PrepareToefl
//
//  Created by Eric on 14-4-4.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SimulateLogin;

@protocol SimulateLoginDelegate <NSObject>

-(void)didFinished:(SimulateLogin*)controller;

@end

@interface SimulateLogin : NSObject

-(void)requestToURLWithGet:(NSString*)urlString withHeaders:(NSDictionary*)headers;
-(void)requestToURLWithPost:(NSString*)urlString withHeaders:(NSDictionary*)headers inMethod:(NSString*)httpMethod withHttpBody:(NSString*)httpBody;


@property(nonatomic, strong) NSString *dataInString;
@property(nonatomic, strong) NSDictionary *responseInDic;
@property(nonatomic, strong) NSData *receivedData;
@property(nonatomic, strong) id <SimulateLoginDelegate> delegate;
@end
