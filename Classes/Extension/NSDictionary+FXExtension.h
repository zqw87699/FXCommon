//
//  NSDictionary+FXExtension.h
//  TTTT
//
//  Created by 张大宗 on 2017/3/27.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FXExtension)

/**
 *  遍历词典
 *
 *  @param block 遍历block
 */
- (void) fx_each:(void (^)(id key, id value))block;

/**
 *  遍历词典所有key
 *
 *  @param block 遍历block
 */
- (void) fx_eachKey:(void (^)(id key))block;

/**
 *  遍历词典所有值
 *
 *  @param block 遍历block
 */
- (void) fx_eachValue:(void (^)(id value))block;

/**
 *  转换词典
 */
- (NSArray *) fx_map:(id (^)(id key, id value))block;

/**
 *  是否存在key
 *
 *  @param key key
 *
 *  @return 是否存在
 */
- (BOOL) fx_hasKey:(id)key;

@end
