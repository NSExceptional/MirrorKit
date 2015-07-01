//
//  MKProperty.m
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "MKProperty.h"
#import "NSString+Utilities.h"

@implementation MKProperty

- (id)init { [NSException raise:NSInternalInconsistencyException format:@"Class instance should not be created with -init"]; return nil; }

+ (instancetype)property:(objc_property_t)property {
    return [[self alloc] initWithProperty:property];
}

- (id)initWithProperty:(objc_property_t)property {
    NSParameterAssert(property);
    
    self = [super init];
    if (self) {
        _objc_property = property;
        [self examine];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ name=%@, ivar=%@, readonly=%hhd, nonatomic=%hhd, getter=%@, setter=%@>",
            NSStringFromClass(self.class), self.name, self.backingIVar?:@"none", self.readOnly, self.nonatomic, self.customGetter?:@" ", self.customSetter?:@" "];
}

- (void)examine {
    NSString *attributesString = [NSString stringWithCString:property_getAttributes(_objc_property) encoding:NSUTF8StringEncoding];
    if (!attributesString) [NSException raise:NSInternalInconsistencyException format:@"Error retrieving property attributes"];
    
    NSDictionary *attributes = attributesString.propertyAttributes;
    
    _attributes         = attributesString;
    _name               = [NSString stringWithCString:property_getName(_objc_property) encoding:NSUTF8StringEncoding];
    _typeEncoding       = attributes[MKPropertyAttributeKeyTypeEncoding];
    _type               = (MKPropertyType)[_typeEncoding characterAtIndex:0];
    _backingIVar        = attributes[MKPropertyAttributeKeyBackingIVarName];
    _oldTypeEncoding    = attributes[MKPropertyAttributeKeyOldTypeEncoding];
    _customGetter       = attributes[MKPropertyAttributeKeyCustomGetter];
    _customSetter       = attributes[MKPropertyAttributeKeyCustomSetter];
    _readOnly           = [attributes[MKPropertyAttributeKeyReadOnly] boolValue];
    _copy               = [attributes[MKPropertyAttributeKeyCopy] boolValue];
    _retain             = [attributes[MKPropertyAttributeKeyRetain] boolValue];
    _nonatomic          = [attributes[MKPropertyAttributeKeyNonAtomic] boolValue];
    _weak               = [attributes[MKPropertyAttributeKeyWeak] boolValue];
    _garbageCollectable = [attributes[MKPropertyAttributeKeyGarbageCollectible] boolValue];
}

@end
