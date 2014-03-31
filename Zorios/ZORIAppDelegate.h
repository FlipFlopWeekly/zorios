//
//  ZORIAppDelegate.h
//  Zorios
//
//  Created by iGitScor on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ZORIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel            *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext          *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

@end
