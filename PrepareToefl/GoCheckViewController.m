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

@implementation GoCheckViewController{
    NSThread *connectThread;
    SimulateLogin *simulateLogin;
    NSDictionary *headers;
    BOOL goingFlag;
    BOOL goingFlagForSendButton;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.codeInputFeild resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.codeInputFeild resignFirstResponder];
    return YES;
}


- (NSString*)getIdentifyCodeUrl1{
    NSDate *datenow = [NSDate date];
    double timeStemp = [datenow timeIntervalSince1970];
    NSString *codeUrl = [NSString stringWithFormat:@"http://toefl.etest.net.cn/en/%10.16fVerifyCode3.jpg",timeStemp];
    
    //NSLog(codeUrl);
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

-(BOOL) checkIsSeatAvailable{
    NSString *matchString = [NSString stringWithFormat:@"Seat available"];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchString options:0 error:&error];
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:simulateLogin.dataInString options:0 range:NSMakeRange(0, [simulateLogin.dataInString length])];
    if (firstMatch) {
        return YES;
    }
    else return NO;
}

- (IBAction)sendIdentifyCode:(id)sender {
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

-(void)setImageOfCode{
    
    self.identifyCodeImage.image = [UIImage imageWithData: simulateLogin.receivedData];

}
-(void)setCodeImageInNewThread{
    NSThread *setImageThread = [[NSThread alloc] initWithTarget:self selector:@selector(setImageOfCode) object:nil];
    [setImageThread setName:@"setImageThread"];
    [setImageThread start];
    //turn the keyboard on after set the image
    [self performSelectorOnMainThread:@selector(textFieldBecomeResponser) withObject:nil waitUntilDone:NO];
}

-(NSString*)getPresentTime{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd hh:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:now];
    //[dateFormatter release];
    return strDate;
}
-(void)refreshStatesTextField:(NSString*)stringToAppend{
    [self performSelectorOnMainThread:@selector(refreshStatesTextFieldInMainThread:) withObject:stringToAppend waitUntilDone:NO];
}


-(void)refreshStatesTextFieldInMainThread:(NSString*)stringToAppend{
    NSString *time = [self getPresentTime];
    self.statesTextFeild.text = [NSString stringWithFormat:@"%@ %@\n%@", time, stringToAppend, self.statesTextFeild.text];
}
-(void)waitForGoingFlag{
    while (!goingFlag);
    goingFlag = NO;
}

-(void)textFieldBecomeResponser{
    [self.codeInputFeild becomeFirstResponder];
}

-(void)waitForGoingFlagForSendButton{
    
    while (!goingFlagForSendButton);
    goingFlagForSendButton = NO;
}
-(void)waitForseconds:(int)sec{
    [self refreshStatesTextField:[NSString stringWithFormat:@"wait the website for %d seconds",sec]];
    [NSThread sleepForTimeInterval:sec];
}
-(void) runThread{
    headers = nil;
    NSString *mainUrl = @"http://toefl.etest.net.cn/en";
    NSString *loginUrl = @"http://toefl.etest.net.cn/en/TOEFLAPP";
    NSString *seatUrl = [NSString stringWithFormat:@"http://toefl.etest.net.cn/en/Information?page=SeatsQuery"];
    NSString *checkUrl;
    NSString *postBodyForLogin;
    
    

    simulateLogin = [[SimulateLogin alloc]init];
    simulateLogin.delegate = self;
    
    
    NSLog(@"step1 get cookie and code");
    [self refreshStatesTextField:@"step1 get cookie and code"];
    [simulateLogin requestToURLWithGet:(NSString*)mainUrl withHeaders:(NSDictionary*)headers];
    [self waitForGoingFlag];
    //get the code with a thread
    [simulateLogin requestToURLWithGet:[self getIdentifyCodeUrl1] withHeaders:(NSDictionary*)headers];
    [self waitForGoingFlag];
    [self setCodeImageInNewThread];
    
    
    NSLog(@"step2 input code and login");
    [self refreshStatesTextField:@"step2 input code and login"];
    //------wait for the send button pushed------
    
    [self waitForseconds:5];
    [self waitForGoingFlagForSendButton];
    NSString *code1 = self.codeInputFeild.text;
    //-------post the id and password-------------
    postBodyForLogin =[NSString stringWithFormat:@"username=%@&__act=__id.24.TOEFLAPP.appadp.actLogin&password=%@&LoginCode=%@&submit.x=22&submit.y=7",self.userInfo.neeaid, self.userInfo.password, code1];
    [simulateLogin requestToURLWithPost:loginUrl withHeaders:headers inMethod:@"POST" withHttpBody:postBodyForLogin];
    [self waitForGoingFlag];
    //NSLog(simulateLogin.dataInString);
    
    
    NSLog(@"step3 get the code for check seat");
    [self refreshStatesTextField:@"step3 get the code for check seat"];
    [self waitForseconds:5];
    [simulateLogin requestToURLWithGet:seatUrl withHeaders:(NSDictionary*)headers];
    [self waitForGoingFlag];
    //NSLog(@"%@",simulateLogin.dataInString);
    //get the code2
    [simulateLogin requestToURLWithGet:[self getIdentifyCodeUrl2] withHeaders:(NSDictionary*)headers];
    [self waitForGoingFlag];
    [self setCodeImageInNewThread];
    
    NSLog(@"step4 check seat");
    [self refreshStatesTextField:@"step4 check seat"];
    [self waitForseconds:5];
    [self waitForGoingFlagForSendButton];
    NSString *code2 = self.codeInputFeild.text;
    checkUrl = [NSString stringWithFormat:@"http://toefl.etest.net.cn/en/SeatsQuery?__act=__id.22.SeatsQuery.adp.actList&whichFirst=AS&mvfAdminMonths=%@&mvfSiteProvinces=%@&afCalcResult=%@", self.userInfo.date, self.userInfo.province, code2];
    [simulateLogin requestToURLWithGet:checkUrl withHeaders:(NSDictionary*)headers];
    [self waitForGoingFlag];
    //NSLog(simulateLogin.dataInString);
    if ([self checkIsSeatAvailable]) {
        NSLog(@"yes");
        [self refreshStatesTextField:@"We have seats"];
    }else {
        
        NSLog(@"NO");
        [self refreshStatesTextField:@"Sorry, we do not have an seat"];
    }
    NSLog(@"finished");
    [self refreshStatesTextField:@"Check process finished"];
    

    
}

-(void)didFinished:(SimulateLogin*)controller{
    goingFlag = YES;
    NSLog(@"didfinished");
    headers = simulateLogin.responseInDic;
    //NSLog([simulateLogin.responseInDic descriptionInStringsFileFormat]);
    //NSLog(simulateLogin.dataInString);
}
- (IBAction)Cancel:(id)sender {
    [self.delegate GoCheckViewControllerDidCancel:self];
}
@end
