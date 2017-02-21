//
//  FXStringUtiles.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/16.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FX_STRING_EQUAL(str1, str2)            [FXStringUtiles equal:str1 str:str2]
#define FX_STRING_IS_BLANK(str)                [FXStringUtiles isBlank:str]
#define FX_STRING_IS_NOT_BLANK(str)            [FXStringUtiles isNotBlank:str]
#define FX_STRING_IS_EMPTY(str)                [FXStringUtiles isEmpty:str]
#define FX_STRING_IS_NOT_EMPTY(str)            [FXStringUtiles isNotEmpty:str]
#define FX_STRING_SPLIT(str,separator)         [FXStringUtiles split:str separator:separator]
#define FX_STRING_JOIN(strList,separator)      [FXStringUtiles join:strList separator:separator]


/**
 *  字符串 工具类
 */
@interface FXStringUtiles : NSObject

/**
 *  字符串是否为空串
 *
 *  @param str 判断字符串
 *
 *  @return 判断结果（YES:nil、“”）
 */
+(BOOL) isBlank:(NSString*) str;

/**
 *  字符串是否为空
 *
 *  @param str 判断字符串
 *
 *  @return 判断结果（YES:[NSNull null]、null、(null)、nil、“”）
 */
+(BOOL) isEmpty:(NSString*) str;

/**
 *  字符串是否不为空串
 *
 *  @param str 判断字符串
 *
 *  @return 判断结果（YES:nil、“”）
 */
+(BOOL) isNotBlank:(NSString*) str;

/**
 *  字符串是否不为空
 *
 *  @param str 判断字符串
 *
 *  @return 判断结果（YES:[NSNull null]、null、(null)、nil、“”）
 */
+(BOOL) isNotEmpty:(NSString*) str;

/**
 *  比较字符串
 *
 *  @param str1 字符串1
 *  @param str2 字符串2
 *
 *  @return 结果
 */
+(BOOL) equal:(NSString*) str1 str:(NSString*) str2;

/**
 *  分拆字符串
 *
 *  @param str       被分拆字符串
 *  @param separator 分拆符
 *
 *  @return 分拆结果
 */
+(NSArray*) split:(NSString*) str separator:(NSString*) separator;

/**
 *  连接字符串数组
 *
 *  @param strs       字符串列表
 *  @param separator 连接符
 *
 *  @return 连接字符串结果
 */
+(NSString*) join:(NSArray*) strs separator:(NSString*) separator;

@end
