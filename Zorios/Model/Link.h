//
//  Link.h
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Link : NSManagedObject

@property (nonatomic, retain) NSString          *url;
@property (nonatomic, retain) NSNumber          *submitDate;
@property (nonatomic, retain) NSDecimalNumber   *nbClick;

@end
