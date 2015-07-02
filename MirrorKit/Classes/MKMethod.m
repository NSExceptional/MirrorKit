//
//  MKMethod.m
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "MKMethod.h"

@implementation MKMethod

- (id)init { [NSException raise:NSInternalInconsistencyException format:@"Class instance should not be created with -init"]; return nil; }

+ (instancetype)method:(Method)method {
    return [[self alloc] initWithMethod:method];
}

- (id)initWithMethod:(Method)method {
    NSParameterAssert(method);
    
    self = [super init];
    if (self) {
        _objc_method = method;
        [self examine];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ selector=%@, signature=%@>",
            NSStringFromClass(self.class), self.selectorString, self.signatureString];
}

- (void)examine {
    _implementation  = method_getImplementation(self.objc_method);
    _selector        = method_getName(self.objc_method);
    _selectorString  = NSStringFromSelector(self.selector);
    _signatureString = @(method_getTypeEncoding(self.objc_method));
    _signature       = [NSMethodSignature signatureWithObjCTypes:self.signatureString.UTF8String];
}

#pragma mark Setters

- (void)setImplementation:(IMP)implementation {
    NSParameterAssert(implementation);
    method_setImplementation(self.objc_method, implementation);
    _implementation = implementation;
}

#pragma mark Message sending

// Code borrowed from MAObjcRuntime, by Mike Ash.
- (id)sendMessage:(id)target, ... {
    // Message must return type id
    NSParameterAssert([self.signatureString hasPrefix:@(@encode(id))]);
    
    id ret = nil;
    
    va_list args;
    va_start(args, target);
    [self getReturnValue:&ret forMessageSend:target arguments:args];
    va_end(args);
    
    return ret;
}

// Code borrowed from MAObjcRuntime, by Mike Ash.
- (void)getReturnValue:(void *)retPtr forMessageSend:(id)target, ... {
    va_list args;
    va_start(args, target);
    [self getReturnValue:retPtr forMessageSend:target arguments:args];
    va_end(args);
}

// Code borrowed from MAObjcRuntime, by Mike Ash.
- (void)getReturnValue:(void *)retPtr forMessageSend:(id)target arguments:(va_list)args {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:self.signature];
    NSUInteger argumentCount = self.signature.numberOfArguments;
    
    invocation.target   = target;
    invocation.selector = self.selector;
    
    for(NSUInteger i = 2; i < argumentCount; i++) {
        const char *typeString = va_arg(args, char *);
        void *argPointer       = va_arg(args, void *);
        
        NSUInteger inSize, sigSize;
        NSGetSizeAndAlignment(typeString, &inSize, NULL);
        NSGetSizeAndAlignment([self.signature getArgumentTypeAtIndex:i], &sigSize, NULL);
        
        if(inSize != sigSize) {
            NSLog(@"%s:size mismatch between passed-in argument and required argument; in type:%s (%lu) requested:%s (%lu)",
                  __func__, typeString, (long)inSize, [self.signature getArgumentTypeAtIndex:i], (long)sigSize);
            abort();
        }
        
        [invocation setArgument:argPointer atIndex:i];
    }
    
    [invocation invoke];
    
    if(self.signature.methodReturnLength && retPtr)
        [invocation getReturnValue:retPtr];
}

@end
