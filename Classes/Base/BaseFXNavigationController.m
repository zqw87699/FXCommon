//
//  BaseFXNavigationController.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/23.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXNavigationController.h"

@interface BaseFXNavigationController ()

@end

@implementation BaseFXNavigationController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  默认隐藏导航栏
     */
    [self setNavigationBarHidden:YES];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0f) {
        if (self.isViewLoaded && !self.view.window) {
            self.view = nil;
        }
    }
#endif
}

-(BOOL)shouldAutorotate {
    return NO;
}

@end
