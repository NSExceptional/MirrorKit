//
//  MKProperty.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MirrorKit-Constants.h"
@import ObjectiveC;


@interface MKProperty : NSObject

+ (instancetype)property:(objc_property_t)property;
+ (instancetype)propertyWithName:(NSString *)name attributes:(NSString *)attributes;

/** 0 if the instance was created via \c +propertyWithName:attributes. */
@property (nonatomic, readonly) objc_property_t objc_property;

@property (nonatomic, readonly) NSString       *name;
@property (nonatomic, readonly) NSString       *backingIVar;
@property (nonatomic, readonly) NSString       *attributes;
@property (nonatomic, readonly) NSUInteger     attributeCount;
@property (nonatomic, readonly) MKTypeEncoding type;

@property (nonatomic, readonly) NSString *typeEncoding;
@property (nonatomic, readonly) NSString *oldTypeEncoding;
@property (nonatomic, readonly) SEL customGetter;
@property (nonatomic, readonly) SEL customSetter;

@property (nonatomic, readonly, getter = isReadOnly)           BOOL           readOnly;
@property (nonatomic, readonly, getter = isCopy)               BOOL               copy;
@property (nonatomic, readonly, getter = isRetained)           BOOL             retain;
@property (nonatomic, readonly, getter = isNonatomic)          BOOL          nonatomic;
@property (nonatomic, readonly, getter = isDynamic)            BOOL            dynamic;
@property (nonatomic, readonly, getter = isWeak)               BOOL               weak;
@property (nonatomic, readonly, getter = isGarbageCollectable) BOOL garbageCollectable;

/** Safe to use regardless of how the \c MKProperty instance was initialized. */
- (objc_property_attribute_t *)copyAttributesList:(unsigned int *)attributesCount;

@end
