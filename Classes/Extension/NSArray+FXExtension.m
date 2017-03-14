//
//  NSArray+FXExtension.m
//  TTTT
//
//  Created by 张大宗 on 2017/3/3.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "NSArray+FXExtension.h"

@implementation NSArray (FXExtension)

- (id)random{
    if (self.count == 0) return nil;
    
    NSUInteger index = arc4random_uniform((u_int32_t)self.count);
    return self[index];
}

@end
