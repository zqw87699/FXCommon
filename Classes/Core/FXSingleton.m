//
//  FXSingleton.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/15.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXSingleton.h"

@implementation FXSingleton

+ (instancetype)sharedInstance{
    static dispatch_once_t once; \
    static id __singleton__; \
    dispatch_once( &once, ^{ \
        __singleton__ = [[self alloc] init]; \
        if ([__singleton__ respondsToSelector:@selector(singleInit)]) { \
            [__singleton__ singleInit]; \
        } \
    }); \
    return __singleton__; \
}

- (void)singleInit{
    
}

@end
