//
//  BaseFXTableCell.m
//  TTTT
//
//  Created by 张大宗 on 2017/4/13.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXTableCell.h"

@implementation BaseFXTableCell

+(instancetype) fx_instance {
    BaseFXTableCell *instance = nil;
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
            instance = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self fx_tableCellIdentifier]];
        }
    }
    @catch (NSException *exception) {
        instance = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self fx_tableCellIdentifier]];
    }
    return instance;
}

+(NSString*) fx_tableCellIdentifier {
    return [[NSString alloc] initWithFormat:@"%@Identifier",NSStringFromClass(self)];
}

@end
