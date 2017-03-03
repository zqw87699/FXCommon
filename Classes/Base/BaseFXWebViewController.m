//
//  BaseFXWebViewController.m
//  TTTT
//
//  Created by 张大宗 on 2017/3/1.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXWebViewController.h"
#import "Masonry.h"
#import "FXWebViewJavaScriptBridge.h"
#import "FXJsonUtiles.h"
#import "FXRoutable.h"

@interface BaseFXWebViewController ()<UIWebViewDelegate>

/**
 *  H5模块名称
 */
@property(nonatomic, copy) NSString *h5ModuleName;

/*
 *  是否首次加载
 */
@property(nonatomic, assign) BOOL isFirstLoad;

@end

@implementation BaseFXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *t = self.routerParams[FXViewControllerTitleKey];
    if (t) {
        self.fxNavTitle = t;
    }
    
    [self initWebViewBridge];
}

- (void)initWebViewBridge{
    FX_WEAK_REF_TYPE selfObject = self;
    if (!_webView) {
        UIWebView* wv = [[UIWebView alloc] init];
        [wv setPaginationBreakingMode:UIWebPaginationBreakingModeColumn];
        [wv setScalesPageToFit:YES];
        [[wv scrollView] setShowsHorizontalScrollIndicator:NO];
        [self.fxView addSubview:wv];
        _webView = wv;
        
        [wv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(selfObject.fxView);
        }];
        
        FXWebViewJavaScriptBridge *bridge = [FXWebViewJavaScriptBridge bridgeForWebView:wv];
        [bridge setJSBDelegate:self];
        self.webJavascrpitBridge = bridge;
        
        [self configWebViewJSBridge];
        
        [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_requestURLString]]];
    }
}

