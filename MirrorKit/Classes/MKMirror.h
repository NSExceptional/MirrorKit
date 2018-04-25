//
//  MKMirror.h
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@class MKMethod, MKProperty, MKIVar, MKProtocol;


#pragma mark MKMirror
@interface MKMirror : NSObject

/// Reflects an instance of an object or \c Class.
/// @discussion \c MKMirror will immediately gather all useful information. Consider using the
/// \c NSObject categories provided if your code will only use a few pieces of information,
/// or if your code needs to run faster.
///
/// If you reflect an instance of a class then \c methods and \c properties will be populated
/// with instance methods and properties. If you reflect a class itself, then \c methods
/// and \c properties will be populated with class methods and properties as you'd expect.
///
/// @param objectOrClass An instance of an objct or a \c Class object.
/// @return An instance of \c MKMirror.
+ (instancetype)reflect:(id)objectOrClass;

/// The underlying object or \c Class used to create this \c MKMirror instance.
@property (nonatomic, readonly) id   value;
/// Whether the reflected thing was a class or a class instance.
@property (nonatomic, readonly) BOOL isClass;
/// The name of the \c Class of the \c value property.
@property (nonatomic, readonly) NSString *className;

@property (nonatomic, readonly) NSArray<MKProperty*> *properties;
@property (nonatomic, readonly) NSArray<MKIVar*>     *instanceVariables;
@property (nonatomic, readonly) NSArray<MKMethod*>   *methods;
@property (nonatomic, readonly) NSArray<MKProtocol*> *protocols;

/// @return A reflection of \c value.superClass.
@property (nonatomic, readonly) MKMirror *superMirror;

/// @discussion This method is very likely to cause a crash, use at your own risk.
/// Some classes are just not save to touch at all. I did my best to hard code in some unsafe
/// classes to avoid, but Apple might add more at any time.
/// @return An array of all classes known to the runtime.
+ (NSArray *)allClasses;

@end


@interface MKMirror (ExtendedMirror)

/// @return The method with the given name, or \c nil if one does not exist.
- (MKMethod *)methodNamed:(NSString *)name;
/// @return The property with the given name, or \c nil if one does not exist.
- (MKProperty *)propertyNamed:(NSString *)name;
/// @return The instance variable with the given name, or \c nil if one does not exist.
- (MKIVar *)ivarNamed:(NSString *)name;
/// @return The protocol with the given name, or \c nil if one does not exist.
- (MKProtocol *)protocolNamed:(NSString *)name;

@end
