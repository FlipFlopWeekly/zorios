//
//  Link.m
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "Link.h"


@implementation Link

@dynamic url;
@dynamic submitDate;
@dynamic nbClick;

- (NSString *)description
{
    return [NSObjectTools formatDescriptionFor:self];
}

@end
