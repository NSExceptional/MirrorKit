//
//  MKMethod.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ObjectiveC;

@interface MKMethod : NSObject

+ (instancetype)method:(Method)method;
+ (instancetype)methodForSelector:(SEL)selector class:(Class)cls;

@property (nonatomic, readonly) Method            objc_method;
/** Setting \c implementation will change the implementation of this method for the entire class which implements said method. It will also not modify the selector of said method. */
@property (nonatomic          ) IMP               implementation;
@property (nonatomic, readonly) SEL               selector;
@property (nonatomic, readonly) NSUInteger        numberOfArguments;
@property (nonatomic, readonly) NSString          *selectorString;
@property (nonatomic, readonly) NSMethodSignature *signature;
@property (nonatomic, readonly) NSString          *signatureString;
/** Same as \c signatureString but without the parameter sizes and offsets. */
@property (nonatomic, readonly) NSString          *typeEncoding;

- (void)swapImplementations:(MKMethod *)method;

#define MKMagicNumber 0xdeadbeef
#define MKArg(expr) MKMagicNumber, @encode(__typeof__(expr)), (__typeof__(expr) []){ expr }
/** Throws an exception if the method returns anything but \c id. */
- (id)sendMessage:(id)target, ...;
/** Used for other return types. Pass \c NULL to the first parameter for void methods. */
- (void)getReturnValue:(void *)retPtr forMessageSend:(id)target, ...;

@end
