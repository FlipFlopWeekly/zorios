//
//  ZoriLinkCellTooltip.m
//  Zorios
//
//  Created by iGitScor on 21/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinkCellTooltip.h"

@implementation ZoriLinkCellTooltip

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ZoriLinkCell" owner:self options:nil];
        
        if ([arrayOfViews isEmpty] || ![[arrayOfViews objectAtIndex:1] isKindOfClass:[UIView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:1];
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
