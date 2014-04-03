//
//  ZoriAnimationViewController.m
//  Zorios
//
//  Created by iGitScor on 21/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriAnimationViewController.h"
#import <Firebase/Firebase.h>

@interface ZoriAnimationViewController ()

@end

@implementation ZoriAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    id version  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.version setText:[NSString stringWithFormat:@"Version %@", version]];
    [self.description setText:NSLocalizedStringFromTable(@"zAnimation.description", @"Application", nil)];
    
    // Pre-Load the first request
    Firebase *preloadConnection = [[FirebaseManager sharedConnection] childByAppendingPath:@"links"];
    [preloadConnection observeEventType:FEventTypeChildChanged withBlock:nil];
    preloadConnection = nil;
    
    [self.animation addObserver:self forKeyPath:@"completed" options:NSKeyValueObservingOptionNew context:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if ([keyPath isEqual:@"completed"]) {
        [self performSegueWithIdentifier:@"displayHome" sender:nil];
    }
}

@end
