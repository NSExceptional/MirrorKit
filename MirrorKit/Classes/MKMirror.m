//
//  MKMirror.m
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "MKMirror.h"
#import "MirrorKit.h"

#pragma mark - MKMirror -

@implementation MKMirror

- (id)init { [NSException raise:NSInternalInconsistencyException format:@"Class instance should not be created with -init"]; return nil; }

#pragma mark Initialization
+ (instancetype)reflect:(id)objectOrClass {
    return [[self alloc] initWithValue:objectOrClass];
}

- (id)initWithValue:(id)value {
    NSParameterAssert(value);
    
    self = [super init];
    if (self) {
        _value = value;
        [self examine];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ class=%@, %lu properties, %lu ivars, %lu methods, %lu protocols>",
            NSStringFromClass(self.class), self.className, (unsigned long)self.properties.count, (unsigned long)self.instanceVariables.count, (unsigned long)self.methods.count, (unsigned long)self.protocols.count];
}

- (void)examine {
    unsigned int pcount, mcount, ivcount, pccount;
    objc_property_t *objcproperties     = class_copyPropertyList([self.value class], &pcount);
    Protocol*__unsafe_unretained *procs = class_copyProtocolList([self.value class], &pccount);
    Method *objcmethods                 = class_copyMethodList([self.value class], &mcount);
    Ivar *objcivars                     = class_copyIvarList([self.value class], &ivcount);
    
    _className = NSStringFromClass([self.value class]);
    
    NSMutableArray *properties = [NSMutableArray array];
    for (int i = 0; i < pcount; i++)
        [properties addObject:[MKProperty property:objcproperties[i]]];
    _properties = properties;
    
    NSMutableArray *methods = [NSMutableArray array];
    for (int i = 0; i < mcount; i++)
        [methods addObject:[MKMethod method:objcmethods[i]]];
    _methods = methods;
    
    NSMutableArray *ivars = [NSMutableArray array];
    for (int i = 0; i < ivcount; i++)
        [ivars addObject:[MKIVar ivar:objcivars[i]]];
    _instanceVariables = ivars;
    
    NSMutableArray *protocols = [NSMutableArray array];
    for (int i = 0; i < pccount; i++)
        [protocols addObject:[MKProtocol protocol:procs[i]]];
    _protocols = protocols;
    
    // Cleanup
    free(objcproperties);
    free(objcmethods);
    free(objcivars);
    free(procs);
    procs = NULL;
}

#pragma mark Misc
- (MKMirror *)superMirror {
    return [MKMirror reflect:[self.value superclass]];
}

@end


#pragma mark - ExtendedMirror -

@implementation MKMirror (ExtendedMirror)

- (MKMethod *)methodNamed:(NSString *)name {
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"%K = %@", @"selectorString", name];
    return [self.methods filteredArrayUsingPredicate:filter].firstObject;
}

- (MKProperty *)propertyNamed:(NSString *)name {
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"%K = %@", @"name", name];
    return [self.methods filteredArrayUsingPredicate:filter].firstObject;
}

- (MKIVar *)ivarNamed:(NSString *)name {
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"%K = %@", @"name", name];
    return [self.methods filteredArrayUsingPredicate:filter].firstObject;
}

- (MKProtocol *)protocolNamed:(NSString *)name {
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"%K = %@", @"name", name];
    return [self.methods filteredArrayUsingPredicate:filter].firstObject;
}

@end