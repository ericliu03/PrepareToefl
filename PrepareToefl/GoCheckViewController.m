//
//  GoCheckViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-4-4.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "GoCheckViewController.h"

@interface GoCheckViewController ()

@end

@implementation GoCheckViewController {
    
    SimulateLogin *simulateLogin;
    NSThread *connectThread;
    NSDictionary *headers;
    BOOL goingFlag;
    BOOL goingFlagForSendButton;
}
#pragma mark - inits
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.codeInputFeild resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.codeInputFeild.clearsOnBeginEditing = YES;
    self.codeInputFeild.delegate = self;
    
    //reveal the tapboard when touch fields other than the textfield
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - CodeUrl
- (NSString*)getIdentifyCodeUrl1{
    NSDate *datenow = [NSDate date];
    double timeStemp = [datenow timeIntervalSince1970];
    NSString *codeUrl = [NSString stringWithFormat:@"http://toefl.etest.net.cn/en/%10.16fVerifyCode3.jpg",timeStemp];

    return codeUrl;
}

-(NSString*)getIdentifyCodeUrl2{
        NSString *matchString = @"/en/[^\\s]*.jpg";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchString options:0 error:&error];
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:simulateLogin.dataInString options:0 range:NSMakeRange(0, [simulateLogin.dataInString length])];
    NSRange resultRange = [firstMatch rangeAtIndex:0];
    NSString *result = [simulateLogin.dataInString substringWithRange:resultRange];
    //NSLog(@"%@",result);
    NSString *codeUrl = [NSString stringWithFormat:@"http://toefl.etest.net.cn%@",result];
    return codeUrl;
}

#pragma mark - deal with the contents



-(void) checkIsIDAndPassCorrect{
    
    NSString *matchString = [NSString stringWithFormat:@"NEEAID or password incorrect"];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchString options:0 error:&error];
    //NSLog(simulateLogin.dataInString);
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:simulateLogin.dataInString options:0 range:NSMakeRange(0, [simulateLogin.dataInString length])];
    if (firstMatch) {
        [self refreshStatesTextField:@"ID or Password incorrect."];
        [NSThread exit];
        
    }
    else {
       
    }
}


-(BOOL) checkIsVerifyCodeCorrect{
    NSString *matchString = [NSString stringWithFormat:@"stop16.gif"];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchString options:0 error:&error];
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:simulateLogin.dataInString options:0 range:NSMakeRange(0, [simulateLogin.dataInString length])];
    if (firstMatch) {
        [self refreshStatesTextField:@"VerifyCode incorrect, please try again"];
        return YES;
    }
    else {
        return NO;
        
    }
}


-(void) checkIsSeatAvailable{
    NSString *matchString = [NSString stringWithFormat:@"Seat available"];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchString options:0 error:&error];
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:simulateLogin.dataInString options:0 range:NSMakeRange(0, [simulateLogin.dataInString length])];
    if (firstMatch) {
        [self refreshStatesTextField:@"We have seats"];
    }
    else {
        [self refreshStatesTextField:@"Sorry, we do not have an seat"];
    }
}

#pragma mark - Buttons
- (IBAction)sendIdentifyCode:(id)sender {
    [self refreshStatesTextField:@"code received"];
    goingFlagForSendButton = YES;
}

- (IBAction)beginButton:(id)sender {
    
    goingFlag = NO;
    goingFlagForSendButton = NO;
    //make the states textview blank, ready for states
    self.statesTextFeild.text = @"";
    
    connectThread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    [connectThread setName:@"connectThread"];
    [connectThread start];
}

- (IBAction)stopButton:(id)sender {
   [connectThread cancel];
}

#pragma mark - refresh the view
-(void)setCodeImage{
    [self performSelectorOnMainThread:@selector(textFieldBecomeResponser) withObject:nil waitUntilDone:NO];
    self.identifyCodeImage.image = [UIImage imageWithData: simulateLogin.receivedData];
    [NSThread exit];

}
-(void)setCodeImageInNewThread{
    NSThread *setImageThread = [[NSThread alloc] initWithTarget:self selector:@selector(setCodeImage) object:nil];
    [setImageThread setName:@"setImageThread"];
    [setImageThread start];
}

-(void)textFieldBecomeResponser{
    [self.codeInputFeild becomeFirstResponder];
}

-(NSString*)getPresentTime{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd hh:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:now];
    return strDate;
}

-(void)refreshStatesTextField:(NSString*)stringToAppend{
    [self performSelectorOnMainThread:@selector(refreshStatesTextFieldInMainThread:) withObject:stringToAppend waitUntilDone:NO];
}


-(void)refreshStatesTextFieldInMainThread:(NSString*)stringToAppend{
    NSString *time = [self getPresentTime];
    self.statesTextFeild.text = [NSString stringWithFormat:@"%@ %@\n%@", time, stringToAppend, self.statesTextFeild.text];
}


