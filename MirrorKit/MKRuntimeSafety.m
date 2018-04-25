//
//  MKRuntimeSafety.m
//  Pods
//
//  Created by Tanner on 3/25/17.
//
//

#import "MKRuntimeSafety.h"

NSUInteger const kMKKnownUnsafeClassCount = 18;
static Class * _UnsafeClasses    = NULL;

Class * MKKnownUnsafeClasses() {
    if (!_UnsafeClasses) {
        Class ignored[] = {
            NSClassFromString(@"__ARCLite__"),
            NSClassFromString(@"__NSCFCalendar"),
            NSClassFromString(@"__NSCFTimer"),
            NSClassFromString(@"NSCFTimer"),
            NSClassFromString(@"__NSGenericDeallocHandler"),
            NSClassFromString(@"NSAutoreleasePool"),
            NSClassFromString(@"NSPlaceholderNumber"),
            NSClassFromString(@"NSPlaceholderString"),
            NSClassFromString(@"NSPlaceholderValue"),
            NSClassFromString(@"Object"),
            NSClassFromString(@"VMUArchitecture"),
            NSClassFromString(@"Object"),
            NSClassFromString(@"JSExport"),
            NSClassFromString(@"__NSAtom"),
            NSClassFromString(@"_NSZombie_"),
            NSClassFromString(@"_CNZombie_"),
            NSClassFromString(@"__NSMessage"),
            NSClassFromString(@"__NSMessageBuilder"),
            NSClassFromString(@"FigIrisAutoTrimmerMotionSampleExport")
        };

        _UnsafeClasses = (Class *)malloc(sizeof(ignored));
        memcpy(_UnsafeClasses, ignored, sizeof(ignored));
    }

    return _UnsafeClasses;
}

NSSet * MKKnownUnsafeClassNames() {
    static NSSet *set = nil;
    if (!set) {
        NSArray *ignored = @[
            @"__ARCLite__",
            @"__NSCFCalendar",
            @"__NSCFTimer",
            @"NSCFTimer",
            @"__NSGenericDeallocHandler",
            @"NSAutoreleasePool",
            @"NSPlaceholderNumber",
            @"NSPlaceholderString",
            @"NSPlaceholderValue",
            @"Object",
            @"VMUArchitecture",
            @"Object",
            @"JSExport",
            @"__NSAtom",
            @"_NSZombie_",
            @"_CNZombie_",
            @"__NSMessage",
            @"__NSMessageBuilder",
            @"FigIrisAutoTrimmerMotionSampleExport"
        ];

        set = [NSSet setWithArray:ignored];
    }

    return set;
}