-(void)reloadURL:(NSString *)url {
    if (FX_STRING_IS_NOT_EMPTY(url)) {
        self.requestURLString = url;
        self.isFirstLoad = YES;
        self.h5ModuleName = nil;
        self.fxNavTitle = nil;
        if (self.fxView) {
            if (_webView) {
                if ([_webView isLoading]) [_webView stopLoading];
                [_webView removeFromSuperview];
                self.webView = nil;
                self.webJavascrpitBridge = nil;
            }
            [self initWebViewBridge];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.webJavascrpitBridge) [self.webJavascrpitBridge callHandler:@"h5ViewAppear" data:nil responseCallback:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.webJavascrpitBridge) [self.webJavascrpitBridge callHandler:@"h5ViewDisappear" data:nil responseCallback:nil];
}

#pragma mark Override 重写返回事件
-(void) fx_popReturn {
    if ([_webView canGoBack] && !_h5ModuleName) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)fx_vcInit{
    self.isFirstLoad = YES;
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    FXLogDebug(@"requestUrl:%@",urlString);
    if (navigationType == UIWebViewNavigationTypeReload) {
        self.h5ModuleName = nil;
        [self performSelectorOnMainThread:@selector(fetchH5Data) withObject:nil waitUntilDone:NO];
        return YES;
    }else if (_isFirstLoad) {
        self.isFirstLoad = NO;
        self.h5ModuleName = nil;
        [self performSelectorOnMainThread:@selector(fetchH5Data) withObject:nil waitUntilDone:NO];
        return YES;
    }
    if (_h5ModuleName) {
        //添加判断如果，如果是WJWebViewJavascrpitBridge页面则重新打开，否则直接跳转
        [[FXRoutable sharedInstance] open:urlString animated:YES];
        return NO;
    } else {
        self.h5ModuleName = nil;
        return YES;
    }
}

-(void)fetchH5Data {
    FX_WEAK_REF_TYPE selfObject = self;
    //h5模块名称
    [self.webJavascrpitBridge callHandler:@"h5ModuleName" data:nil responseCallback:^(id responseData) {
        if (responseData && [responseData isKindOfClass:[NSString class]]) {
            selfObject.h5ModuleName = responseData;
        }
    }];
    //获取H5标题
    [self.webJavascrpitBridge callHandler:@"h5DocumentTitle" data:nil responseCallback:^(id responseData) {
        if (responseData && [responseData isKindOfClass:[NSString class]]) {
            selfObject.fxNavTitle = responseData;
        }
    }];
}

- (void)configWebViewJSBridge{
    [self fetchH5Data];
    
    FX_WEAK_REF_TYPE selfObject = self;
    
    //用户是否是在App内
    [self.webJavascrpitBridge registerHandler:@"nativeIsApp" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        responseCallback(@(YES));
    }];
    //修改当前标题
    [self.webJavascrpitBridge registerHandler:@"nativeChangeTitle" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        if (data && [data isKindOfClass:[NSString class]]) {
            selfObject.fxNavTitle = data;
        }
    }];
    [self.webJavascrpitBridge registerHandler:@"nativeEnabledBounces" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        [[selfObject.webView scrollView] setBounces:YES];
    }];
    
    [self.webJavascrpitBridge registerHandler:@"nativeDisabledBounces" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        [[selfObject.webView scrollView] setBounces:NO];
    }];
    [self.webJavascrpitBridge registerHandler:@"nativeGoback" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        BOOL animated = YES;
        if (data && [data isKindOfClass:[NSNumber class]]) {
            animated = [data boolValue];
        }
        [[FXRoutable sharedInstance] close:animated];
    }];
    [self.webJavascrpitBridge registerHandler:@"nativeOpenURL" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        //测试数据
        if (data && [data isKindOfClass:[NSString class]] && selfObject.isViewLoaded && selfObject.view.window) {
            NSDictionary *dict = nil;
            NSString *openURL = nil;
            NSString *title = nil;
            @try {
                dict = [FXJsonUtiles fromJsonString:data];
            } @catch (NSException *exception) {
                dict = nil;
            } @finally {
                openURL = dict[@"openURL"];
                title = dict[@"title"];
            }
            if (!openURL) openURL = data;
            if (openURL) {
                NSDictionary *extraParams = nil;
                if (title) extraParams = @{FXViewControllerTitleKey:title};
                [[FXRoutable sharedInstance] open:openURL animated:YES extraParams:extraParams];
            }
        }
    }];
    //打开外部链接
    [self.webJavascrpitBridge registerHandler:@"nativeOpenExternalURL" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        if (data && [data isKindOfClass:[NSString class]]) {
            [[FXRoutable sharedInstance] openExternal:data];
        }
    }];
    [self.webJavascrpitBridge registerHandler:@"nativeReloadURL" handler:^(id data, FXWVJSBResponseCallback responseCallback) {
        //测试数据
        if (data && [data isKindOfClass:[NSString class]] && selfObject.isViewLoaded && selfObject.view.window) {
            NSDictionary *dict = nil;
            NSString *openURL = nil;
            NSString *title = nil;
            @try {
                dict = [FXJsonUtiles fromJsonString:data];
            } @catch (NSException *exception) {
                dict = nil;
            } @finally {
                openURL = dict[@"openURL"];
                title = dict[@"title"];
            }
            if (!openURL) openURL = selfObject.requestURLString;
            if (openURL) {
                if (title) selfObject.fxNavTitle = title;
                [selfObject reloadURL:openURL];
            }
        }
    }];
}

#pragma mark IFXWebRoutableProtocol
+ (BOOL)canOpenURL:(NSString *)URL{
    return YES;
}

#pragma mark IFXRoutableProtocol
-(id)initWithURL:(NSString *)URL routerParams:(NSDictionary *)params {
    self = [super initWithURL:URL routerParams:params];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
        self.requestURLString = [URL stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return self;
}

- (void)dealloc {
    FXLogDebug(@"dealloc %@",[self class]);
    self.webJavascrpitBridge = nil;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (!self.view) {
        self.webJavascrpitBridge = nil;
        self.isFirstLoad = YES;
    }
}

@end
