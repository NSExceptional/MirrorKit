//
//  NSObject+Reflection.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ObjectiveC;
@class MKMethod, MKIVar, MKProperty;


#pragma mark Reflection
@interface NSObject (Reflection)

+ (NSArray *)allSubclasses;

/** @return The previous value of the objects \c class, or \c Nil if the object is \c nil. */
- (Class)setClass:(Class)cls;
/** @return The \c Class object for the metaclass of the class, or \c Nil if the class is not registered. */
+ (Class)metaclass;
/** @return The size in bytes of instances of the class \e cls, or \c 0 if \e cls is \c Nil. */
+ (size_t)instanceSize;

+ (Class)setSuperclass:(Class)superclass;

@end


#pragma mark Methods
@interface NSObject (Methods)

+ (NSArray *)allMethods;

/** @return YES if the method was added successfully, \c NO otherwise. */
+ (BOOL)addMethod:(SEL)selector typeEncoding:(NSString *)typeEncoding implementation:(IMP)implementaiton;
/** Not sure, but probably safe to make sure the given \c IMP takes the same parameters as the given method. */
+ (void)replaceImplementationOfMethod:(MKMethod *)method with:(IMP)implementation;
+ (void)swizzle:(MKMethod *)original with:(MKMethod *)other;
/** Returns \c YES if successful, \c NO if not. */
+ (BOOL)swizzleByName:(NSString *)original with:(NSString *)other;
+ (void)swizzle:(Class)cls original:(SEL)original with:(SEL)other;

@end


#pragma mark Properties
@interface NSObject (IVars)

+ (NSArray *)allIVars;

- (void *)getIVarAddress:(MKIVar *)ivar;
/** @return \c NULL if the IVar could not be found. */
- (void *)getIVarAddressByName:(NSString *)name;
/** This is faster than creating an \c MKIVar and calling \c -getIVarAddress: if you only have an \c Ivar. */
- (void *)getObjcIVarAddress:(Ivar)ivar;

/** Use only when the target instance variable is an object. */
- (void)setIvar:(MKIVar *)ivar object:(id)value;
/** Use only when the target instance variable is an object. @return \c NULL if the IVar could not be found. */
- (BOOL)setIVarByName:(NSString *)name object:(id)value;
/** Use only when the target instance variable is an object. This is faster than creating an \c MKIVar and calling \c -setIvar: if you only have an \c Ivar. */
- (void)setObjcIVar:(Ivar)ivar object:(id)value;

- (void)setIVar:(MKIVar *)ivar value:(void *)value size:(size_t)size;
/** @return \c YES if the IVar could be found, \c NO otherwise. */
- (BOOL)setIVarByName:(NSString *)name value:(void *)value size:(size_t)size;
/** This is faster than creating an \c MKIVar and calling \c -setIVar:value:size if you only have an \c Ivar. */
- (void)setObjcIVar:(Ivar)ivar value:(void *)value size:(size_t)size;

@end

#pragma mark Properties
@interface NSObject (Properties)

+ (NSArray *)allProperties;

- (void)replaceProperty:(MKProperty *)property;

@end