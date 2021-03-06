//
//  ZoriLinkCell.h
//  Zorios
//
//  Created by iGitScor on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoriLinkCellTooltip.h"

@interface ZoriLinkCell : UICollectionViewCell

@property (strong, nonatomic) ZoriLinkCellTooltip   *tooltip;
@property (nonatomic, retain) NSDictionary          *link;

- (void)toggleLink:(id)sender;

@end
