//
//  ZoriBluetoothMainViewController.h
//  Zorios
//
//  Created by iGitScor on 26/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h> 

@interface ZoriBluetoothMainViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate>

@property (nonatomic, retain) GKSession                 *currentSession;
@property                     GKPeerPickerController    *picker;
@property (strong, nonatomic) IBOutlet UIButton         *connect;
@property (strong, nonatomic) IBOutlet UIButton         *disconnect;
@property (strong, nonatomic) IBOutlet UIButton         *synchronize;
@property (strong, nonatomic) IBOutlet UIButton         *send;

@end
