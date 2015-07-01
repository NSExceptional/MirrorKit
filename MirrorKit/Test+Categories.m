//
//  Test+Categories.m
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "Test+Categories.h"

@implementation TestRoot (RootUtilities)

- (void)util_root_void_ {
    
}

- (NSInteger)util_root_integer_ {
    return 123;
}

- (id)util_root_id_ {
    return nil;
}

- (void)util_root_withFoo:(id)foo andBar:(CGFloat)bar {
    
}

- (id)util_root_foo {
    return nil;
}

- (void)setUtil_root_foo:(id)util_root_foo {
    
}

- (NSUInteger)util_root_bar {
    return 281;
}

- (void)setUtil_root_bar:(NSUInteger)util_root_bar {
    
}

@end


@implementation TestChild (ChildUtilities)

- (void)util_child_void_ {
    
}

- (NSInteger)util_child_integer_ {
    return 456;
}

- (id)util_child_id_ {
    return nil;
}

- (void)util_child_withFoo:(id)foo andBar:(CGFloat)bar {
    
}

- (id)util_child_foo {
    return nil;
}

- (void)setUtil_child_foo:(id)util_child_foo {
    
}

- (CGFloat)util_child_bar {
    return 1.168;
}

- (void)setUtil_child_bar:(CGFloat)util_child_bar {
    
}

@end
