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
@class MKPropertyAttributes, MKSimpleMethod;


@interface MKProperty : NSObject

+ (instancetype)property:(objc_property_t)property;
+ (instancetype)propertyWithName:(NSString *)name attributesString:(NSString *)attributesString;
+ (instancetype)propertyWithName:(NSString *)name attributes:(MKPropertyAttributes *)attributes;

/** 0 if the instance was created via \c +propertyWithName:attributes. */
@property (nonatomic, readonly) objc_property_t      objc_property;

@property (nonatomic, readonly) NSString             *name;
@property (nonatomic, readonly) MKTypeEncoding       type;
@property (nonatomic, readonly) MKPropertyAttributes *attributes;

/** Safe to use regardless of how the \c MKProperty instance was initialized. */
- (objc_property_attribute_t *)copyAttributesList:(unsigned int *)attributesCount;

- (MKSimpleMethod *)getterWithImplementation:(IMP)implementation;
- (MKSimpleMethod *)setterWithImplementation:(IMP)implementation;

@end
