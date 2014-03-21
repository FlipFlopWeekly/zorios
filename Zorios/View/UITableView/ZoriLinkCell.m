//
//  ZoriLinkCell.m
//  Zorios
//
//  Created by CGI on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinkCell.h"
#import <Firebase/Firebase.h>

@implementation ZoriLinkCell
@synthesize link;

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
        self.tooltip = [[ZoriLinkCellTooltip alloc] initWithFrame:self.frame];
        [self.tooltip setFrame:CGRectMake(self.tooltip.frame.origin.x, self.tooltip.frame.origin.y + 46, self.tooltip.frame.size.width, self.tooltip.frame.size.height - 44)];
        [self.tooltip setHidden:true];
        
        [self.tooltip.playButton addTarget:self action:@selector(playLink) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.tooltip];
    }
    
    return self;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    int duration         = 1.2;
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

- (void)playLink
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.link objectForKey:@"url"]]];
    
    int nbClick = [self.link valueForKey:@"nbClick"] == nil ? 0 :
                  [[self.link valueForKey:@"nbClick"] intValue];
    
    NSLog(@"%@",[self.link objectForKey:@"identifier"]);
    
    Firebase* f = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://shining-fire-3337.firebaseio.com/links/%@", [self.link objectForKey:@"identifier"]]];
    [[f childByAppendingPath:@"nbClick"] setValue:[NSNumber numberWithInt:nbClick + 1]];
}
@end
