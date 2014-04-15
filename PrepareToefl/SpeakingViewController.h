//
//  SpeakingViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-4-12.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import <AVFoundation/AVFoundation.h>

@interface SpeakingViewController : UIViewController <AVAudioPlayerDelegate>

@property(nonatomic, weak)Questions *question;
@property (weak, nonatomic) IBOutlet UITextView *questionTextField;
- (IBAction)Record:(id)sender;
- (IBAction)Replay:(id)sender;
- (IBAction)ShowQ1:(id)sender;
- (IBAction)ShowQ2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *replayButton;
@property (weak, nonatomic) IBOutlet UILabel *timeForRecord;
@property (weak, nonatomic) IBOutlet UILabel *timeForReplay;

@end
