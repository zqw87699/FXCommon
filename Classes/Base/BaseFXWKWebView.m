//
//  BaseFXWKWebView.m
//  Test
//
//  Created by 张大宗 on 2017/8/28.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXWKWebView.h"

@implementation BaseFXWKWebView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self fx_loadView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self fx_loadView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self fx_loadView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        [self fx_loadView];
    }
    return self;
}

+(instancetype) fx_instance {
    BaseFXWKWebView *instance = nil;
    @try {
        NSString *className = NSStringFromClass(self);
        NSString *nibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.nib",className]];
        NSString *iphoneNibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.nib",className]];
        NSString *ipadNibFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~ipad.nib",className]];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:iphoneNibFile] || [fm fileExistsAtPath:nibFile] || [fm fileExistsAtPath:ipadNibFile]) {
            id o = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
            if ([o isKindOfClass:self]) {
                instance = o;
            }
        }
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    @catch (NSException *exception) {
        instance = [[self alloc] init];
    }
    return instance;
}

- (void)fx_loadView{
    
}

@end
