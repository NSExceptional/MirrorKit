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
        
        // Test foo before replacement
        [ro rootFoo];
        
        MKMethod *oldFoo, *newFoo;
        for (MKMethod *m in rootmirror.methods) {
            if ([m.selectorString isEqualToString:@"rootFoo"])
                oldFoo = m;
            else if ([m.selectorString isEqualToString:@"rootBar"])
                newFoo = m;
        }
        
        oldFoo.implementation = newFoo.implementation;
        // Test foo after replacement
        [ro rootFoo];
        
        TestRoot *rf = [TestRoot new];
        [rf rootFoo];
        
        NSArray *arrays = [NSIndexSet allSubclasses];
        
        while (true) { [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]]; }
    }
    
    return 0;
}

#pragma clang diagnostic pop
