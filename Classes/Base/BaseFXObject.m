//
//  BaseFXObject.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/17.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXObject.h"

@implementation BaseFXObject

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
    id copyObject = [[[self class] allocWithZone:zone] init];
    NSArray *allPropertys = [FXJsonUtiles getPropertys:[self class]];
    for (FXJsonObject *desc in allPropertys) {
        @try {
            id value = [self valueForKey:desc.name];
            if (value != nil && (NSNull*)value != [NSNull null]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    [copyObject setValue:value forKey:desc.name];
                } else if ([value isKindOfClass:[NSMutableArray class]] || [value isKindOfClass:[NSMutableSet class]] || [value isKindOfClass:[NSMutableDictionary class]]) {
                    [copyObject setValue:[value mutableCopyWithZone:zone] forKey:desc.name];
                }else {
                    [copyObject setValue:[value copyWithZone:zone] forKey:desc.name];
                }
            }
        }
        @catch (NSException *exception) {
            FXLogError(@"copyWithZone:exception:%@",exception);
        }
    }
    return copyObject;
}
#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *allPropertys = [FXJsonUtiles getPropertys:[self class]];
    for (FXJsonObject *desc in allPropertys) {
        @try {
            [aCoder encodeObject:[self valueForKey:desc.name] forKey:desc.name];
        }
        @catch (NSException *exception) {
            FXLogError(@"encodeWithCoder:exception:%@",exception);
        }
    }
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSArray *allPropertys = [FXJsonUtiles getPropertys:[self class]];
        for (FXJsonObject *desc in allPropertys) {
            id value = [aDecoder decodeObjectForKey:desc.name];
            if (value != nil && (NSNull*)value != [NSNull null]) {
                @try {
                    [self setValue:value forKey:desc.name];
                }
                @catch (NSException *exception) {
                    FXLogError(@"initWithCoder:exception:%@",exception);
                }
                
            }
        }
    }
    return self;
}

#pragma override NSObject
-(NSString *)description {
    NSMutableString *string = [[NSMutableString alloc] init];
    NSArray *allPropertys = [FXJsonUtiles getPropertys:[self class]];
    [string appendString:@"("];
    for (FXJsonObject*object in allPropertys) {
        @try {
            [string appendFormat:@"%@:%@,",object.name,[self valueForKey:object.name]];
        }
        @catch (NSException *exception) {
            [string appendFormat:@"%@:%@,",object.name,@"null"];
        }
    }
    [string appendString:@")"];
    return [NSString stringWithFormat:@"%@:%@",NSStringFromClass([self class]),string];
}

@end
