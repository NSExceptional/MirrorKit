//
//  MKIVar.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MirrorKit-Constants.h"
@import ObjectiveC;

@interface MKIVar : NSObject

+ (instancetype)ivar:(Ivar)ivar;

@property (nonatomic, readonly) Ivar           objc_ivar;

@property (nonatomic, readonly) NSString       *name;
@property (nonatomic, readonly) MKTypeEncoding type;
@property (nonatomic, readonly) NSString       *typeEncoding;
@property (nonatomic, readonly) NSInteger      offset;

@end
