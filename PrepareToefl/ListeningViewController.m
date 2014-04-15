//
//  ListeningViewController.m
//  PrepareToefl
//
//  Created by Eric on 14-4-15.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "ListeningViewController.h"


@interface ListeningViewController (){
    BOOL isPlaying;
    NSURL *listeningFile;
    AVAudioPlayer *player;
}

@end

@implementation ListeningViewController

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
    self.fileNameLabel.text = self.fileName;
    
    
    listeningFile = [NSURL fileURLWithPath:[self dataFilePath:self.fileName]];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayback  error:&sessionError];
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    
    NSError *playerError;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:listeningFile error:&playerError];
    if (player == nil) {
        NSLog(@"Error creating player: %@", [playerError description]);
    }
    player.delegate = self;

    //获取音乐总时间并显示
    
    NSString *timeString = [NSString stringWithFormat:@"%02li:%02li",
                        lround(floor(player.duration / 60.)) % 60,
                        lround(floor(player.duration)) % 60];
    self.timeAllLabel.text = timeString;
    
    //打开刷新当前时间的功能
    [self displayTimeForPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
}

-(NSString*)dataFilePath:(NSString*)fileName{
    
    return [[self documentsDirectory]stringByAppendingPathComponent:fileName];
}

- (IBAction)Start:(id)sender {
    //If the track is playing, pause and achange playButton text to "Play"
    if([player isPlaying])
    {
        [player pause];
        [self.StartButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    //If the track is not player, play the track and change the play button to "Pause"
    else
    {
        [player play];
        [self.StartButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
}

- (IBAction)progressBarValueChanged:(id)sender {
    [player stop];
    player.currentTime = self.progressBar.value * player.duration;
    [player play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.StartButton setTitle:@"Play" forState:UIControlStateNormal];
}

-(void)displayTimeForPlay{
    self.timePlayedLabel.text = @"00:00";
    //进度条归零
    [self.progressBar setValue:0];
    
    NSThread *disTimeReplayThread = [[NSThread alloc] initWithTarget:self selector:@selector(refreshTimeForPlay) object:nil];
    [disTimeReplayThread setName:@"displayPlayTimeThread"];
    [disTimeReplayThread start];
}
-(void)refreshTimeForPlay{
    [NSThread sleepForTimeInterval:0.5];
    while (1) {
        [NSThread sleepForTimeInterval:0.2];
        if ([player isPlaying]) {
            [self performSelectorOnMainThread:@selector(refreshTimeForMainThreadForPlay) withObject:nil waitUntilDone:YES];
        }
    }
}
-(void)refreshTimeForMainThreadForPlay{
    //获取音乐当前时间并显示
    
    NSString *currentTimeString = [NSString stringWithFormat:@"%02li:%02li",
                            lround(floor(player.currentTime / 60.)) % 60,
                            lround(floor(player.currentTime)) % 60];
    self.timePlayedLabel.text = currentTimeString;
    [self.progressBar setValue:(player.currentTime/player.duration)];
}

-(void)viewWillDisappear:(BOOL)animated {
    [player stop];
}
@end
