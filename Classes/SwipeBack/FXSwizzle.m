//
//  FXSwizzle.m
//  Test
//
//  Created by 张大宗 on 2017/10/17.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXSwizzle.h"
#import <objc/runtime.h>

void __swizzle(Class cls, SEL originalSelector) {
    NSString *originalName = NSStringFromSelector(originalSelector);
    NSString *alternativeName = [NSString stringWithFormat:@"swizzled_%@", originalName];
    
    SEL alternativeSelector = NSSelectorFromString(alternativeName);
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method alternativeMethod = class_getInstanceMethod(cls, alternativeSelector);
    
    class_addMethod(cls,
                    originalSelector,
                    class_getMethodImplementation(cls, originalSelector),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(cls,
                    alternativeSelector,
                    class_getMethodImplementation(cls, alternativeSelector),
                    method_getTypeEncoding(alternativeMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(cls, originalSelector),
                                   class_getInstanceMethod(cls, alternativeSelector));
}
