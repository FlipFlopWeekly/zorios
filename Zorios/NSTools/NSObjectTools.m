//
//  NSObjectTools.m
//  Zorios
//
//  Created by iGitScor on 25/03/2014.
//  Copyright (c) 2013 FlipFlopCrew. All rights reserved.
//

#import "NSObjectTools.h"
#import <objc/runtime.h>

@implementation NSObjectTools

+ (NSString *)formatDescriptionFor:(NSObject *)obj
{
    NSMutableString* description = [NSMutableString stringWithFormat:@"<%@: %p>", NSStringFromClass(obj.class), obj];
    if ([obj.class isSubclassOfClass:obj.superclass]) {
        [self format:obj description:description forClass:obj.superclass];
    }
    [self format:obj description:description forClass:obj.class];
    
    return description.description;
}

+ (NSDictionary *)toDictionary:(NSObject *)obj
{
    NSMutableDictionary *tempDictionnary = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    // Fetch attributes.
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        // If the name of the property is resolvable and match to the attribute param name.
        if (propName) {
            NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            // If the source attribtue has a value for the fetched attribute.
            if ([obj valueForKey:propertyName] != nil) {
                NSString *val    = [obj valueForKey:propertyName];
                [tempDictionnary setObject:val forKey:propertyName];
                val              = nil;
            }
            
        }
    }
    free(properties);
    
    return tempDictionnary;
}

#pragma mark - Static methods
+ (void)format:(NSObject *)obj description:(NSMutableString *)description forClass:(Class)cl
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cl, &outCount);
    // Fetch attributes.
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        // If the name of the property is resolvable and match to the attribute param name.
        if (propName) {
            NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            // If the source attribtue has a value for the fetched attribute.
            if ([obj valueForKey:propertyName] != nil) {
                NSString *val    = [obj valueForKey:propertyName];
                [description appendFormat:@"\n\t\t%@ : %@", propertyName, val];
            }
            
        }
    }
    free(properties);
}

@end
