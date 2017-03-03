//
//  BaseFXWKWebViewController.h
//  TTTT
//
//  Created by 张大宗 on 2017/3/2.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseFXViewController.h"
#import "IFXWebViewJSBridgeDelegate.h"
#import "IFXWebRoutableProtocol.h"
#import <WebKit/WebKit.h>

@interface BaseFXWKWebViewController : BaseFXViewController<IFXWebRoutableProtocol>

/**
 *  当前请求url地址
 */
@property(nonatomic, copy) NSString *requestURLString;

/*
 *  当前WebView
 */
@property(nonatomic, weak) WKWebView *webView;

/**
 *  JS桥接接口对象
 */
@property(nonatomic, strong) id<IFXWebViewJSBridgeDelegate> webJavascrpitBridge;

/**
 *  重新加载URL
 */
-(void)reloadURL:(NSString*)url;

/**
 *  配置WebView JS Bridge
 */
- (void)configWebViewJSBridge;

/**
 *  获取H5数据
 */
-(void)fetchH5Data;

@end
