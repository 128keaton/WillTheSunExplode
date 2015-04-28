//
//  ViewController.m
//  WillTheSunExplode
//
//  Created by Keaton Burleson on 4/27/15.
//  Copyright (c) 2015 Keaton Burleson. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController () <AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *willITLabel;
@property (strong, nonatomic)  AVAudioPlayer * audioPlayer;
@end


@implementation ViewController
bool isDead;

- (void)viewDidLoad {
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noShake)];
    letterTapRecognizer.numberOfTapsRequired = 1;
    _willITLabel.userInteractionEnabled = YES;
    [_willITLabel addGestureRecognizer:letterTapRecognizer];
    
    [super viewDidLoad];
    _willITLabel.font = [UIFont fontWithName:@"CheapPotatoes" size:30];
    _willITLabel.text = @"tap or shake";
    
    _willITLabel.center = self.view.center;


    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)noShake{
    _willITLabel.text = @"...";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self initiateRandomNumber];
        
    });

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}
-(void)updateView{
    NSURL *soundURL;
    _audioPlayer.delegate = self;
 
    if (isDead) {
        _willITLabel.text = @"YES";
        soundURL = [[NSBundle mainBundle] URLForResource:@"yes"
                                                  withExtension:@"aiff"];
    
        [self sendTweet];
    }else{
        _willITLabel.text = @"NO";
       soundURL = [[NSBundle mainBundle] URLForResource:@"no"
                                                  withExtension:@"aiff"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
           _willITLabel.text = @"TAP or SHAKE";
            
        });
     
    }
    _audioPlayer = [[AVAudioPlayer alloc]
                    initWithContentsOfURL:soundURL error:nil];
    
    [_audioPlayer play];

}
-(void)sendTweet{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"The sun will explode #XKCD"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}
- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        _willITLabel.text = @"...";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self initiateRandomNumber];
           
        });
        
        
    }
}

-(void)initiateRandomNumber{
    
    NSUInteger random = arc4random_uniform(5432 * 27);
    switch (random) {
        case 5432:
            isDead = YES;
            break;
            
        default:
            isDead = NO;
            break;
    }
    [self updateView];
    
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
 _willITLabel.center = CGPointMake(self.view.center.x, self.view.center.y);
}





@end
