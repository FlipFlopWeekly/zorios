//
//  ZORIViewController.h
//  Zorios
//
//  Created by iGitScor on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoriLinksViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collection;

@end
