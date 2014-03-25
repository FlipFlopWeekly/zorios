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
        // Do any other initialisation stuff here
    });
    
    return sharedInstance;
}

#pragma mark - Static methods

+ (void)setCoreDataManagedObjectContext:(NSManagedObjectContext *)context
{
    [[CoreDataManager sharedInstance] setManagedObjectContext:context];
}

+ (void)removeCoreDataEntityRows:(NSString*)entityForName
{
    if ([CoreDataManager sharedInstance].managedObjectContext != nil) {
        NSArray *items  = [CoreDataManager getAllEntityRecords:entityForName];
        
        for (NSManagedObject *managedObject in items) {
            [[CoreDataManager sharedInstance].managedObjectContext deleteObject:managedObject];
        }
        
        items           = nil;
    } else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"ManagedObjectContext must be set from the app delegate"] userInfo:nil];
    }
}

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
