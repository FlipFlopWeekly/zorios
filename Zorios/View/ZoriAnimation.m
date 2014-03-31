//
//  ZoriAnimation.m
//  Zorios
//
//  Created by iGitScor on 21/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriAnimation.h"

@interface ZoriAnimation ()

@property (nonatomic, retain) UIImageView    *cd;
@property (nonatomic, retain) NSMutableArray *pathLogic;
@property (nonatomic, retain) NSMutableArray *pathGraphic;
@property (nonatomic, assign) int            index;
@property (nonatomic, assign) BOOL           completed;

@end

@implementation ZoriAnimation
@synthesize cd;
@synthesize pathLogic, pathGraphic;
@synthesize index;
@synthesize completed;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
        self.pathLogic = [[NSMutableArray alloc] init];
        [self.pathLogic addObject:[NSValue valueWithCGPoint:CGPointMake(100, 0)]];
        [self.pathLogic addObject:[NSValue valueWithCGPoint:CGPointMake(0, 100)]];
        [self.pathLogic addObject:[NSValue valueWithCGPoint:CGPointMake(100, 100)]];
        
        self.pathGraphic        = [[NSMutableArray alloc] init];
        UIView *el1             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
        el1.backgroundColor     = [UIColor orangeColor];
        [self.pathGraphic addObject:el1];
        [self addSubview:el1];
        
        UIView *el2             = [[UIView alloc] initWithFrame:CGRectMake(-23, 50, 0, 50)];
        el2.clipsToBounds       = YES;
        el2.layer.cornerRadius  = (el2.frame.size.height + 140) / 2 / 2;
        el2.backgroundColor     = [UIColor orangeColor];
        [self.pathGraphic addObject:el2];
        [self addSubview:el2];

        UIView *el3             = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 0, 50)];
        el3.backgroundColor     = [UIColor orangeColor];
        [self.pathGraphic addObject:el3];
        [self addSubview:el3];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImage *vinyle = [UIImage imageNamed:@"cd_vinyle_orange.png"];
    self.cd         = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.cd.image   = vinyle;
    
    [self addSubview:self.cd];
    
    NSValue *val    = [self.pathLogic objectAtIndex:self.index];
    CGPoint p       = [val CGPointValue];
    [self move:p];
}

- (void)move:(CGPoint)position
{
    if (self.index < self.pathLogic.count) {
        [UIView animateWithDuration:0.25 animations:^{
            NSValue *val      = [self.pathLogic objectAtIndex:self.index];
            CGPoint p         = [val CGPointValue];
            self.cd.frame     = CGRectMake(p.x, p.y, self.cd.frame.size.width, self.cd.frame.size.height);
            self.cd.transform = CGAffineTransformMakeRotation(M_PI);
            UIView *graph     = [self.pathGraphic objectAtIndex:self.index];
            
            float transition;
            switch (self.index) {
                case 0:
                    transition = 94.2;
                    break;
                    
                case 1:
                    transition = 140;
                    break;
                    
                default:
                    transition = 100;
                    break;
            }
            
            graph.frame = CGRectMake(graph.frame.origin.x, graph.frame.origin.y, transition, graph.frame.size.height);
            if (p.x == 0.0) {
                graph.transform = CGAffineTransformMakeRotation(-M_PI / 4);
            }
        } completion:^(BOOL finished) {
            if (finished) {
                self.index++;
                
                if (self.index < self.pathLogic.count) {
                    NSValue *val = [self.pathLogic objectAtIndex:self.index];
                    CGPoint p    = [val CGPointValue];
                
                    [self move:p];
                } else {
                    [UIView animateWithDuration:0.3 animations:^{
                        self.cd.frame = CGRectMake(self.cd.frame.origin.x + 25, self.cd.frame.origin.y - 25, 100, 100);
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.25 animations:^{
                                self.cd.frame = CGRectMake(self.frame.size.width + 100, self.cd.frame.origin.y, 100, 100);
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    UILabel *ori  = [[UILabel alloc] initWithFrame:CGRectMake(120, 100, 100, 50)];
                                    ori.text      = @"ORI";
                                    ori.font      = [UIFont fontWithName:@"Arial Rounded MT Bold" size:50.0];
                                    ori.textColor = [UIColor orangeColor];
                                    
                                    [self addSubview:ori];
                                    [self performSelector:@selector(complete) withObject:nil afterDelay:2.0];
                                }
                            }];
                        }
                    }];
                }
            }
        }];
    }
}

- (void)complete
{
    [self setCompleted:true];
}

@end
