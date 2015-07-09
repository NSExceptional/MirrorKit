# MirrorKit

Inspired by Swift's MirrorType and [MAObjcRuntime](https://github.com/mikeash/MAObjCRuntime), this framework aims to simplify working with the Objective-C runtime. I'm writing this as I learn.

Coming soon: Cocoapods support, MIT license

Usage:

``` objc
#import "MirrorKit.h"
...

XZYObject *foo = [[XZYObject alloc] initWithBar:bar];
MKMirror *reflection = [MKMirror reflect:foo]; // works for classes too

// Get a list of foo's properties, retrieve information about a property
NSArray *properties = reflection.properties;
MKProperty *property = properties.firstObject;
NSString *propertyName = property.name;
BOOL readwrite = !property.isReadOnly;

// Discover all loaded subclasses of any class!
NSArray *subclasses = [NSDictionary allSubclasses];
NSLog(subclasses); // 20+ classes... wow
```
