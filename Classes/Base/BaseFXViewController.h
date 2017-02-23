//
//  BaseFXViewController.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFXViewModel.h"
#import "IFXRoutableProtocol.h"
#import "FXLogMacros.h"

/**
 *  视图控制器标题名称
 */
extern NSString * const FXViewControllerTitleKey;

@interface BaseFXViewController : UIViewController<IFXRoutableProtocol>

#pragma mark custom
/**
 *  路由参数
 */
@property (nonatomic, strong) NSDictionary *routerParams;

/**
 *  替代self.navigationItem 设置navTitle请修改fxNavTitle属性
 */
@property (nonatomic, weak, readonly) UINavigationItem *fxNavigationItem;

/**
 *  替代 self.navigationController.navigationBar
 */
@property (nonatomic, weak) IBOutlet UINavigationBar *fxNavigationBar;

/**
 *  替代 self.view
 */
@property (nonatomic, weak) IBOutlet UIView *fxView;

/**
 *  导航栏标题
 */
@property (nonatomic, copy) NSString *fxNavTitle;

/**
 *  是否自定义导航栏
 */
-(BOOL) customNavigationBar;

/**
 *  返回图片名称
 */
-(NSString*)fxPopIcon;

/**
 *  视图控制器初始方法(init初始化完成调用),子类重写后需要[super fx_vcInit]
 */
-(void) fx_vcInit;

/**
 *  当前视图控制器ViewModel
 */
-(NSArray*) fx_viewModels;

/**
 *  实例化一个视图控制器方法
 */
+(instancetype) fx_instance;

@end
