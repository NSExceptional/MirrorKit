//
//  MKMirror.h
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKMirror : NSObject

+ (instancetype)reflect:(id)object;

/** The underlying object used to create this MKMirror. */
@property (nonatomic, readonly) id value;
@property (nonatomic, readonly) NSString *className;
@property (nonatomic) NSArray *properties;


@end
