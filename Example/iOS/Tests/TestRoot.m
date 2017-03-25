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
        _timestamp  = [[NSDate date] timeIntervalSince1970];
        _num        = 789;
        _rect       = CGRectMake(1, 2, 3, 4);
    }
    
    return self;
}

- (void)foo {
    NSLog(@"called rootFoo");
}

- (void)bar {
    NSLog(@"called rootBar");
}

- (NSInteger)integer {
    NSLog(@"root_integer");
    return 555;
}

- (NSString *)string {
    return @"root_id";
}

- (NSInteger)sumThis:(NSInteger)first and:(NSInteger)second {
    return first+second;
}

- (char *)cstring {
    return "successful string";
}

- (MKStruct)structure {
    return (MKStruct){-5, 3.14159, 50};
}

@end
