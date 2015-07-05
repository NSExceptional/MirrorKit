//
//  TestRoot.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestRoot : NSObject

- (void)rootFoo;
- (void)rootBar;
- (NSInteger)root_integer;
- (id)root_id;
- (void)rootWithFoo:(id)foo andBar:(CGFloat)bar;

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSObject *obj;
@property (nonatomic, readonly) CGRect   rect;
@property                       CGFloat  timestamp;

@end
