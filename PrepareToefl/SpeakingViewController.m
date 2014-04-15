//
//  SpeakingViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "SpeakingViewController.h"

@interface SpeakingViewController (){
    BOOL isRecording;
    BOOL isReplaying;
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;

}

@end

@implementation SpeakingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.questionTextField.text = @"Choose a question on the bottom when you ready.";
    self.navigationItem.title = self.question.title;
    
    [self displayTimeForRecord];
    [self displayTimeForReplay];
    
    
    isRecording = NO;
    [self.replayButton setEnabled:NO];
    self.replayButton.titleLabel.alpha = 0.5;
    recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:
                                           [NSString stringWithFormat: @"%@.%@",@"sampleRecording",@"caf"]
                                           ]];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:&sessionError];
    
    
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma for record delegate


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.replayButton setTitle:@"Replay" forState:UIControlStateNormal];
}


- (IBAction)Record:(id)sender {
    
    //If the app is note recording, we want to start recording, disable the play button, and make the record button say "STOP"
    
    
    if(!isRecording)
    {
        
        isRecording = YES;
        [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.replayButton setEnabled:NO];
        [self.replayButton.titleLabel setAlpha:0.5];
        
        recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:nil error:nil];
        [recorder prepareToRecord];
        [recorder record];
        player = nil;
    }
    //If the app is recording, we want to stop recording, enable the play button, and make the record button say "REC"
    else
    {
        isRecording = NO;
        
        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
        [self.replayButton setEnabled:YES];
        [self.replayButton.titleLabel setAlpha:1];
        
        [recorder stop];
        recorder = nil;
        
        NSError *playerError;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recordedFile error:&playerError];
        
        if (player == nil)
        {
            NSLog(@"Error creating player: %@", [playerError description]);
        }
        player.delegate = self;
    }


}

- (IBAction)Replay:(id)sender {
    
    
    //If the track is playing, pause and achange playButton text to "Play"
    if([player isPlaying])
    {
        [player pause];
        [self.replayButton setTitle:@"Replay" forState:UIControlStateNormal];
    }
    //If the track is not player, play the track and change the play button to "Pause"
    else
    {
        [player play];
        [self.replayButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
}

#pragma display time in other thread for both fuction
-(void)displayTimeForReplay{
    NSThread *disTimeReplayThread = [[NSThread alloc] initWithTarget:self selector:@selector(refreshTimeForReplay) object:nil];
    [disTimeReplayThread setName:@"displayReplayTimeThread"];
    [disTimeReplayThread start];
}
-(void)refreshTimeForReplay{
    while (1) {
        [NSThread sleepForTimeInterval:0.1];
        if ([player isPlaying]) {
            [self performSelectorOnMainThread:@selector(refreshTimeForMainThreadForReplay) withObject:nil waitUntilDone:YES];
        }
    }
}
-(void)refreshTimeForMainThreadForReplay{
    self.timeForReplay.text = [NSString stringWithFormat:@"%d", (int)player.currentTime];
}



-(void)displayTimeForRecord{
    NSThread *disTimeRecordThread = [[NSThread alloc] initWithTarget:self selector:@selector(refreshTimeForRecord) object:nil];
    [disTimeRecordThread setName:@"displayRecordTimeThread"];
    [disTimeRecordThread start];
}
-(void)refreshTimeForRecord{
        while (1) {
        [NSThread sleepForTimeInterval:0.1];
            if (isRecording) {
                [self performSelectorOnMainThread:@selector(refreshTimeForMainThreadForRecord) withObject:nil waitUntilDone:YES];
            }
        
    }
}
-(void)refreshTimeForMainThreadForRecord{
    self.timeForRecord.text = [NSString stringWithFormat:@"%d", (int)recorder.currentTime];
}
    


- (IBAction)ShowQ1:(id)sender {
    self.questionTextField.text = self.question.question1;
}

- (IBAction)ShowQ2:(id)sender {
    self.questionTextField.text = self.question.question2;
}
@end
