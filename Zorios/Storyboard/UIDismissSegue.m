//
//  UIDismissSegue.m
//  Zorios
//
//  Created by iGitScor on 24/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "UIDismissSegue.h"

@implementation UIDismissSegue

- (void)perform
{
    UIViewController *src = (UIViewController *) self.sourceViewController;
    [src dismissViewControllerAnimated:false completion:nil];
}

@end
