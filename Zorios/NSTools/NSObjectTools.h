//
//  NSObjectTools.h
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2013 FlipFlopCrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObjectTools : NSObject

+ (NSString *)formatDescriptionFor:(NSObject *)obj;
+ (NSDictionary *)toDictionary:(NSObject *)obj;

@end