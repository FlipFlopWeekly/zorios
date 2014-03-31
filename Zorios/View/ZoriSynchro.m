//
//  ZoriSynchro.m
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriSynchro.h"

@implementation ZoriSynchro

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ZoriSynchro" owner:self options:nil];
        
        if ([arrayOfViews isEmpty] || ![[arrayOfViews objectAtIndex:_zFirstElement] isKindOfClass:[UIView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:_zFirstElement];
        [self setFrame:frame];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
