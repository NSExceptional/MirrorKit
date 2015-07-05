//
//  MKMirror.h
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKMethod, MKProperty, MKIVar;
@import ObjectiveC;


#pragma mark MKMirror
@interface MKMirror : NSObject

+ (instancetype)reflect:(id)objectOrClass;

/** The underlying object or class used to create this \c MKMirror. */
@property (nonatomic, readonly) id       value;
@property (nonatomic, readonly) NSString *className;
@property (nonatomic, readonly) NSArray  *properties;
@property (nonatomic, readonly) NSArray  *instanceVariables;
@property (nonatomic, readonly) NSArray  *methods;
@property (nonatomic, readonly) NSArray  *protocols;

/** Returns a reflection of \c value.superClass. */
@property (nonatomic, readonly) MKMirror *superMirror;

@end
