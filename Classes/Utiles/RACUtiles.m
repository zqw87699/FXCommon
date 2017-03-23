//
//  RACUtiles.m
//  TTTT
//
//  Created by 张大宗 on 2017/3/20.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "RACUtiles.h"

static NSInteger RACUtilTag = 0;

static NSMutableDictionary *RACUtilDict= nil;

@implementation RACUtiles

+ (void)initialize{
    if (!RACUtilDict) {
        RACUtilDict = [[NSMutableDictionary alloc] init];
    }
}

+ (NSInteger)timerWithInterval:(NSTimeInterval)interval Number:(int)number Block:(void (^)(BOOL, long long, NSInteger))block{
    
    [self initialize];
    
    RACUtilTag+=1;
    NSInteger nowTag = RACUtilTag;
    
    __block long long countDown = 0;
    
    RACSignal *signal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        return [[RACScheduler mainThreadScheduler] after:[NSDate dateWithTimeIntervalSinceNow:interval] repeatingEvery:interval withLeeway:0.0f schedule:^{
            BOOL stop = [RACUtilDict objectForKey:@(nowTag)]?[RACUtilDict objectForKey:@(nowTag)]:NO;
            if (countDown>number || stop ) {
                [subscriber sendCompleted];
            }else{
                [subscriber sendNext:@(countDown)];
            }
        }];
    }];
    
    [signal subscribeNext:^(NSNumber *x) {
        countDown = countDown + 1;
        block(NO,[x longLongValue],nowTag);
    }];
    
    [signal subscribeCompleted:^{
        block(YES,0,nowTag);
    }];
    
    return RACUtilTag;
}

+ (NSInteger)timerWithInterval:(NSTimeInterval)interval Block:(void (^)(NSInteger))block{
    [self initialize];
    
    RACUtilTag+=1;
    NSInteger nowTag = RACUtilTag;
    
    RACSignal *signal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        return [[RACScheduler mainThreadScheduler] after:[NSDate dateWithTimeIntervalSinceNow:interval] repeatingEvery:interval withLeeway:0.0f schedule:^{
            BOOL stop = [RACUtilDict objectForKey:@(nowTag)]?[RACUtilDict objectForKey:@(nowTag)]:NO;
            if (stop) {
                [subscriber sendCompleted];
            }else{
                [subscriber sendNext:@(0)];
            }
        }];
    }];
    
    [signal subscribeNext:^(NSNumber *x) {
        block(nowTag);
    }];
    
    [signal subscribeCompleted:^{
    }];
    
    return RACUtilTag;
}

+ (void)forceEnd:(NSInteger)tag{
    [RACUtilDict setObject:@(YES) forKey:@(tag)];
}


@end
