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
        
        
        ////////////////////////////
        // Create an entire class //
        ////////////////////////////
        
        // Start here by naming it
        MKClassBuilder *builder = [MKClassBuilder allocateClass:@"NSAtom"];
        
        // Create IVars...
        MKIVarBuilder *iName = [MKIVarBuilder name:@"_name" size:sizeof(id) alignment:log2(sizeof(id)) typeEncoding:@(@encode(id))];
        MKIVarBuilder *iLength = [MKIVarBuilder name:@"_length" size:sizeof(NSUInteger) alignment:log2(sizeof(NSUInteger)) typeEncoding:@(@encode(NSUInteger))];
        
        // Create some methods...
        NSString *minitTypes = [NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)];
        NSString *mFooTypes = [NSString stringWithFormat:@"%s%s%s", @encode(void), @encode(id), @encode(SEL)];
        NSString *mBarTypes = [NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(id), @encode(SEL), @encode(id)];
        MKSimpleMethod *minit = [MKSimpleMethod buildMethodNamed:@"init" withTypes:minitTypes implementation:imp_implementationWithBlock(^(id self) {
            NSUInteger len = 6;
            [self setIVarByName:iLength.name value:&len size:sizeof(len)];
            [self setIVarByName:iName.name object:@"Tanner"];
            NSLog(@"Called init");
            return self;
        })];
        MKSimpleMethod *mFoo = [MKSimpleMethod buildMethodNamed:@"foo" withTypes:mFooTypes implementation:imp_implementationWithBlock(^(id self) {
            NSLog(@"%s foooooooooo", __func__);
        })];
        MKSimpleMethod *mBar = [MKSimpleMethod buildMethodNamed:@"bar:" withTypes:mBarTypes implementation:imp_implementationWithBlock(^(id self, id anyobj) {
            NSLog(@"%s barrrrrrr: %@", __func__, [anyobj description]);
        })];

        // Create some property attributes, then...
        MKMutablePropertyAttributes *nameAttributes = [MKMutablePropertyAttributes attributes];
        nameAttributes.isReadOnly = YES;
        nameAttributes.backingIVar = iName.name;
        [nameAttributes setTypeEncodingChar:MKTypeEncodingObjcObject];
        NSDictionary *lengthAttributesDict = @{MKPropertyAttributeKeyNonAtomic:       @YES,
                                               MKPropertyAttributeKeyTypeEncoding:    [NSString stringWithFormat:@"%c", (char)MKTypeEncodingUnsignedLongLong],
                                               MKPropertyAttributeKeyBackingIVarName: iLength.name};
        MKPropertyAttributes *lengthAttributes = [MKPropertyAttributes attributesFromDictionary:lengthAttributesDict];
        
        // Initialize some properties with those attributes...
        MKProperty *pName = [MKProperty propertyWithName:@"name" attributes:nameAttributes];
        MKProperty *pLength = [MKProperty propertyWithName:@"length" attributes:lengthAttributes];
        
        // Add the methods, IVars, and properties
        [builder addMethods:@[minit, mFoo, mBar]];
        [builder addIVars:@[iName, iLength]];
        [builder addProperties:@[pName, pLength]];
        
        // Register the class and create an instance of it!
        Class myClass = [builder registerClass];
        id smallAtom = [myClass new];
        
        // Proof it all worked / how to work with a runtime-created class
        MKMirror *atomReflection = [MKMirror reflect:smallAtom];
        MKMethod *atomFoo = [atomReflection methodNamed:@"foo"];
        MKMethod *atomBar = [atomReflection methodNamed:@"bar:"];
        [atomFoo getReturnValue:NULL forMessageSend:smallAtom];
        NSArray *obj = @[@"First string", @"Second string"];
        [atomBar getReturnValue:NULL forMessageSend:smallAtom, MKArg(obj)];
        
        while (true) { [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]]; }
    }
    
    return 0;
}

#pragma clang diagnostic pop