#pragma mark - waits
-(void)checkIfThreadTerminated{
    if ([[NSThread currentThread] isCancelled]) {
        [self refreshStatesTextField:@"Check process terminated, press start to start over."];
        [NSThread exit];
    }
    else{
        [NSThread sleepForTimeInterval:0.1];
    }
}

//在wait函数中检测线程是否被终止
-(void)waitForGoingFlag{
    while (!goingFlag)[self checkIfThreadTerminated];
    goingFlag = NO;
}

-(void)waitForGoingFlagForSendButton{
    while (!goingFlagForSendButton)[self checkIfThreadTerminated];
    goingFlagForSendButton = NO;
}

-(void)waitForSeconds:(int)sec{
    [self refreshStatesTextField:[NSString stringWithFormat:@"wait the website for %d seconds",sec]];
    //check every 0.1 sec
    for (int i = 0; i < sec * 10; i ++) {
        [self checkIfThreadTerminated];
    }
    [NSThread sleepForTimeInterval:sec];
}

#pragma mark - the http request and delegate
-(void) runThread{
    headers = nil;
    NSString *mainUrl = @"http://toefl.etest.net.cn/en";
    NSString *loginUrl = @"http://toefl.etest.net.cn/en/TOEFLAPP";
    NSString *seatUrl = [NSString stringWithFormat:@"http://toefl.etest.net.cn/en/Information?page=SeatsQuery"];
    NSMutableString *checkUrl;
    NSString *postBodyForLogin;
    
    

    simulateLogin = [[SimulateLogin alloc]init];
    simulateLogin.delegate = self;
    
    do {
        //---------------- 1 -----------------
        [self refreshStatesTextField:@"step1 get cookie and code"];
        [simulateLogin requestToURLWithGet:(NSString*)mainUrl withHeaders:(NSDictionary*)headers];
        [self waitForGoingFlag];
        //get the code and display it in another thread
        [simulateLogin requestToURLWithGet:[self getIdentifyCodeUrl1] withHeaders:(NSDictionary*)headers];
        [self waitForGoingFlag];
        [self setCodeImageInNewThread];
    
    
        //---------------- 2 -----------------
        [self refreshStatesTextField:@"step2 input code and login"];
        //------wait for the send button pushed------
    
    
        [self waitForSeconds:5];
        [self waitForGoingFlagForSendButton];
        NSString *code1 = self.codeInputFeild.text;
        //post the id and password
        postBodyForLogin = [NSString stringWithFormat:@"username=%@&__act=__id.24.TOEFLAPP.appadp.actLogin&password=%@&LoginCode=%@&submit.x=22&submit.y=7",self.userInfo.neeaid, self.userInfo.password, code1];
        [simulateLogin requestToURLWithPost:loginUrl
                                withHeaders:headers
                                   inMethod:@"POST"
                               withHttpBody:postBodyForLogin];
        [self waitForGoingFlag];
        [self checkIsIDAndPassCorrect];
    }while ([self checkIsVerifyCodeCorrect]);

    [self refreshStatesTextField:@"Login success"];
   
    do {
        //---------------- 3 -----------------
        [self refreshStatesTextField:@"step3 get the code for check seat"];
        [self waitForSeconds:5];
        [simulateLogin requestToURLWithGet:seatUrl withHeaders:(NSDictionary*)headers];
        [self waitForGoingFlag];
        //get the code2
        [simulateLogin requestToURLWithGet:[self getIdentifyCodeUrl2] withHeaders:(NSDictionary*)headers];
        [self waitForGoingFlag];
        [self setCodeImageInNewThread];
    
    
        //---------------- 4 -----------------
        [self refreshStatesTextField:@"step4 check seat"];
        [self waitForSeconds:5];
        [self waitForGoingFlagForSendButton];
        NSString *code2 = self.codeInputFeild.text;
        checkUrl = [NSMutableString stringWithFormat:@"http://toefl.etest.net.cn/en/SeatsQuery?__act=__id.22.SeatsQuery.adp.actList&whichFirst=AS&afCalcResult=%@", code2];
        for (NSString *dates in self.userInfo.date) {
            if (![dates isEqualToString:@""]) {
                [checkUrl appendString:[NSString stringWithFormat:@"&mvfAdminMonths=%@", dates]];
            }
        }
        for (NSString *provinces in self.userInfo.province) {
            if (![provinces isEqualToString:@""]) {
                [checkUrl appendString:[NSString stringWithFormat:@"&mvfSiteProvinces=%@",provinces]];
            }
        }
        [simulateLogin requestToURLWithGet:checkUrl withHeaders:(NSDictionary*)headers];
        [self waitForGoingFlag];
    }while ([self checkIsVerifyCodeCorrect]);
    
    [self checkIsSeatAvailable];
    

    
}

-(void)didFinishLoading:(SimulateLogin*)controller{
    goingFlag = YES;
    headers = simulateLogin.responseInDic;

}

-(void)findWebsiteBusy:(SimulateLogin *)controller{
    [self refreshStatesTextField:@"Website busy"];
    [self waitForSeconds:3];//aim for check whether the user stopped
}

@end
