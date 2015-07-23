//
//  MKMethod.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKSimpleMethod.h"
#import "MirrorKit-Constants.h"
@import ObjectiveC;

@interface MKMethod : MKSimpleMethod

+ (instancetype)method:(Method)method;
+ (instancetype)methodForSelector:(SEL)selector class:(Class)cls;

@property (nonatomic, readonly) Method            objc_method;
/** Setting \c implementation will change the implementation of this method for the entire class which implements said method. It will also not modify the selector of said method. */
@property (nonatomic          ) IMP               implementation;
@property (nonatomic, readonly) NSUInteger        numberOfArguments;
@property (nonatomic, readonly) NSString          *selectorString;
@property (nonatomic, readonly) NSMethodSignature *signature;
/** Same as \e typeEncoding but with parameter sizes up front and offsets after the types. */
@property (nonatomic, readonly) NSString          *signatureString;
@property (nonatomic, readonly) MKTypeEncoding    returnType;

- (void)swapImplementations:(MKMethod *)method;

#define MKMagicNumber 0xdeadbeef
#define MKArg(expr) MKMagicNumber, @encode(__typeof__(expr)), (__typeof__(expr) []){ expr }

/** Sends a message to \e target, and returns it's value, or \c nil if not applicable.
 @discussion You may send any message with this method. Primitive return values will be wrapped
 in instances of \c NSNumber and \c NSValue. \c void and bitfield returning methods return \c nil.
 \c SEL return types are converted to strings using \c NSStringFromSelector.
 @return The object returned by this method, or an instance of \c NSValue or \c NSNumber containing
 the primitive return type, or a string for \c SEL return types. */
- (id)sendMessage:(id)target, ...;
/** Used internally by \c sendMessage:target,. Pass \c NULL to the first parameter for void methods. */
- (void)getReturnValue:(void *)retPtr forMessageSend:(id)target, ...;

@end
