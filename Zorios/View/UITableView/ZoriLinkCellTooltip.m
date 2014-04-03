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
        
        self        = [arrayOfViews objectAtIndex:1];
        self.frame  = frame;
        
        UIView* subView = (UIView*)[[self subviews] objectAtIndex:_zFirstElement];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTooltip)];
        [tapGR setNumberOfTapsRequired:1];
        [tapGR setNumberOfTouchesRequired:1];
        [subView addGestureRecognizer:tapGR];
        [tapGR setDelegate:self];
    }
    
    return self;
}

- (void)closeTooltip
{
    [self.superview performSelector:NSSelectorFromString(@"toggleLink:") withObject:nil afterDelay:0.0];
}

@end
