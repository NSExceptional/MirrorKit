//
//  MirrorKitTests.m
//  MirrorKitTests
//
//  Created by Tanner Bennett on 07/26/2015.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

@import XCTest;
@import MirrorKit;
#import "TestRoot.h"
#import "TestChild.h"
#import "TestChild2.h"


@interface Tests : XCTestCase

@end

@implementation Tests

- (void)testLazyMethod {
    NSLog(@"%@", [MKLazyMethod instanceMethod:@selector(pattern) class:[NSRegularExpression class]]);
}

- (void)testMKMirror_allClasses {
    [(id)[MKMirror allClasses] removeAllObjects];
}

- (void)testNSObjectCategories {
    XCTAssertEqual([TestRoot instanceSize], 64);
    
    ////////////////////////
    // General reflection //
    ////////////////////////
    
    NSArray *subclasses = [TestRoot allSubclasses];
    TestRoot *root = [TestRoot new];
    [root setClass:[NSString class]];
    [TestChild setSuperclass:[NSArray class]];
    XCTAssertEqual(subclasses.count, 1);
    XCTAssertEqualObjects([TestChild class], subclasses.firstObject);
    XCTAssertEqualObjects([root class], [NSString class]);
    XCTAssertEqualObjects([TestChild superclass], [NSArray class]);
    // reset
    [TestChild setSuperclass:[TestRoot class]];
    root = [TestRoot new];
    
    
    /////////////
    // Methods //
    /////////////
    
    // Find a method
    NSSet *originalMethods    = [NSSet setWithArray:[TestRoot allMethods]];
    NSPredicate *filterFoobar = [NSPredicate predicateWithFormat:@"%K = %@", @"selectorString", @"foobar"];
    NSPredicate *filterFoo    = [NSPredicate predicateWithFormat:@"%K = %@", @"selectorString", @"foo"];
    XCTAssertEqual([originalMethods.allObjects filteredArrayUsingPredicate:filterFoobar].count, 0);
    XCTAssertEqual([originalMethods.allObjects filteredArrayUsingPredicate:filterFoo].count, 1);
    
    // Add a method
    BOOL didAdd = [TestRoot addMethod:NSSelectorFromString(@"foobar")
                         typeEncoding:MKTypeEncodingString(@encode(void), 0)
                       implementation:imp_implementationWithBlock(^(id self) { NSLog(@"Called foobar"); })
                          toInstances:YES];
    NSSet *addedMethods = [NSSet setWithArray:[TestRoot allMethods]];
    XCTAssertEqual([addedMethods.allObjects filteredArrayUsingPredicate:filterFoobar].count, 1);
    XCTAssertTrue(didAdd);
    
    // Swizzle two methods
    NSInteger numOrig = root.num, intOrig = [root integer];
    [TestRoot swizzleByName:@"integer" with:@"num" onInstance:YES];
    XCTAssertEqual(root.num, intOrig);
    XCTAssertEqual([root integer], numOrig);
    // reset
    [TestRoot swizzleByName:@"integer" with:@"num" onInstance:YES];
    
    ////////////////////////
    // Instance variables //
    ////////////////////////
    
    // List ivars
    NSArray *ivars = [TestRoot allIVars];
    NSPredicate *findRectIVar = [NSPredicate predicateWithFormat:@"%K = %@", @"name", @"_rect"];
    NSPredicate *findIDIVar   = [NSPredicate predicateWithFormat:@"%K = %@", @"name", @"_identifier"];
    MKIVar *rect              = [ivars filteredArrayUsingPredicate:findRectIVar].firstObject;
    MKIVar *identifier        = [ivars filteredArrayUsingPredicate:findIDIVar].firstObject;
    XCTAssertNotNil(identifier); XCTAssertNotNil(rect);
    XCTAssertEqual(ivars.count, 4); // identifier, num, rect, timestamp
    
    // Get ivar addresses
    XCTAssertEqual([root getIVarAddress:identifier], [root getIVarAddressByName:@"_identifier"]);
    XCTAssertEqual([root getIVarAddress:identifier], [root getObjcIVarAddress:identifier.objc_ivar]);
    
    // Set ivars
    NSUInteger num = 5;
    CGRect newRect = CGRectMake(7, 5, 5, 7);
    [root setIvar:identifier object:@"deadbeef"];
    [root setIVarByName:@"_num" value:&num size:sizeof(NSUInteger)];
    [root setObjcIVar:rect.objc_ivar value:&newRect size:sizeof(CGRect)];
    XCTAssertEqual(root.num, num);
    XCTAssertEqualObjects(root.identifier, @"deadbeef");
    XCTAssertTrue(root.rect.origin.x == 7 && root.rect.origin.y == 5
                  && root.rect.size.width == 5 && root.rect.size.height == 7);
    
    
    ////////////////
    // Properties //
    ////////////////
    
    // List properties
    NSArray *properties          = [TestRoot allProperties];
    NSPredicate *findNumProperty = [NSPredicate predicateWithFormat:@"%K = %@", @"name", @"num"];
    MKProperty *numProperty      = [properties filteredArrayUsingPredicate:findNumProperty].firstObject;
    XCTAssertEqual(properties.count, 4);
    XCTAssertNotNil(numProperty);
    
    // Replace properties
    BOOL readOnly = numProperty.attributes.isReadOnly;
    MKMutablePropertyAttributes *newAttributes = numProperty.attributes.mutableCopy;
    newAttributes.isReadOnly = !readOnly;
    MKProperty *numPropertyReplacement = [MKProperty propertyWithName:@"num" attributes:newAttributes];
    [TestRoot replaceProperty:numPropertyReplacement];
    MKProperty *replacedNumProperty = [[TestRoot allProperties] filteredArrayUsingPredicate:findNumProperty].firstObject;
    XCTAssertNotNil(replacedNumProperty);
    XCTAssertNotEqual(numProperty.attributes.isReadOnly, replacedNumProperty.attributes.isReadOnly);
}

- (void)testAddAndRemoveMethod {
    MKMethod *method = [TestChild methodNamed:@"identifier"];
    IMP superIMP = method.implementation;
    IMP imp = imp_implementationWithBlock(^(id me){
        NSString *orig = ((NSString *(*)(id, SEL))superIMP)(me, @selector(identifier));
        return [orig stringByAppendingString:@"_override"];
    });
    [TestChild2 replaceImplementationOfMethod:method with:imp useInstance:YES];

    XCTAssertEqualObjects([TestChild2 new].identifier, @"123abc_child_override");
    [TestChild2 replaceImplementationOfMethod:method with:superIMP useInstance:YES];
    XCTAssertEqualObjects([TestChild2 new].identifier, @"123abc_child");
}

@end

