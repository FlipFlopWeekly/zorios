//
//  ZoriLinkCell.h
//  Zorios
//
//  Created by CGI on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoriLinkCellTooltip.h"

@interface ZoriLinkCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UITabBarItem *zoriLinkCounter;
@property (strong, nonatomic) ZoriLinkCellTooltip *tooltip;

- (IBAction)toggleLink:(id)sender;

@end
