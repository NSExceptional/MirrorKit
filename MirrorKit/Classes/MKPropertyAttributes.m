//
//  MKPropertyAttributes.m
//  MirrorKit
//
//  Created by Tanner on 7/5/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "MKPropertyAttributes.h"
#import "MirrorKit-Constants.h"
#import "NSString+Utilities.h"
#import "NSDictionary+Utilities.h"

#pragma mark - MKPropertyAttributes -

@implementation MKPropertyAttributes

+ (instancetype)attributesFromDictionary:(NSDictionary *)attributes {
    NSString *attrs = attributes.propertyAttributesString;
    if (!attrs) [NSException raise:NSInternalInconsistencyException format:@"Invalid property attributes dictionary: %@", attributes];
    return [self attributesFromString:attrs];
}

+ (instancetype)attributesFromString:(NSString *)attributes {
    return [[self alloc] initWithAttributesString:attributes];
}

- (id)initWithAttributesString:(NSString *)attributesString {
    NSParameterAssert(attributesString);
    
    self = [super init];
    if (self) {
        _attributesString = attributesString;
        
        NSDictionary *attributes = attributesString.propertyAttributes;
        if (!attributes) [NSException raise:NSInternalInconsistencyException format:@"Invalid property attributes string: %@", attributesString];
        
        _count                = attributes.allKeys.count;
        _typeEncoding         = attributes[MKPropertyAttributeKeyTypeEncoding];
        _backingIVar          = attributes[MKPropertyAttributeKeyBackingIVarName];
        _oldTypeEncoding      = attributes[MKPropertyAttributeKeyOldTypeEncoding];
        _customGetter         = NSSelectorFromString(attributes[MKPropertyAttributeKeyCustomGetter]);
        _customSetter         = NSSelectorFromString(attributes[MKPropertyAttributeKeyCustomSetter]);
        _isReadOnly           = [attributes[MKPropertyAttributeKeyReadOnly] boolValue];
        _isCopy               = [attributes[MKPropertyAttributeKeyCopy] boolValue];
        _isRetained           = [attributes[MKPropertyAttributeKeyRetain] boolValue];
        _isNonatomic          = [attributes[MKPropertyAttributeKeyNonAtomic] boolValue];
        _isWeak               = [attributes[MKPropertyAttributeKeyWeak] boolValue];
        _isGarbageCollectable = [attributes[MKPropertyAttributeKeyGarbageCollectible] boolValue];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ ivar=%@, readonly=%hhd, nonatomic=%hhd, getter=%@, setter=%@>",
            NSStringFromClass(self.class), self.backingIVar?:@"none", self.isReadOnly, self.isNonatomic, NSStringFromSelector(self.customGetter)?:@" ", NSStringFromSelector(self.customSetter)?:@" "];
}

@end



#pragma mark - MKMutablePropertyAttributes -

@implementation MKMutablePropertyAttributes

@synthesize backingIVar;
@synthesize typeEncoding;
@synthesize oldTypeEncoding;
@synthesize customGetter;
@synthesize customSetter;
@synthesize isReadOnly;
@synthesize isCopy;
@synthesize isRetained;
@synthesize isNonatomic;
@synthesize isDynamic;
@synthesize isWeak;
@synthesize isGarbageCollectable;

+ (instancetype)attributes {
    return [self new];
}

- (void)setTypeEncodingChar:(char)type {
    self.typeEncoding = [NSString stringWithFormat:@"%c", type];
}

- (NSString *)attributesString {
    NSMutableDictionary *attrs = [NSMutableDictionary new];
    
    if (self.typeEncoding)
        attrs[MKPropertyAttributeKeyTypeEncoding]    = self.typeEncoding;
    if (self.backingIVar)
        attrs[MKPropertyAttributeKeyBackingIVarName] = self.backingIVar;
    if (self.oldTypeEncoding)
        attrs[MKPropertyAttributeKeyOldTypeEncoding] = self.oldTypeEncoding;
    if (self.customGetter)
        attrs[MKPropertyAttributeKeyCustomGetter]    = NSStringFromSelector(self.customGetter);
    if (self.customSetter)
        attrs[MKPropertyAttributeKeyCustomSetter]    = NSStringFromSelector(self.customSetter);
    
    attrs[MKPropertyAttributeKeyReadOnly]           = @(self.isReadOnly);
    attrs[MKPropertyAttributeKeyCopy]               = @(self.isCopy);
    attrs[MKPropertyAttributeKeyRetain]             = @(self.isRetained);
    attrs[MKPropertyAttributeKeyNonAtomic]          = @(self.isNonatomic);
    attrs[MKPropertyAttributeKeyDynamic]            = @(self.isDynamic);
    attrs[MKPropertyAttributeKeyWeak]               = @(self.isWeak);
    attrs[MKPropertyAttributeKeyGarbageCollectible] = @(self.isGarbageCollectable);
    
    return attrs.propertyAttributesString;
}

@end