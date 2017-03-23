//
//  RACUtiles.h
//  TTTT
//
//  Created by 张大宗 on 2017/3/20.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

@interface RACUtiles : NSObject

/*
 *  每隔interval执行一次，总执行number次
 */
+ (NSInteger)timerWithInterval:(NSTimeInterval)interval Number:(int)number Block:(void (^)(BOOL finish,long long nowNum,NSInteger tag))block;

/*
 *  每隔interval执行一次
 */
+ (NSInteger)timerWithInterval:(NSTimeInterval)interval Block:(void (^)(NSInteger tag))block;

/*
 *  强制终止,tag为timerWithInterval返回tag
 */
+ (void)forceEnd:(NSInteger)tag;

@end
