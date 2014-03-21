//
//  ZoriLinkCell.m
//  Zorios
//
//  Created by CGI on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinkCell.h"

@implementation ZoriLinkCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ZoriLinkCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        self.tooltip = [[ZoriLinkCellTooltip alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        [self.tooltip setHidden:true];
    }
    
    return self;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    int duration         = 2.0;
    CGPoint origin       = self.frame.origin;
    CGSize  size         = self.frame.size;
    float previousHeight = size.height;
    float previousOrgY   = origin.y;
    
    [self setFrame:CGRectMake(origin.x, origin.y + previousHeight, size.width, 0)];
    
    [UIView animateWithDuration:duration animations:^{
        [self setFrame:CGRectMake(origin.x, previousOrgY, size.width, previousHeight)];
    } completion:nil];
}

- (IBAction)toggleLink:(id)sender {
    self.tooltip.hidden = !self.tooltip.hidden;
}

@end
