//
//  ZORIViewController.m
//  Zorios
//
//  Created by CGI on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinksViewController.h"
#import "ZoriLinkCell.h"

#import "UIColor+HTMLColors.h"
#import <Firebase/Firebase.h>

@interface ZoriLinksViewController ()

@property (nonatomic, retain) NSMutableArray *links;

@end

@implementation ZoriLinksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.collection registerClass:[ZoriLinkCell class] forCellWithReuseIdentifier:@"ZoriLinkCell"];
    
    Firebase* f = [[Firebase alloc] initWithUrl:@"https://shining-fire-3337.firebaseio.com/links"];
    
    _links = [[NSMutableArray alloc] init];
    
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *f_links = (NSDictionary*)snapshot.value;
        
        [_links removeAllObjects];
        
        for (NSString * link in f_links) {
            NSMutableDictionary* values = [[NSMutableDictionary alloc] initWithDictionary:[f_links objectForKey:link]];
            [values setObject:link forKey:@"identifier"];
            [_links insertObject:values atIndex:_links.count];
        }
        
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
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    int nbClick = [(NSDictionary*)[_links objectAtIndex:indexPath.row] valueForKey:@"nbClick"] == nil ? 0 :
//                  [[(NSDictionary*)[_links objectAtIndex:indexPath.row] valueForKey:@"nbClick"] intValue];
//    int height = 30 * nbClick + 30;
    CGSize retval = CGSizeMake(40, 300);
    
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
