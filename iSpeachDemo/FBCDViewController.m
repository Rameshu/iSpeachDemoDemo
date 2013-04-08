//
//  FBCDViewController.m
//  iSpeachDemo
//
//  Created by iPhone on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBCDViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation FBCDViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    NSString *urlString = [NSString stringWithFormat:@"http://api.ispeech.org/api/json?apikey=ea195dc9b45d1c8edc69494f6ea140ec&action=convert&text=how+are+you&voice=usenglishfemale&stratpadding=3"];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
//    [postRequest setHTTPMethod:@"POST"];
//    NSError *error;
//    NSURLResponse *response;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
//    NSString *responseString = [[[NSString alloc] initWithBytes:[responseData bytes]
//                                                         length:[responseData length]
//                                                       encoding:NSUTF8StringEncoding] autorelease];
//    NSLog(@"%@", responseString);    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"file.mp3"];
//    
//    NSString *text = @"You are one chromosome away from being a potato.";
//    NSString *urlString = [NSString stringWithFormat:@"http://www.translate.google.com/translate_tts?tl=en&q=%@",text];
//    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
//    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" forHTTPHeaderField:@"User-Agent"];
//    NSURLResponse* response = nil;
//    NSError* error = nil;
//    NSData* data = [NSURLConnection sendSynchronousRequest:request
//                                         returningResponse:&response
//                                                     error:&error];
//    [data writeToFile:path atomically:YES];
//    
//    AVAudioPlayer  *player;
//    NSError        *err;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) 
//    {    
//        player = [[AVAudioPlayer alloc] initWithContentsOfURL:
//                  [NSURL fileURLWithPath:path] error:&err];
//        player.volume = 0.4f;
//        [player prepareToPlay];
//        [player setNumberOfLoops:0];
//        [player play];    
//    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[iSpeechSDK sharedSDK] setVibrateOnPrompts:YES];
    ISSpeechSynthesis *synth = [[ISSpeechSynthesis alloc]initWithText:textField.text];
    [synth setDelegate:self];
    synth.voice = ISVoiceUSEnglishFemale;
    NSError *err;
    if (![synth speak:&err]) {
        NSLog(@"error in speaking == %@", err.localizedDescription);
    }
    [textField resignFirstResponder];
    
    [synth release];
    
    [self performSelector:@selector(abc) withObject:nil afterDelay:0.128];
    
    return YES;
}

- (void)abc {
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        NSLog(@"%@", window);
        if ([window isKindOfClass:NSClassFromString(@"ISPopupBackgroundWindow")]) {
            [window setFrame:CGRectMake(-100, -100, 0, 0)];
            for (UIView*vw in window.subviews) {
                for (UIView *vws in vw.subviews) {
                    [vws removeFromSuperview];
                }
            }
        }
    }
}
#pragma mark - speak ispeech delegate methods
- (void)synthesisDidStartSpeaking:(ISSpeechSynthesis *)speechSynthesis {
    NSLog(@"synthesisDidStartSpeaking:%@", speechSynthesis);
}
- (void)synthesisDidFinishSpeaking:(ISSpeechSynthesis *)speechSynthesis userCancelled:(BOOL)userCancelled {
    NSLog(@"synthesisDidFinishSpeaking:%@ userCancelled:%@", speechSynthesis, [NSNumber numberWithBool:userCancelled]);
}
- (void)synthesis:(ISSpeechSynthesis *)speechSynthesis didFailWithError:(NSError *)error {
    NSLog(@"synthesis:%@ didFailWithError:%@", speechSynthesis, error.localizedDescription);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
