//
//  MKMethod.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKObject.h"

@interface MKMethod : MKObject

+ (instancetype)method:(Method)method;

@property (nonatomic, readonly) Method            objc_method;
@property (nonatomic          ) IMP               implementation;
@property (nonatomic, readonly) SEL               selector;
@property (nonatomic, readonly) NSString          *selectorString;
@property (nonatomic, readonly) NSMethodSignature *signature;
@property (nonatomic, readonly) NSString          *signatureString;

/** Throws an exception if the method returns anything but @c id. */
- (id)sendMessage:(id)target, ...;
/** Used for other return types. Pass @c NULL to the first parameter for void methods. */
- (void)getReturnValue:(void *)retPtr forMessageSend:(id)target, ...;

@end
