//
//  MKRuntimeSafety.h
//  Pods
//
//  Created by Tanner on 3/25/17.
//
//

#import <Foundation/Foundation.h>


extern NSUInteger const kMKKnownUnsafeClassCount;
extern Class * MKKnownUnsafeClasses();
extern NSSet * MKKnownUnsafeClassNames();

static inline BOOL MKClassIsSafe(Class cls) {
    if (!cls) return NO;

    Class * ignored = MKKnownUnsafeClasses();
    for (NSInteger x = 0; x < kMKKnownUnsafeClassCount; x++) {
        if (cls == ignored[x]) {
            return NO;
        }
    }

    return YES;
}

static inline BOOL MKClassNameIsSafe(NSString *cls) {
    if (!cls) return NO;
    
    NSSet *ignored = MKKnownUnsafeClassNames();
    return ![ignored containsObject:cls];
}
