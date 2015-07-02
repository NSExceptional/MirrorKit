//
//  MKMirror.m
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "MKMirror.h"
#import "MirrorKit.h"

#import <objc/objc-runtime.h>

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

- (void)examine {
    unsigned int pcount, mcount;
    objc_property_t *objcproperties = class_copyPropertyList([self.value class], &pcount);
    Method *objcmethods             = class_copyMethodList([self.value class], &mcount);
    
    _className = NSStringFromClass([self.value class]);
    
    NSMutableArray *properties = [NSMutableArray array];
    for (int i = 0; i < pcount; i++)
        [properties addObject:[MKProperty property:objcproperties[i]]];
    _properties = properties;
    
    NSMutableArray *methods = [NSMutableArray array];
    for (int i = 0; i < mcount; i++)
        [methods addObject:[MKMethod method:objcmethods[i]]];
    _methods = methods;
    
    // Cleanup
    free(objcproperties);
    free(objcmethods);
}

#pragma mark Misc

- (MKMirror *)superReflection {
    return [MKMirror reflect:[self.value superclass]];
}

@end
