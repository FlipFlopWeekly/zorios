//
//  ZoriDeviceViewController.m
//  Zorios
//
//  Created by iGitScor on 27/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriDeviceViewController.h"

@interface ZoriDeviceViewController ()

@end

@implementation ZoriDeviceViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:true];
    [super viewWillAppear:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

@end
