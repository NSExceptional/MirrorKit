//
//  main.m
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ObjectiveC;

#import "MirrorKit.h"
#import "TestRoot.h"
#import "TestChild.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        TestRoot *ro = [TestRoot new];
        TestChild *c = [TestChild new];
        MKMirror *rootmirror  = [MKMirror reflect:ro];
        MKMirror *childmirror = [MKMirror reflect:c];
        
        // Replace a method //
        
        // Test foo before replacement
        [ro rootFoo];
        
        // Find some methods
        MKMethod *oldFoo, *newFoo;
        for (MKMethod *m in rootmirror.methods) {
            if ([m.selectorString isEqualToString:@"rootFoo"])
                oldFoo = m;
            else if ([m.selectorString isEqualToString:@"rootBar"])
                newFoo = m;
        }
        
        // Replace one
        IMP fooimp = imp_implementationWithBlock(^(id self, SEL _cmd) {
            NSLog(@"New foo, id: %@", [self identifier]);
        });
        oldFoo.implementation = fooimp;
        // Test foo after replacement
        [ro rootFoo];
        // Replaced across all instances of the class
        TestRoot *rf = [TestRoot new];
        [rf rootFoo];
        
        
        // Add an entirely new method //
        
        // Type encoding string [return type][self][_cmd][first param][second param]
        NSString *types = [NSString stringWithFormat:@"%s%s%s%s%s", @encode(id), @encode(id), @encode(SEL), @encode(id), @encode(NSUInteger)];
        // Make the selector
        SEL printfoobar = sel_registerName("printFoo:bar:");
        // Actually add the method; do not include _cmd in the block's arguments list
        BOOL didAddMethod = [ro addMethod:printfoobar typeEncoding:types implementation:imp_implementationWithBlock(^(id self, NSString *s, NSUInteger i) {
            NSLog(@"Called printFoo:bar: %@ : %lu", s, i);
            return [s capitalizedString];
        })];
        
        // Get MKMethod object via selector and class
        MKMethod *newMethod = [MKMethod methodForSelector:printfoobar class:ro.class];
        
        // Call method and view return value
        NSString *ret;
        [newMethod getReturnValue:&ret forMessageSend:ro, MKArg(@"hi there"), MKArg((NSUInteger)0xdeadbee5)];
        NSLog(@"Method returned with result: %@", ret);
        
        while (true) { [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]]; }
    }
    
    return 0;
}

#pragma clang diagnostic pop
