//
//  MKPropertyAttributes.h
//  MirrorKit
//
//  Created by Tanner on 7/5/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark MKPropertyAttributes

/** See \e MirrorKit-Constants.m for valid string tokens.
 See this link on how to construct a proper attributes string: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html */
@interface MKPropertyAttributes : NSObject {
    @protected
    NSUInteger _count;
    NSString *_attributesString, *_backingIVar, *_typeEncoding, *_oldTypeEncoding;
    SEL _customGetter, _customSetter;
    BOOL _isReadOnly, _isCopy, _isRetained, _isNonatomic, _isDynamic, _isWeak, _isGarbageCollectable;
}

/** @warning Raises an exception if \e attributes is invalid or \c nil. */
+ (instancetype)attributesFromString:(NSString *)attributes;
/** @warning Raises an exception if \e attributes is invalid, \c nil, or contains unsupported keys. */
+ (instancetype)attributesFromDictionary:(NSDictionary *)attributes;

@property (nonatomic, readonly) NSUInteger count;

@property (nonatomic, readonly) NSString *attributesString;

@property (nonatomic, readonly) NSString *backingIVar;
@property (nonatomic, readonly) NSString *typeEncoding;
@property (nonatomic, readonly) NSString *oldTypeEncoding;
@property (nonatomic, readonly) SEL customGetter;
@property (nonatomic, readonly) SEL customSetter;

@property (nonatomic, readonly) BOOL isReadOnly;
@property (nonatomic, readonly) BOOL isCopy;
@property (nonatomic, readonly) BOOL isRetained;
@property (nonatomic, readonly) BOOL isNonatomic;
@property (nonatomic, readonly) BOOL isDynamic;
@property (nonatomic, readonly) BOOL isWeak;
@property (nonatomic, readonly) BOOL isGarbageCollectable;

@end


#pragma mark MKPropertyAttributes
@interface MKMutablePropertyAttributes : MKPropertyAttributes

+ (instancetype)attributes;

@property (nonatomic) NSString *backingIVar;
@property (nonatomic) NSString *typeEncoding;
@property (nonatomic) NSString *oldTypeEncoding;
@property (nonatomic) SEL customGetter;
@property (nonatomic) SEL customSetter;

@property (nonatomic) BOOL isReadOnly;
@property (nonatomic) BOOL isCopy;
@property (nonatomic) BOOL isRetained;
@property (nonatomic) BOOL isNonatomic;
@property (nonatomic) BOOL isDynamic;
@property (nonatomic) BOOL isWeak;
@property (nonatomic) BOOL isGarbageCollectable;

- (void)setTypeEncodingChar:(char)type;

@end