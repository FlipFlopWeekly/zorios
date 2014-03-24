//
//  FirebaseManager.m
//  Zorios
//
//  Created by iGitScor on 21/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "FirebaseManager.h"

@interface FirebaseManager ()

@end

@implementation FirebaseManager

#pragma mark - Singleton
// Singleton instance
+ (FirebaseManager *)sharedInstance
{
    static FirebaseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FirebaseManager alloc] init];
        // Do any other initialisation stuff here
    });
    
    return sharedInstance;
}

@end
