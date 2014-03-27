//
//  ZORIViewController.m
//  Zorios
//
//  Created by iGitScor on 19/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinksViewController.h"
#import "ZoriLinkCell.h"
#import "UISortPopover.h"

#import "Link.h"

#import <CoreData/CoreData.h>
#import <Firebase/Firebase.h>

@interface ZoriLinksViewController ()

@property (nonatomic, retain) NSMutableOrderedSet    *links;
@property (nonatomic, retain) NSArray                *linkFromCoreData;

@property (strong, nonatomic) IBOutlet UIToolbar     *toolbar;
@property (strong, nonatomic) UIView                 *synchroView;

@property (nonatomic)        Reachability            *internetReachability;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation ZoriLinksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.collection registerClass:[ZoriLinkCell class] forCellWithReuseIdentifier:@"ZoriLinkCell"];
    ZORIAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext    = appDelegate.managedObjectContext;
    
    _linkFromCoreData = [CoreDataManager getAllEntityRecords:@"Link"];
    
    Firebase* f = [[Firebase alloc] initWithUrl:@"https://shining-fire-3337.firebaseio.com/links"];
    
    _links = [[NSMutableOrderedSet alloc] init];
    
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self observeFirebase:snapshot];
    }];
    
    [self.collection reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
	[self.internetReachability startNotifier];
    
    NetworkStatus networkStatus = [self.internetReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        for(UIBarButtonItem* bbi in self.toolbar.items) {
            [bbi setEnabled:false];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    int numberOfItemsInSection = fmax(_linkFromCoreData.count, _links.count);
    NetworkStatus networkStatus = [self.internetReachability currentReachabilityStatus];
    
    if ((numberOfItemsInSection == 0) && (networkStatus == NotReachable)) {
        self.synchroView = [[NSClassFromString(@"ZoriSynchro") alloc] initWithFrame:self.collection.frame];
        [self.view addSubview:self.synchroView];
    }
    
    return numberOfItemsInSection;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZoriLinkCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ZoriLinkCell" forIndexPath:indexPath];
    
    if (_links.count == 0) {
        Link* l = [_linkFromCoreData objectAtIndex:indexPath.row];
        [cell setLink:[NSObjectTools toDictionary:l]];
        l = nil;
    } else {
        [cell setLink:(NSDictionary*)[_links objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

#pragma mark - Sort entity

- (IBAction)sortResults:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Trier les titres" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:nil otherButtonTitles:@"Date de publication", nil];
    [action showFromBarButtonItem:sender animated:false];
}

- (void)sortByXXX:(NSString *)attribute
{
    [_links sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 objectForKey:attribute] intValue] < [[obj2 objectForKey:attribute] intValue]) {
            return NSOrderedAscending;
        } else if ([[obj1 objectForKey:attribute] intValue] > [[obj2 objectForKey:attribute] intValue]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
}

#pragma mark - UIActionsheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (![[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Annuler"]) {
        [self sortByXXX:@"submitTime"];
        [self.collection reloadData];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Custom code : selection
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40, 300);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - Firebase
- (void)observeFirebase:(FDataSnapshot *)snapshot
{
    NSDictionary *f_links = (NSDictionary*)snapshot.value;
    
    [_links removeAllObjects];
    
    [CoreDataManager removeCoreDataEntityRows:@"Link"];
    
    [f_links enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSDictionary* nextEntry = obj;
        NSString* nextKey       = key;
        
        NSMutableDictionary* values = [[NSMutableDictionary alloc] initWithDictionary:nextEntry];
        [values setObject:nextKey forKey:@"identifier"];
        [_links setObject:values atIndex:_links.count];
        
        Link * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Link"
                                                        inManagedObjectContext:self.managedObjectContext];
        
        newEntry.url        = [values objectForKey:@"url"];
        newEntry.nbClick    = [values objectForKey:@"nbClick"];
        newEntry.submitDate = [values objectForKey:@"submitTime"];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            faillog(@"Could not save the entity");
            faillog([error localizedDescription]);
        }
    }];
    
    [self sortByXXX:@"submitTime"];
    [self.collection reloadData];
}

#pragma mark - Reachability
- (void)reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    if (netStatus != NotReachable) {
        [self.synchroView removeFromSuperview];
    }
    
    for(UIBarButtonItem* bbi in self.toolbar.items) {
        [bbi setEnabled:(netStatus != NotReachable)];
    }
    
    [self.collection reloadData];
}

#pragma mark - Memory Management
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
