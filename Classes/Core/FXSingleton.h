//
//  FXSingleton.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/15.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXSingleton : NSObject

+ (instancetype)sharedInstance;

- (void)singleInit;

@end
