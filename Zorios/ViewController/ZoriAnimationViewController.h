//
//  ZoriAnimationViewController.h
//  Zorios
//
//  Created by iGitScor on 21/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoriAnimation.h"

@interface ZoriAnimationViewController : UIViewController

@property (strong, nonatomic) IBOutlet ZoriAnimation    *animation;
@property (strong, nonatomic) IBOutlet UILabel          *description;
@property (strong, nonatomic) IBOutlet UILabel          *version;

@end
