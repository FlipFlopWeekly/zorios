//
//  CoreDataManager.h
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

+ (void)setCoreDataManagedObjectContext:(NSManagedObjectContext*) context;

+ (NSArray*)getAllEntityRecords:(NSString*)entityForName;
+ (void)removeCoreDataEntityRows:(NSString*)entityForName;

@end
