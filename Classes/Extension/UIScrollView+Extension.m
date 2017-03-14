//
//  UIScrollView+Extension.m
//  TTTT
//
//  Created by 张大宗 on 2017/3/3.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

- (float)fx_contentInsetTop{
    return self.contentInset.top;
}

- (void)setFx_contentInsetTop:(float)fx_contentInsetTop{
    if (self.contentInset.top == fx_contentInsetTop) return;
    self.contentInset = UIEdgeInsetsMake(fx_contentInsetTop, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
}

- (float)fx_contentInsetBottom{
    return self.contentInset.bottom;
}

-(void)setFx_contentInsetBottom:(float)fx_contentInsetBottom {
    if (self.contentInset.bottom == fx_contentInsetBottom) return;
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, fx_contentInsetBottom, self.contentInset.right);
}

@end
