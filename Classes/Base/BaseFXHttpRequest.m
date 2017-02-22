//
//  BaseFXHttpRequest.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/17.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXHttpRequest.h"

@implementation BaseFXHttpRequest

-(NSString*) getURL {
    return nil;
}

-(BOOL) validateParams {
    return YES;
}

-(NSDictionary*) getHeaders {
    return nil;
}

-(NSDictionary*) getParams {
    return nil;
}

-(NSString*) getMethod {
    return HTTP_METHOD_POST;
}

-(long) getTimeoutDuration {
    return 0;
}

-(NSDictionary*) getUploadFiles {
    return nil;
}

@end
