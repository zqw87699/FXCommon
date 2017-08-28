//
//  BaseFXWKWebView.h
//  Test
//
//  Created by 张大宗 on 2017/8/28.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseFXWKWebView : WKWebView

+(instancetype) fx_instance;

-(void)fx_loadView;

@end
