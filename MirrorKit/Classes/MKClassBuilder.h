//
//  MKClassBuilder.h
//  MirrorKit
//
//  Created by Tanner on 7/3/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - MKClassBuilder -
@interface MKClassBuilder : NSObject

@property (nonatomic, readonly) Class workingClass;

/** Implicitly inherits from \c NSObject with \c 0 extra bytes. */
+ (instancetype)allocateClass:(NSString *)name;
/** Calls \c -allocateClass:superclass:extraBytes: with \c 0 extra bytes. */
+ (instancetype)allocateClass:(NSString *)name superclass:(Class)superclass;
/** Allocates a new class object with the given name and superclass. Classes created this way must be registered with \c -registerClass before being used. */
+ (instancetype)allocateClass:(NSString *)name superclass:(Class)superclass extraBytes:(size_t)bytes;
/** Use this to modify existing classes. @warning You cannot add instance variables to existing classes. */
+ (instancetype)builderForClass:(Class)cls;

/** @param methods An array of \c MKSimpleMethod objects. @return Any methods that failed to be added. */
- (NSArray *)addMethods:(NSArray *)methods;
/** @param methods An array of \c MKProperty objects. @return Any properties that failed to be added. */
- (NSArray *)addProperties:(NSArray *)properties;
/** @param methods An array of \c MKProtocol objects. @return Any protocols that failed to be added. */
- (NSArray *)addProtocols:(NSArray *)protocols;
/** @param methods An array of \c MKIVarBuilder objects. @warning Adding IVars to existing classes is not supported and will always fail. */
- (NSArray *)addIVars:(NSArray *)ivars;

/** Call this to make an allocated class usable in the runtime. @note Raises an exception if called on a previously registered class. */
- (Class)registerClass;
/** Uses \c objc_lookupClass to determine if the working class is registered. */
@property (nonatomic, readonly) BOOL isRegistered;

@end


#pragma mark - MKIVarBuilder -
@interface MKIVarBuilder : NSObject

/** @param name The name of the IVar, such as \c \@"_value".
    @param size The size of the IVar. Usually \c sizeof(type). For objects, this is \c sizeof(id).
    @param alignment The alignment of the IVar. Usually \c log2(sizeof(type)).
    @param encoding The type encoding of the IVar. For objects, this is \c \@(\@encode(id)), and for others it is \c \@(\@encode(type)). */
+ (instancetype)name:(NSString *)name size:(size_t)size alignment:(uint8_t)alignment typeEncoding:(NSString *)encoding;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *encoding;
@property (nonatomic, readonly) size_t   size;
@property (nonatomic, readonly) uint8_t  alignment;

@end
