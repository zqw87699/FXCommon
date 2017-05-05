//
//  FXImageUtiles.m
//  TTTT
//
//  Created by 张大宗 on 2017/5/4.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXImageUtiles.h"

@implementation FXImageUtiles

+ (UIImage*)imageMosaic:(UIImage *)image Accuracy:(int)accuracy{
    
    CGImageRef imageRef = image.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    
    //获取颜色空间
    CGColorSpaceRef colorSpaceRef = CGImageGetColorSpace(imageRef);
    //创建图片上下文
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, width*4, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    //绘制图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    
    unsigned char *bitmapDataSrc =  CGBitmapContextGetData(contextRef);
    
    NSUInteger currentIndex,preCurrentIndex;
    unsigned char *pixels[4] = {0};
    for (NSUInteger i=0; i<height-1; i++) {
        for (NSUInteger j=0; j<width-1; j++) {
            currentIndex = i*width+j;
            if (i % accuracy == 0) {
                if ( j % accuracy == 0) {
                    memcpy(pixels, bitmapDataSrc+4*currentIndex, 4);
                }else{
                    memcpy(bitmapDataSrc+4*currentIndex, pixels, 4);
                }
            }else{
                preCurrentIndex = (i-1)*width+j;
                memcpy(bitmapDataSrc+4*currentIndex, bitmapDataSrc+4*preCurrentIndex, 4);
            }
        }
    }
    
    NSUInteger size = width*height*4;
    
    CGDataProviderRef provideRef =  CGDataProviderCreateWithData(NULL, bitmapDataSrc, size, NULL);
    
    CGImageRef mosaicImageRef = CGImageCreate(width, height, 8, 32, width*4, colorSpaceRef, kCGBitmapByteOrderDefault, provideRef, NULL, NO, kCGRenderingIntentDefault);
    
    CGContextRef returnContextRef = CGBitmapContextCreate(nil, width, height, 8, width*4, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(returnContextRef, CGRectMake(0, 0, width, height), mosaicImageRef);
    
    CGImageRef returnImageRef = CGBitmapContextCreateImage(returnContextRef);
    
    UIImage *returnImg = [UIImage imageWithCGImage:returnImageRef];
    
    CGImageRelease(mosaicImageRef);
    CGImageRelease(returnImageRef);
    CGContextRelease(contextRef);
    CGContextRelease(returnContextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provideRef);
    
    return returnImg;
}

+ (UIImage*)imageMosaic:(UIImage *)image Point:(CGPoint)point Accuracy:(int)accuracy Length:(int)length{
    CGImageRef imageRef = image.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    if (point.x>width || point.y>height || point.x<1 || point.y<1) {
        return nil;
    }
    //获取颜色空间
    CGColorSpaceRef colorSpaceRef = CGImageGetColorSpace(imageRef);
    //创建图片上下文
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, width*4, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    //绘制图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    
    unsigned char *bitmapDataSrc =  CGBitmapContextGetData(contextRef);
    
    NSUInteger positionX0=point.x-length < 1 ? 1 : point.x-length;
    NSUInteger posiitonX1=point.x+length > width ? width : point.x+length;
    NSUInteger positionY0=point.y-length < 1 ? 1 : point.y-length;
    NSUInteger positionY1=point.y+length > height ? height : point.y+length;
    
    NSUInteger currentIndex,preCurrentIndex;
    unsigned char *pixels[4] = {0};
    
    for (NSUInteger i=0; i<positionY1-positionY0; i++) {
        for (NSUInteger j=0; j<posiitonX1-positionX0; j++) {
            currentIndex = (i+positionY0-1)*width+j+positionX0-1;
            if (i % accuracy == 0) {
                if ( j % accuracy == 0) {
                    memcpy(pixels, bitmapDataSrc+4*currentIndex, 4);
                }else{
                    memcpy(bitmapDataSrc+4*currentIndex, pixels, 4);
                }
            }else{
                preCurrentIndex = (i+positionY0-2)*width+j+positionX0-1;
                memcpy(bitmapDataSrc+4*currentIndex, bitmapDataSrc+4*preCurrentIndex, 4);
            }
        }
    }
    
    NSUInteger size = width*height*4;
    
    CGDataProviderRef provideRef =  CGDataProviderCreateWithData(NULL, bitmapDataSrc, size, NULL);
    
    CGImageRef mosaicImageRef = CGImageCreate(width, height, 8, 32, width*4, colorSpaceRef, kCGBitmapByteOrderDefault, provideRef, NULL, NO, kCGRenderingIntentDefault);
    
    CGContextRef returnContextRef = CGBitmapContextCreate(nil, width, height, 8, width*4, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(returnContextRef, CGRectMake(0, 0, width, height), mosaicImageRef);
    
    CGImageRef returnImageRef = CGBitmapContextCreateImage(returnContextRef);
    
    UIImage *returnImg = [UIImage imageWithCGImage:returnImageRef];
    
    CGImageRelease(mosaicImageRef);
    CGImageRelease(returnImageRef);
    CGContextRelease(contextRef);
    CGContextRelease(returnContextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provideRef);
    
    return returnImg;
}

@end
