//
//  NSObjectAttributeTools.h
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2013 FlipFlopCrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObjectAttributeTools : NSObject

+ (void)copyUserRuntimeAttributes:(id)copy fromObject:(id)source;
+ (bool)instance:(id)var hasAttribute:(NSString *)attr;

@end
