//
//  ListeningViewController.h
//  PrepareToefl
//
//  Created by Eric on 14-4-15.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ListeningViewController : UIViewController <AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressBar;
@property (weak, nonatomic) IBOutlet UIButton *StartButton;
- (IBAction)Start:(id)sender;
- (IBAction)progressBarValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *timePlayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAllLabel;

@property (nonatomic, weak) NSString *fileName;
@end
