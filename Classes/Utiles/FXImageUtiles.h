//
//  FXImageUtiles.h
//  TTTT
//
//  Created by 张大宗 on 2017/5/4.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FXImageUtiles : NSObject

/*
 *  全图片马赛克
 */
+ (UIImage*)imageMosaic:(UIImage*)image Accuracy:(int)accuracy;

/*
 *  触点马赛克
 *  Point:触点
 *  Accuracy:马赛克精度
 *  Length:马赛克边长
 */
+ (UIImage*)imageMosaic:(UIImage*)image Point:(CGPoint)point Accuracy:(int)accuracy Length:(int)length;

@end
