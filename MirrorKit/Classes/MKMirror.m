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

+ (instancetype)reflect:(id)object {
    return [[self alloc] initWithValue:object];
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
    unsigned int pcount;
    objc_property_t *roproperties = class_copyPropertyList([self.value class], &pcount);
    
    _className = NSStringFromClass([self.value class]);
    
    NSMutableArray *properties = [NSMutableArray new];
    for (int i = 0; i < pcount; i++)
        [properties addObject:[MKProperty property:roproperties[i]]];
    
    _properties = properties;
}

@end
