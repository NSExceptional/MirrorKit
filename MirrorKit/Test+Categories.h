//
//  Test+Categories.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestRoot.h"
#import "TestChild.h"

@interface TestRoot (RootUtilities)

- (void)util_root_void_;
- (NSInteger)util_root_integer_;
- (id)util_root_id_;
- (void)util_root_withFoo:(id)foo andBar:(CGFloat)bar;

@property (nonatomic) id util_root_foo;
@property (nonatomic) NSUInteger util_root_bar;

@end


@interface TestChild (ChildUtilities)

- (void)util_child_void_;
- (NSInteger)util_child_integer_;
- (id)util_child_id_;
- (void)util_child_withFoo:(id)foo andBar:(CGFloat)bar;

@property (nonatomic) id util_child_foo;
@property (nonatomic) CGFloat util_child_bar;

@end