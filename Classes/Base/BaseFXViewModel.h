//
//  BaseFXViewModel.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseFXViewModel : NSObject

- (void)fx_modelWillAppear;

- (void)fx_modelDidAppear;

- (void)fx_modelWillDisappear;

- (void)fx_modelDidDisappear;

-(void) fx_modelDidReceiveMemoryWarning;

@end
