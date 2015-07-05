//
//  MKProtocol.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - MKProtocol -
@interface MKProtocol : NSObject

+ (NSArray *)allProtocols;
+ (instancetype)protocol:(Protocol *)protocol;

@property (nonatomic, readonly) Protocol *objc_protocol;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray  *properties;
@property (nonatomic, readonly) NSArray  *requiredMethods;
@property (nonatomic, readonly) NSArray  *optionalMethods;
@property (nonatomic, readonly) NSArray  *protocols;

/** Not to be confused with \c -conformsToProtocol:, which refers to the current \c MKProtocol instance and not the underlying Protocol object. */
- (BOOL)conformsTo:(Protocol *)protocol;

@end


#pragma mark - Method descriptions -
@interface MKMethodDescription : NSObject

+ (instancetype)description:(struct objc_method_description)methodDescription;

@property (nonatomic, readonly) struct objc_method_description objc_description;
@property (nonatomic, readonly) SEL selector;
@property (nonatomic, readonly) NSString *typeEncoding;

@end