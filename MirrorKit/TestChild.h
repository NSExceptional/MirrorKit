//
//  TestChild.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import "TestRoot.h"
#import "TestProtocol.h"

@interface TestChild : TestRoot <TestProtocol>

- (void)child_void;
- (NSInteger)child_integer;
- (id)child_id;
- (void)childWithFoo:(id)foo andBar:(CGFloat)bar;

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;

@end
