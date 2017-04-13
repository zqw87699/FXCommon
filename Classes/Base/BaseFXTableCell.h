//
//  BaseFXTableCell.h
//  TTTT
//
//  Created by 张大宗 on 2017/4/13.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFXTableCell : UITableViewCell

/**
 *  得到重用标示
 *
 *  @return 标示符
 */
+(NSString*) fx_tableCellIdentifier;

/**
 *  创建一个实例
 *
 *  @return 实例对象
 */
+(instancetype) fx_instance;

/**
 *  加载页面
 */
-(void)fx_loadView;

@end
