//
//  main.m
//  MirrorKit-iOS-Demo
//
//  Created by Tanner on 7/18/15.
//  Copyright (c) 2015 Tanner Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MirrorKit.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        MKMirror *header = [MKMirror reflect:NSClassFromString(@"_UITableViewHeaderFooterContentView")];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
