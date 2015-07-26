//
//  MKMirror.h
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKMethod, MKProperty, MKIVar, MKProtocol;
@import ObjectiveC;


#pragma mark MKMirror
@interface MKMirror : NSObject

/** Reflects an instance of an object or \c Class.
 @discussion \c MKMirror will immediately gather all useful information. Consider using the
 \c NSObject categories provided if your code will only use a few pieces of information,
 or if your code needs to run faster.
 @param objectOrClass An instance of an objct or a \c Class object.
 @return An instance of \c MKMirror. */
+ (instancetype)reflect:(id)objectOrClass;

/** The underlying object or \c Class used to create this \c MKMirror instance. */
@property (nonatomic, readonly) id       value;
/** The name of the \c Class of the \c value property. */
@property (nonatomic, readonly) NSString *className;
/** All properties of the \c Class of the \c value property as \c MKProperty objects.*/
@property (nonatomic, readonly) NSArray  *properties;
/** All instance variables of the \c Class of the \c value property as \c MKIVar objects.*/
@property (nonatomic, readonly) NSArray  *instanceVariables;
/** All methods of the \c Class of the \c value property as \c MKMethod objects.*/
@property (nonatomic, readonly) NSArray  *methods;
/** All protocols of the \c Class of the \c value property as \c MKProtocol objects.*/
@property (nonatomic, readonly) NSArray  *protocols;

/** Returns a reflection of \c value.superClass. */
@property (nonatomic, readonly) MKMirror *superMirror;

@end


@interface MKMirror (ExtendedMirror)

/** @return The method with the given name, or \c nil if one does not exist. */
- (MKMethod *)methodNamed:(NSString *)name;
/** @return The property with the given name, or \c nil if one does not exist. */
- (MKProperty *)propertyNamed:(NSString *)name;
/** @return The instance variable with the given name, or \c nil if one does not exist. */
- (MKIVar *)ivarNamed:(NSString *)name;
/** @return The protocol with the given name, or \c nil if one does not exist. */
- (MKProtocol *)protocolNamed:(NSString *)name;

@end