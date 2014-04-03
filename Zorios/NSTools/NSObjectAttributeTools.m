//
//  NSObjectAttributeTools.m
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2013 FlipFlopCrew. All rights reserved.
//

#import "NSObjectAttributeTools.h"
#import <objc/runtime.h>

@implementation NSObjectAttributeTools

// Copy NSString attributes of the source object in the copy object.
// We can copy a partial list of attributes if the source and copy objects do not have the same attributes.
+ (void)copyUserRuntimeAttributes:(id)copy fromObject:(id)source
{
    [[NSObjectAttributeTools sharedInstance] copyAttributes:copy ofType:[NSString  class] fromObject:source];
    [[NSObjectAttributeTools sharedInstance] copyAttributes:copy ofType:[NSNumber  class] fromObject:source];
}

// Check if the object has a specific attribute
+ (bool)instance:(id)var hasAttribute:(NSString *)attr
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([var class], &outCount);
    // Fetch attributes.
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        // If the name of the property is resolvable and match to the attribute param name.
        if (propName && [[NSString stringWithCString:propName encoding:NSUTF8StringEncoding] isEqualToString:attr]) {
            return true;
        }
    }
    free(properties);
    
    return false;
}

#pragma mark - Private methods (declared in .m)
#pragma mark Static singleton
+ (NSObjectAttributeTools *)sharedInstance
{
    static NSObjectAttributeTools *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NSObjectAttributeTools alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark Instance methods
- (void)copyAttributes:(id)copy ofType:(Class)typeClass fromObject:(id)source
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([source class], &outCount);
    // Fetch attributes.
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        // If the name of the property is resolvable.
        if (propName) {
            NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            // If the source attribtue has a value for the fetched attribute.
            if ([source valueForKey:propertyName] != nil) {
                if ([[source valueForKey:propertyName] isKindOfClass:typeClass]) {
                    NSString *val    = [source valueForKey:propertyName];
                    [copy setValue:val forKey:propertyName];
                }
            }
        }
    }
    free(properties);
}

@end
