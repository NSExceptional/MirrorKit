//
//  TestChild.m
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "TestChild.h"

@implementation TestChild

#pragma mark Parent overrides

- (void)setTimestamp:(CGFloat)timestamp {
    NSLog(@"child override: setTimestamp:");
    [super setTimestamp:timestamp];
}

- (void)root_void {
    NSLog(@"child override: root_void");
    [super root_void];
}


#pragma mark TestChild methods

- (id)init {
    self = [super init];
    if (self) {
        _name = @"tanner";
        _age = 12;
    }
    
    return self;
}

- (void)child_void {
    NSLog(@"child_void");
}

- (NSInteger)child_integer {
    NSLog(@"child_integer");
    return 666;
}

- (id)child_id {
    return @"child_id";
}

- (void)childWithFoo:(id)foo andBar:(CGFloat)bar {
    NSLog(@"childWithFoo: %@ andBar: %f", foo, bar);
}

#pragma mark TestProtocol

- (id)protocol_foo_ {
    return @"value: protocol_foo_";
}

- (void)protocol_setBar:(id)bar {
    
}

- (id)protocol_foobar {
    return @"property value: protocol_foobar";
}

- (void)setProtocol_foobar:(id)protocol_foobar {
    NSLog(@"property set: protocol_foobar");
}

- (id)protocol_barfoo_ {
    return @"value: protocol_barfoo_";
}

@end
