//
//  main.m
//  MirrorKit
//
//  Created by Tanner on 6/29/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>

#import "MirrorKit.h"
#import "TestRoot.h"
#import "TestChild.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        TestRoot *ro = [TestRoot new];
        TestChild *c = [TestChild new];
        
        id thing = [NSArray alloc];
        
        MKMirror *rootmirror  = [MKMirror reflect:ro];
        MKMirror *childmirror = [MKMirror reflect:c];
        MKMirror *arraymirror = [MKMirror reflect:thing];
        MKMirror *classmirror = [MKMirror reflect:c.class];
        
        MKMirror *supermirror = classmirror.superReflection;
        
        MKMethod *method = rootmirror.methods[0];
        [method getReturnValue:NULL forMessageSend:ro];
        
        
        while (true) { [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]]; }
    }
    
    return 0;
}

#pragma clang diagnostic pop
