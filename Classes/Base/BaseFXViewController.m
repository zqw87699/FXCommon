//
//  BaseFXViewController.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXViewController.h"
#import "FXJsonUtiles.h"
#import "Masonry.h"
#import "FXRoutable.h"

NSString * const FXViewControllerTitleKey = @"FXViewControllerTitleKey";

@interface BaseFXViewController ()

@end

@implementation BaseFXViewController

+ (instancetype)fx_instance{
    BaseFXViewController *viewController = nil;
    @try {
        NSString *className = NSStringFromClass(self);
        NSString *nibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.nib",className]];
        NSString *iphoneNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~iphone.nib",className]];
        NSString *ipadNibFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@~ipad.nib",className]];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:iphoneNibFilePath] || [fm fileExistsAtPath:nibFilePath] || [fm fileExistsAtPath:ipadNibFilePath]) {
            viewController = [[self alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
        } else {
            viewController = [[self alloc] init];
        }
    }
    @catch (NSException *exception) {
        viewController = [[self alloc] init];
    }
    return viewController;
}

- (void)fx_vcInit{
    for (NSString *proName in [self fx_viewModels] ) {
        Class clazz = NSClassFromString([FXJsonUtiles getPropertyTypeNameByPropertyName:proName class:[self class]]);
        id value = [[clazz alloc] init];
        [self setValue:value forKey:proName];
    }    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self fx_vcInit];
    }
    return self;
}

- (NSArray*)fx_viewModels{
    return nil;
}

- (BOOL)customNavigationBar{
    return YES;
}

- (NSString*)fxPopIcon{
    return @"BaseFXBundle.bundle/Images/returnArrow.png";
}

-(UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

-(BOOL)shouldAutorotate {
    return NO;
}

#pragma mark NavigationBar style
-(void)setFxNavTitle:(NSString *)fxNavTitle {
    if (_fxNavTitle == fxNavTitle) {
        return;
    }
    _fxNavTitle = [fxNavTitle copy];
    [_fxNavigationItem setTitle:_fxNavTitle];
}

- (void)fx_customNavigationBar{
    if ([self customNavigationBar]) {
        __weak typeof(self) selfObject = self;
        if (!_fxNavigationBar) {
            UINavigationBar *bar = [[UINavigationBar alloc] init];
            UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:self.fxNavTitle];
            _fxNavigationItem = item;
            
            [bar setItems:[NSArray arrayWithObjects:item, nil]];
            
            if ([self.navigationController.viewControllers count] > 1) {
                UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
                negativeSpacer.width = -2.0f;
                UIImage *icon = [[UIImage imageNamed:[self fxPopIcon]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:icon style:UIBarButtonItemStylePlain target:self action:@selector(fx_popReturn)];
                [self.fxNavigationItem setLeftBarButtonItems:@[negativeSpacer,backItem]];
            }
            [self.view addSubview:bar];
            [bar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(selfObject.view.mas_left);
                make.right.equalTo(selfObject.view.mas_right);
                make.top.equalTo(selfObject.view.mas_top);
                make.height.equalTo(@(64));
            }];
            _fxNavigationBar = bar;
        }
        if (!_fxView) {
            UIView *v = [[UIView alloc] init];
            [self.view insertSubview:v atIndex:0];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                UIEdgeInsets edgeInsets = UIEdgeInsetsMake(([selfObject edgesForExtendedLayout] & UIRectEdgeTop) ? 0 : 64.0f, 0, 0, 0);
                make.edges.equalTo(selfObject.view).with.insets(edgeInsets);
            }];
            _fxView = v;
        }
    } else {
        _fxView = self.view;
    }
    [_fxView setBackgroundColor:[UIColor whiteColor]];
}

- (void)fx_popReturn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    //解决iOS7之后滚动视图留有间隙问题
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
#endif
    
    [self fx_customNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    for (NSString *proName in [self fx_viewModels] ) {
        BaseFXViewModel*viewModel = [self valueForKey:proName];
        [viewModel fx_modelWillAppear];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (NSString *proName in [self fx_viewModels] ) {
        BaseFXViewModel*viewModel = [self valueForKey:proName];
        [viewModel fx_modelDidAppear];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (NSString *proName in [self fx_viewModels] ) {
        BaseFXViewModel*viewModel = [self valueForKey:proName];
        [viewModel fx_modelWillDisappear];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (NSString *proName in [self fx_viewModels] ) {
        BaseFXViewModel*viewModel = [self valueForKey:proName];
        [viewModel fx_modelDidDisappear];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0f) {
        if (self.isViewLoaded && !self.view.window) {
            self.view = nil;
        }
    }
#endif
    for (NSString *proName in [self fx_viewModels] ) {
        BaseFXViewModel*viewModel = [self valueForKey:proName];
        [viewModel fx_modelDidReceiveMemoryWarning];
    }
}

#pragma mark IFXRoutableProtocol
- (id)initWithURL:(NSString *)URL routerParams:(NSDictionary *)params{
    self.routerParams = params;
    self = [super init];
    if (self) {
        [self fx_vcInit];
    }
    return self;
}

@end
