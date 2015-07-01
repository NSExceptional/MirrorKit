//
//  MKProperty.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKObject.h"


@interface MKProperty : MKObject

+ (instancetype)property:(objc_property_t)property;

@property (nonatomic, readonly) objc_property_t objc_property;

@property (nonatomic, readonly) NSString       *name;
@property (nonatomic, readonly) NSString       *backingIVar;
@property (nonatomic, readonly) NSString       *attributes;
@property (nonatomic, readonly) MKPropertyType type;

@property (nonatomic, readonly) NSString *typeEncoding;
@property (nonatomic, readonly) NSString *oldTypeEncoding;
@property (nonatomic, readonly) NSString *customGetter;
@property (nonatomic, readonly) NSString *customSetter;

@property (nonatomic, readonly, getter = isReadOnly)           BOOL           readOnly;
@property (nonatomic, readonly, getter = isCopy)               BOOL               copy;
@property (nonatomic, readonly, getter = isRetained)           BOOL             retain;
@property (nonatomic, readonly, getter = isNonatomic)          BOOL          nonatomic;
@property (nonatomic, readonly, getter = isDynamic)            BOOL            dynamic;
@property (nonatomic, readonly, getter = isWeak)               BOOL               weak;
@property (nonatomic, readonly, getter = isGarbageCollectable) BOOL garbageCollectable;

@end
