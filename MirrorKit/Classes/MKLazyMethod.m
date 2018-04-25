//
//  MKLazyMethod.m
//  Pods
//
//  Created by Tanner on 3/25/17.
//
//

#import "MKLazyMethod.h"

@implementation MKLazyMethod

#pragma mark Initialization

/// Override to do nothing, all examined properties will be lazily initialized
- (void)examine { }

#pragma mark Lazy property overrides

- (SEL)selector {
    if (!_selector) {
        _selector = method_getName(_objc_method);
    }

    return _selector;
}

- (NSString *)selectorString {
    if (!_selectorString) {
        _selectorString = NSStringFromSelector(self.selector);
    }

    return _selectorString;
}

- (NSString *)typeEncoding {
    if (!_typeEncoding) {
        NSString *s = _signatureString;
        _typeEncoding = [s stringByReplacingOccurrencesOfString:@"\\d"
                                                     withString:@""
                                                        options:NSRegularExpressionSearch
                                                          range:NSMakeRange(0, s.length)];
    }

    return _typeEncoding;
}

- (IMP)implementation {
    if (!_implementation) {
        _implementation = method_getImplementation(_objc_method);
    }

    return _implementation;
}

- (NSUInteger)numberOfArguments {
    if (!_numberOfArguments) {
        _numberOfArguments = method_getNumberOfArguments(_objc_method);
    }

    return _numberOfArguments;
}

- (MKTypeEncoding)returnType {
    if (!_returnType) {
        _returnType = (MKTypeEncoding)[_signatureString characterAtIndex:0];
    }

    return _returnType;
}

- (NSString *)fullName {
    if (!_fullName) {
        _fullName = [self debugNameGivenClassName:NSStringFromClass(_targetClass)];
    }

    return _fullName;
}

@end
