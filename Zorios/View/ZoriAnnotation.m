//
//  ZoriAnnotation.m
//  Zorios
//
//  Created by iGitScor on 31/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@interface ZoriAnnotation ()

@property (nonatomic, retain) IBOutlet UILabel *note;

@end

@implementation ZoriAnnotation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.note   = [[UILabel alloc] initWithFrame:frame];
        self.frame  = frame;
        
        [self addSubview:self.note];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CALayer *sublayer           = [CALayer layer];
    sublayer.backgroundColor    = [UIColor whiteColor].CGColor;
    sublayer.shadowOffset       = CGSizeMake(0, 1);
    sublayer.shadowRadius       = 4.0;
    sublayer.shadowColor        = [UIColor whiteColor].CGColor;
    sublayer.shadowOpacity      = 0.2;
    sublayer.frame              = self.frame;
    sublayer.borderColor        = [UIColor colorWithRed:160 green:160 blue:160 alpha:0.85].CGColor;
    sublayer.borderWidth        = 2.0;
    [self.note.layer addSublayer:sublayer];
}

+ (void)addAnnotationInView:(UIView *)view withFrame:(CGRect)rect
{
    ZoriAnnotation *annotation = [[ZoriAnnotation alloc] initWithFrame:rect];
    [view addSubview:annotation];
}

@end
