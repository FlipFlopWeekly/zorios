//
//  ZoriLinkCell.m
//  Zorios
//
//  Created by iGitScor on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinkCell.h"
#import <Firebase/Firebase.h>
#import "UIColorHTMLColors.h"

@interface ZoriLinkCell ()
@property (strong, nonatomic) IBOutlet UIView *topBarColorView;
@property (strong, nonatomic) IBOutlet UIView *bottomBarColorView;

@end

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
        [self initTooltip];
        
        [self addObserver:self forKeyPath:@"link" options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultNotification:) name:@"defaultNotification" object:nil];
    }
    
    return self;
}

- (void)initTooltip {
    self.tooltip = [[ZoriLinkCellTooltip alloc] initWithFrame:self.frame];
    self.tooltip.frame = CGRectMake(
                                    self.tooltip.frame.origin.x,
                                    self.tooltip.frame.origin.y + 46,
                                    self.tooltip.frame.size.width,
                                    self.tooltip.frame.size.height - 44);
    self.tooltip.hidden = true;
    
    [self.tooltip.playButton addTarget:self action:@selector(playLink) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.tooltip];
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
    
    self.frame = CGRectMake(origin.x, origin.y + previousHeight, size.width, 0);
    
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(origin.x, previousOrgY, size.width, previousHeight);
    } completion:nil];
}

#pragma mark - Notification
- (void)defaultNotification:(NSNotification *)note
{
    NSLog(@"%@", [self.link objectForKey:@"url"]);
}

#pragma mark - Toolbar "+" action

- (IBAction)toggleLink:(id)sender
{
    self.tooltip.hidden = !self.tooltip.hidden;
}

#pragma mark - Button actions

- (void)playLink
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.link objectForKey:@"url"]]];
    
    int nbClick = [self.link valueForKey:@"nbClick"] == nil ? 0 :
                  [[self.link valueForKey:@"nbClick"] intValue];
        
    Firebase *f = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://shining-fire-3337.firebaseio.com/links/%@", [self.link objectForKey:@"identifier"]]];
    [[f childByAppendingPath:@"nbClick"] setValue:[NSNumber numberWithInt:nbClick + 1]];
}

- (void)star
{
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"link"]) {
        int nbClick = [self.link valueForKey:@"nbClick"] == nil ? 0 :
        [[self.link valueForKey:@"nbClick"] intValue];
        
        UIColor *color = nil;
        NSString *hsla = [NSString stringWithFormat:@"hsla(%f, 99%%, 65%%, 1.0)", fminf(nbClick * 10, 100.0)];
        NSScanner *scanner = [NSScanner scannerWithString:hsla];
        [scanner scanHSLColor:&color];
        
        UIColor *colorB = nil;
        NSString *hslaB = [NSString stringWithFormat:@"hsla(%f, 99%%, 30%%, 1.0)", fminf(nbClick * 10, 100.0)];
        NSScanner *scannerB = [NSScanner scannerWithString:hslaB];
        [scannerB scanHSLColor:&colorB];
        
        float height = nbClick * 12 + 40;
        height = fmin( 300, height );
        
        [_topBarColorView setFrame:CGRectMake(
                                              _topBarColorView.frame.origin.x,
                                              (150 - height / 2),
                                              _topBarColorView.frame.size.width,
                                              height / 2)];
        [_topBarColorView setBackgroundColor:color];
        [_bottomBarColorView setFrame:CGRectMake(
                                                 _bottomBarColorView.frame.origin.x,
                                                 150,
                                                 _bottomBarColorView.frame.size.width,
                                                 height / 2)];
        [_bottomBarColorView setBackgroundColor:colorB];
    }
}

@end
