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

+ (instancetype)propertyWithName:(NSString *)name attributes:(NSString *)attributes {
    return [[self alloc] initWithName:name attributes:attributes];
}

- (id)initWithProperty:(objc_property_t)property {
    NSParameterAssert(property);
    
    self = [super init];
    if (self) {
        _objc_property = property;
        _attributes    = @(property_getAttributes(self.objc_property));
        _name          = @(property_getName(self.objc_property));
        
        if (!_attributes) [NSException raise:NSInternalInconsistencyException format:@"Error retrieving property attributes"];
        if (!_name) [NSException raise:NSInternalInconsistencyException format:@"Error retrieving property name"];
        
        [self examine];
    }
    
    return self;
}

- (id)initWithName:(NSString *)name attributes:(NSString *)attributes {
    NSParameterAssert(name); NSParameterAssert(attributes);
    
    self = [super init];
    if (self) {
        _attributes    = attributes;
        _name          = name;
        
        [self examine];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ name=%@, ivar=%@, readonly=%hhd, nonatomic=%hhd, getter=%@, setter=%@>",
            NSStringFromClass(self.class), self.name, self.backingIVar?:@"none", self.readOnly, self.nonatomic, NSStringFromSelector(self.customGetter)?:@" ", NSStringFromSelector(self.customSetter)?:@" "];
}

- (void)examine {
    NSDictionary *attributes = self.attributes.propertyAttributes;
    
    _attributeCount     = attributes.allKeys.count;
    _typeEncoding       = attributes[MKPropertyAttributeKeyTypeEncoding];
    _type               = (MKTypeEncoding)[_typeEncoding characterAtIndex:0];
    _backingIVar        = attributes[MKPropertyAttributeKeyBackingIVarName];
    _oldTypeEncoding    = attributes[MKPropertyAttributeKeyOldTypeEncoding];
    _customGetter       = NSSelectorFromString(attributes[MKPropertyAttributeKeyCustomGetter]);
    _customSetter       = NSSelectorFromString(attributes[MKPropertyAttributeKeyCustomSetter]);
    _readOnly           = [attributes[MKPropertyAttributeKeyReadOnly] boolValue];
    _copy               = [attributes[MKPropertyAttributeKeyCopy] boolValue];
    _retain             = [attributes[MKPropertyAttributeKeyRetain] boolValue];
    _nonatomic          = [attributes[MKPropertyAttributeKeyNonAtomic] boolValue];
    _weak               = [attributes[MKPropertyAttributeKeyWeak] boolValue];
    _garbageCollectable = [attributes[MKPropertyAttributeKeyGarbageCollectible] boolValue];
}

- (objc_property_attribute_t *)copyAttributesList:(unsigned int *)attributesCount {
    if (self.objc_property) {
        return property_copyAttributeList(self.objc_property, attributesCount);
    } else {
        NSDictionary *attributes = self.attributes.propertyAttributes;
        *attributesCount = (unsigned int)attributes.allKeys.count;
        objc_property_attribute_t *propertyAttributes = malloc(attributes.allKeys.count*sizeof(objc_property_attribute_t));
        
        NSUInteger i = 0;
        for (NSString *key in attributes.allKeys) {
            MKPropertyAttribute c = (MKPropertyAttribute)[key characterAtIndex:0];
            switch (c) {
                case MKPropertyAttributeTypeEncoding: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyTypeEncoding.UTF8String, self.typeEncoding.UTF8String};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeBackingIVarName: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyBackingIVarName.UTF8String, self.backingIVar.UTF8String};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeCopy: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyCopy.UTF8String, ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeCustomGetter: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyCustomGetter.UTF8String, NSStringFromSelector(self.customGetter).UTF8String ?: ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeCustomSetter: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyCustomSetter.UTF8String, NSStringFromSelector(self.customSetter).UTF8String ?: ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeDynamic: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyDynamic.UTF8String, ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeGarbageCollectible: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyGarbageCollectible.UTF8String, ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeNonAtomic: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyNonAtomic.UTF8String, ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeOldTypeEncoding: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyOldTypeEncoding.UTF8String, self.oldTypeEncoding.UTF8String ?: ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeReadOnly: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyReadOnly.UTF8String, ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeRetain: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyRetain.UTF8String, ""};
                    propertyAttributes[i] = pa;
                    break;
                }
                case MKPropertyAttributeWeak: {
                    objc_property_attribute_t pa = {MKPropertyAttributeKeyWeak.UTF8String, ""};
                    propertyAttributes[i] = pa;
                    break;
                }
            }
            i++;
        }
        
        return propertyAttributes;
    }
}

@end
