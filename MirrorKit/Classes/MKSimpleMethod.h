//
//  MKSimpleMethod.h
//  MirrorKit
//
//  Created by Tanner on 7/5/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_INLINE void MKCallSuperImplementation(id self, Class superclass, SEL selector) {
    void (*superIMP)(id, SEL) = (void *)[superclass instanceMethodForSelector:selector];
    superIMP(self, selector);
}
@interface MKSimpleMethod : NSObject {
    @protected
    SEL      _selector;
    NSString *_typeEncoding;
    IMP      _implementation;
}

+ (instancetype)buildMethodNamed:(NSString *)name withTypes:(NSString *)typeEncoding implementation:(IMP)implementation;

@property (nonatomic, readonly) SEL      selector;
@property (nonatomic, readonly) NSString *typeEncoding;
@property (nonatomic, readonly) IMP      implementation;

@end
