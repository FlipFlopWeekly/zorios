//
//  FirebaseManager.h
//  Zorios
//
//  Created by iGitScor on 21/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface FirebaseManager : NSObject

+ (Firebase *)sharedConnection;

@end
