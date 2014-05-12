//
//  SimulateLogin.m
//  PrepareToefl
//
//  Created by Eric on 14-4-4.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "SimulateLogin.h"

@implementation SimulateLogin{
}

//因为是这个函数中使用的，所以要放在这里，在每次连接后查看是否繁忙并传回信息。
-(BOOL) checkIsWebsiteBusy{
    NSString *matchString = [NSString stringWithFormat:@"F5"];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchString options:0 error:&error];
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:self.dataInString options:0 range:NSMakeRange(0, [self.dataInString length])];
    if (firstMatch) {
        [self.delegate findWebsiteBusy:self];
        return YES;//YES means it is busy, so we keep on looping
    }
    else {
        return NO;
    }
}

-(void)requestToURLWithGet:(NSString*)urlString withHeaders:(NSDictionary*)headers{

    NSURL *url=[[NSURL alloc]initWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 10];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    if (headers != nil) {
        [request setValue:[headers objectForKey:@"Set-Cookie"] forHTTPHeaderField:@"Cookie"];
    }


    NSHTTPURLResponse *response;
    NSData *returnData;
    
    do {
        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        //返回的数据处理
        
        self.dataInString =[[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
        //NSLog(@"%@",self.dataInString);
    }while ([self checkIsWebsiteBusy]);
    
    NSDictionary *fields = [response allHeaderFields];
    self.responseInDic = fields;
    self.receivedData = returnData;

    [self.delegate didFinishLoading:self];
}


-(void)requestToURLWithPost:(NSString*)urlString withHeaders:(NSDictionary*)headers inMethod:(NSString*)httpMethod withHttpBody:(NSString*)httpBody{
    //处理post的data

    NSData *postData = [httpBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    NSURL *url=[[NSURL alloc]initWithString:urlString];
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];
    
    

    
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:postData];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:[headers objectForKey:@"Set-Cookie"] forHTTPHeaderField:@"Cookie"];

    NSHTTPURLResponse *response;
    NSData *returnData;
    do {
        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        //返回的数据处理
        self.receivedData = returnData;
        self.dataInString =[[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
    }while ([self checkIsWebsiteBusy]);
    
    NSDictionary *fields = [response allHeaderFields];
    self.responseInDic = fields;
    
    [self.delegate didFinishLoading:self];
}

    

@end
