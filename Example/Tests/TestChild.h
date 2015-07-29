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

- (void)foo;
- (void)bar;

@property (nonatomic, copy) NSString   *name;
@property (nonatomic      ) NSUInteger age;

@end
