//
//  TestRoot.m
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "TestRoot.h"

@implementation TestRoot

- (id)init {
    self = [super init];
    if (self) {
        _identifier = @"123abc";
        _timestamp = [[NSDate date] timeIntervalSince1970];
        _obj = nil;
    }
    
    return self;
}

- (void)rootFoo {
    NSLog(@"called rootFoo");
}

- (void)rootBar {
    NSLog(@"called rootBar");
}

- (NSInteger)root_integer {
    NSLog(@"root_integer");
    return 555;
}

- (id)root_id {
    return @"root_id";
}

- (void)rootWithFoo:(id)foo andBar:(CGFloat)bar {
    NSLog(@"rootWithFoo: %@ andBar: %f", foo, bar);
}

- (char *)string {
    return "successful string";
}

- (CGRect)rect {
    return CGRectMake(1, 2, 3, 4);
}

- (MKStruct)structure {
    return (MKStruct){-5, 3.14159, 50};
}

@end
