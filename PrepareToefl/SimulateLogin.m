//
//  SimulateLogin.m
//  PrepareToefl
//
//  Created by Eric on 14-4-4.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "SimulateLogin.h"

@implementation SimulateLogin{

    NSURLResponse *_response;
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
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response error:nil];
    //返回的数据处理
    self.receivedData = returnData;
    self.dataInString =[[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
    //NSLog(@"%@",self.dataInString);

    NSDictionary *fields = [response allHeaderFields];
    self.responseInDic = fields;

    [self.delegate didFinished:self];
}


-(void)requestToURLWithPost:(NSString*)urlString withHeaders:(NSDictionary*)headers inMethod:(NSString*)httpMethod withHttpBody:(NSString*)httpBody{
    //处理post的data

    NSData *postData = [httpBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    //NSString *urlString1 = @"http://toefl.etest.net.cn/en";
    NSURL *url=[[NSURL alloc]initWithString:urlString];
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];
    
    

    
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:postData];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:[headers objectForKey:@"Set-Cookie"] forHTTPHeaderField:@"Cookie"];

    NSHTTPURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response error:nil];
    //返回的数据处理
    self.receivedData = returnData;
    self.dataInString =[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    NSDictionary *fields = [response allHeaderFields];
    self.responseInDic = fields;
    
    [self.delegate didFinished:self];
}
    
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    _response = response;
//    NSLog(@"get the whole response");
//    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)_response;
//    NSDictionary *fields = [HTTPResponse allHeaderFields];
//    self.responseInDic = fields;
//    //NSLog(@"%@",[fields description]);
//    [self.receivedData setLength:0];
//}
//    
//    
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//    
//{
//    NSLog(@"get some data");
//    [self.receivedData appendData:data];
//}
//    
//    
//    
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSLog(@"Finished!!!");
//    self.dataInString = [[NSString alloc] initWithData:self.receivedData encoding:NSASCIIStringEncoding];
//    [self.delegate didFinished:self];
//}
//    
//    
//    
//    
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"Connection failed! Error - %@",
//          [error localizedDescription]
//        //,[[error userInfo] objectForKey:NSErrorFailingURLStringKey]
//        );
//}

    

@end
