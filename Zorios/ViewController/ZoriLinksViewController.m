//
//  ZORIViewController.m
//  Zorios
//
//  Created by iGitScor on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinksViewController.h"
#import "ZoriLinkCell.h"

#import "UIColor+HTMLColors.h"
#import <Firebase/Firebase.h>

@interface ZoriLinksViewController ()

@property (nonatomic, retain) NSMutableOrderedSet *links;

@end

@implementation ZoriLinksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.collection registerClass:[ZoriLinkCell class] forCellWithReuseIdentifier:@"ZoriLinkCell"];
    
    Firebase* f = [[Firebase alloc] initWithUrl:@"https://shining-fire-3337.firebaseio.com/links"];
    
    _links = [[NSMutableOrderedSet alloc] init];
    
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *f_links = (NSDictionary*)snapshot.value;
        
        [_links removeAllObjects];
        
        [f_links enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSDictionary* nextEntry = obj;
            NSString* nextKey       = key;

            NSMutableDictionary* values = [[NSMutableDictionary alloc] initWithDictionary:nextEntry];
            [values setObject:nextKey forKey:@"identifier"];
            [_links setObject:values atIndex:_links.count];
        }];
        
        [_links sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([[obj1 objectForKey:@"submitTime"] intValue] < [[obj2 objectForKey:@"submitTime"] intValue]) {
                return NSOrderedAscending;
            } else if ([[obj1 objectForKey:@"submitTime"] intValue] > [[obj2 objectForKey:@"submitTime"] intValue]) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        }];
        
        [self.collection reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return _links.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZoriLinkCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ZoriLinkCell" forIndexPath:indexPath];
    
    int nbClick = [(NSDictionary*)[_links objectAtIndex:indexPath.row] valueForKey:@"nbClick"] == nil ? 0 :
    [[(NSDictionary*)[_links objectAtIndex:indexPath.row] valueForKey:@"nbClick"] intValue];
    
    
    UIColor *color = nil;
    NSString *hsla = [NSString stringWithFormat:@"hsla(%f, 100%%, 50%%, 1.0)", fminf(nbClick * 10, 100.0)];
    NSScanner *scanner = [NSScanner scannerWithString:hsla];
    [scanner scanHSLColor:&color];

    [cell setBackgroundColor:color];
    [cell setLink:(NSDictionary*)[_links objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Custom code : selection
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    int nbClick = [(NSDictionary*)[_links objectAtIndex:indexPath.row] valueForKey:@"nbClick"] == nil ? 0 :
//                  [[(NSDictionary*)[_links objectAtIndex:indexPath.row] valueForKey:@"nbClick"] intValue];
//    int height = 30 * nbClick + 30;
    CGSize retval = CGSizeMake(40, 300);
    
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end