//
//  TestRoot.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

typedef struct structure {
    int x;
    double y;
    unsigned long long z;
} MKStruct;

@interface TestRoot : NSObject

- (void)foo;
- (void)bar;
- (NSInteger)integer;
- (NSString *)string;
- (char *)cstring;
- (CGRect)rect;
- (MKStruct)structure;
- (NSInteger)sumThis:(NSInteger)first and:(NSInteger)second;

/// 123abc
@property (nonatomic, readonly) NSString  *identifier;
@property (nonatomic, readonly) NSInteger num;
@property (nonatomic, readonly) CGRect    rect;
@property                       CGFloat   timestamp;

@end
