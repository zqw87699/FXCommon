//
//  BaseFXHttpResponse.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/17.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXHttpResponse.h"

@implementation BaseFXHttpResponse

+(id<IFXHttpResponse>)parseResult:(NSData*)responseData {
    BaseFXHttpResponse *res = nil;
#ifdef DEBUG
    NSString *resString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    FXLogDebug(@"%@",resString);
#endif
    @try {
        res = [FXJsonUtiles fromJsonData:responseData class:[self class]];
    } @catch (NSException *exception) {
        res = [[BaseFXHttpResponse alloc] init];
    }
    return res;
}

/**
 *  是否存在逻辑错误
 */
-(BOOL) isError {
    return NO;
}

/**
 *  服务端返回的逻辑错误码
 */
-(NSString*) errorCode {
    return nil;
}

/**
 *  服务端返回的逻辑错误说明
 */
-(NSString*) errorMsg {
    return nil;
}

@end
