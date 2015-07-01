//
//  NSString+Utilities.h
//  MirrorKit
//
//  Created by Tanner on 7/1/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)

- (NSString *)stringbyDeletingCharacterAtIndex:(NSUInteger)idx;

- (NSDictionary *)propertyAttributes;

@end
