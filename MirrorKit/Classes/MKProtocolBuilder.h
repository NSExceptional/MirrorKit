//
//  MKProtocolBuilder.h
//  MirrorKit
//
//  Created by Tanner on 7/4/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKProperty, Protocol;

@interface MKProtocolBuilder : NSObject

+ (instancetype)allocateProtocol:(NSString *)name;

- (void)addProperty:(MKProperty *)property isRequired:(BOOL)isRequired;
- (void)addMethod:(SEL)selector typeEncoding:(NSString *)typeEncoding isRequired:(BOOL)isRequired isInstanceMethod:(BOOL)isInstanceMethod;
- (void)addProtocol:(Protocol *)protocol;

- (Protocol *)registerProtocol;
@property (nonatomic, readonly) BOOL isRegistered;

@end
