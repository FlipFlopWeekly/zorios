//
//  CoreDataManager.m
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreDataManager

#pragma mark - Singleton
// Singleton instance
+ (CoreDataManager *)sharedInstance
{
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Static methods
// Set the coredata managed object context in order to share the same context in the application.
+ (void)setCoreDataManagedObjectContext:(NSManagedObjectContext *)context
{
    [[CoreDataManager sharedInstance] setManagedObjectContext:context];
}

// Remove all rows of the entityForName entity table.
+ (void)removeCoreDataEntityRows:(NSString*)entityForName
{
    if ([CoreDataManager sharedInstance].managedObjectContext != nil) {
        // Retrieve the rows to remove.
        NSArray *items  = [CoreDataManager getAllEntityRecords:entityForName];
        
        for (NSManagedObject *managedObject in items) {
            [[CoreDataManager sharedInstance].managedObjectContext deleteObject:managedObject];
        }
        
        items = nil;
    } else {
        // Catch an exception when the coredata context is not set.
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"ManagedObjectContext must be set from the app delegate"] userInfo:nil];
    }
}

// Get all the rows of the entityForName entity table.
+ (NSArray*)getAllEntityRecords:(NSString*)entityForName
{
    if ([CoreDataManager sharedInstance].managedObjectContext != nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityForName
                                                  inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
        [fetchRequest setEntity:entity];
       
        NSError* error;
        NSArray *fetchedRecords = [[CoreDataManager sharedInstance].managedObjectContext executeFetchRequest:fetchRequest
                                                                                                       error:&error];
        return fetchedRecords;
    } else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"ManagedObjectContext must be set from the app delegate"] userInfo:nil];
    }
}

@end
