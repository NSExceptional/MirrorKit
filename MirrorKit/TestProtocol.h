//
//  TestProtocol.h
//  MirrorKit
//
//  Created by Tanner on 6/30/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TestProtocol <NSObject>

- (id)protocol_foo_;
- (void)protocol_setBar:(id)bar;

@property (nonatomic) id protocol_foobar;
@property (nonatomic, readonly) id protocol_barfoo_;

@end
