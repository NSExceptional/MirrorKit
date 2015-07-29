//
//  NSObject+Reflection.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ObjectiveC;
@class MKMethod, MKIVar, MKProperty, MKSimpleMethod, MKPropertyAttributes;

/** Returns the type encoding string given the encoding for the return type and parameters, if any.
 @discussion Example usage for a \c void returning method which takes an \c int: @code MKTypeEncoding(@encode(void), @encode(int));
 @param returnType The encoded return type. \c void for exmaple would be \c @encode(void).
 @param count The number of parameters in this type encoding string.
 @return The type encoding string, or \c nil if \e returnType is \c NULL. */
extern NSString * MKTypeEncodingString(const char *returnType, NSUInteger count, ...);

#pragma mark Reflection
@interface NSObject (Reflection)

+ (NSArray *)allSubclasses;

/** Changes the class of an object instance.
 @return The previous value of the objects \c class, or \c Nil if the object is \c nil. */
- (Class)setClass:(Class)cls;
/** @return The \c Class object for the metaclass of the recieving class, or \c Nil if the class is Nil or not registered. */
+ (Class)metaclass;
/** @return The size in bytes of instances of the recieving class, or \c 0 if \e cls is \c Nil. */
+ (size_t)instanceSize;
/** Sets the recieving class's superclass. "You should not use this method" — Apple.
 @return The old superclass. */
+ (Class)setSuperclass:(Class)superclass;

@end


#pragma mark Methods
@interface NSObject (Methods)

+ (NSArray *)allMethods;

/** Adds a new method to the recieving class with a given name and implementation.
 @discussion This method will add an override of a superclass's implementation,
 but will not replace an existing implementation in the class.
 To change an existing implementation, use \c replaceImplementationOfMethod:with:.
 
 Type encodings start with the return type and end with the parameter types in order.
 The type encoding for \c NSArray's \c count property getter looks like this:
 @code [NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(NSUInteger)] @endcode
 Using the \c MKTypeEncoding function for the same method looks like this: @code MKTypeEncodingString(@encode(void), 1, @encode(NSUInteger)) @endcode
 @param typeEncoding The type encoding string. Consider using the \c MKTypeEncodingString() function.
 @return YES if the method was added successfully, \c NO otherwise
 (for example, the class already contains a method implementation with that name). */
+ (BOOL)addMethod:(SEL)selector typeEncoding:(NSString *)typeEncoding implementation:(IMP)implementaiton;
/** Replaces the implementation of a method in the recieving class.
 @note This function behaves in two different ways:
  - If the method does not yet exist in the recieving class, it is added as if \c addMethod:typeEncoding:implementation were called.
  - If the method does exist, its \c IMP is replaced.
 @return The previous \c IMP of \e method. */
+ (IMP)replaceImplementationOfMethod:(MKSimpleMethod *)method with:(IMP)implementation;
/** Swaps the implementations of the given methods.
 @discussion If one or neither of the given methods exist in the recieving class,
 they are added to the class with their implementations swapped as if each method did exist.
 This method will not fail if each \c MKSimpleMethod contains a valid selector. */
+ (void)swizzle:(MKSimpleMethod *)original with:(MKSimpleMethod *)other;
/** Swaps the implementations of the given methods.
 @return \c YES if successful, and \c NO if selectors could not be retrieved from the given strings. */
+ (BOOL)swizzleByName:(NSString *)original with:(NSString *)other;
/** Swaps the implementations of methods corresponding to the given selectors. */
+ (void)swizzleBySelector:(SEL)original with:(SEL)other;

@end


#pragma mark Properties
@interface NSObject (IVars)

/** All of the instance variables specific to the recieving class.
 @discussion This method will only retrieve instance varibles specific to the recieving class.
 To retrieve instance variables on a parent class, simply call \c [[self superclass] allIVars].
 @return An array of \c MKIVar objects. */
+ (NSArray *)allIVars;

/** @return The address of the given instance variable in the recieving object in memory, or \c NULL if it could not be found. */
- (void *)getIVarAddress:(MKIVar *)ivar;
/** @return The address of the given instance variable in the recieving object in memory, or \c NULL if it could not be found. */
- (void *)getIVarAddressByName:(NSString *)name;
/** @discussion This method faster than creating an \c MKIVar and calling \c -getIVarAddress: if you already have an \c Ivar on hand
 @return The address of the given instance variable in the recieving object in memory, or \c NULL if it could not be found\. */
- (void *)getObjcIVarAddress:(Ivar)ivar;

/** Sets the value of the given instance variable on the recieving object.
 @discussion Use only when the target instance variable is an object. */
- (void)setIvar:(MKIVar *)ivar object:(id)value;
/** Sets the value of the given instance variable on the recieving object.
 @discussion Use only when the target instance variable is an object.
 @return \c YES if successful, or \c NO if the instance variable could not be found. */
- (BOOL)setIVarByName:(NSString *)name object:(id)value;
/** @discussion Use only when the target instance variable is an object.
 This method is faster than creating an \c MKIVar and calling \c -setIvar: if you already have an \c Ivar on hand. */
- (void)setObjcIVar:(Ivar)ivar object:(id)value;

/** Sets the value of the given instance variable on the recieving object to the \e size number of bytes of data at \e value.
 @discussion Use one of the other methods if you can help it. */
- (void)setIVar:(MKIVar *)ivar value:(void *)value size:(size_t)size;
/** Sets the value of the given instance variable on the recieving object to the \e size number of bytes of data at \e value.
 @discussion Use one of the other methods if you can help it
 @return \c YES if successful, or \c NO if the instance variable could not be found. */
- (BOOL)setIVarByName:(NSString *)name value:(void *)value size:(size_t)size;
/** Sets the value of the given instance variable on the recieving object to the \e size number of bytes of data at \e value.
 @discussion This is faster than creating an \c MKIVar and calling \c -setIVar:value:size if you already have an \c Ivar on hand. */
- (void)setObjcIVar:(Ivar)ivar value:(void *)value size:(size_t)size;

@end

#pragma mark Properties
@interface NSObject (Properties)

/** All of the properties specific to the recieving class.
 @discussion This method will only retrieve instance varibles specific to the recieving class.
 To retrieve instance variables on a parent class, simply call \c [[self superclass] allIVars].
 @return An array of \c MKProperty objects. */
+ (NSArray *)allProperties;
/** Replaces the given property on the recieving class. */
+ (void)replaceProperty:(MKProperty *)property;
/** Replaces the given property on the recieving class. Useful for changing a property's attributes. */
+ (void)replaceProperty:(NSString *)name attributes:(MKPropertyAttributes *)attributes;

@end