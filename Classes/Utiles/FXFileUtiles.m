//
//  FXFileUtiles.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/16.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXFileUtiles.h"

@implementation FXFileUtiles

+ (NSString *) documentDir {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([dirs count] > 0) {
        return [dirs[0] copy];
    }
    return nil;
}

+ (NSString *) tmpDir {
    return NSTemporaryDirectory();
}

+ (NSString *) appDir {
    return [[[NSBundle mainBundle] resourcePath] copy];
}

+(NSString *)cacheDir {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([dirs count] > 0) {
        return [dirs[0] copy];
    }
    return nil;
}


+ (NSData*) readFileByPath:(NSString*) filePath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSData dataWithContentsOfFile:filePath];
    }
    return nil;
}

+ (BOOL) writeFile:(NSData*) fileData forPath:(NSString *) filePath replace:(BOOL) replace {
    BOOL result = NO;
    if (fileData && filePath) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            if (replace) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
                result = [fileData writeToFile:filePath atomically:YES];
            }
        } else {
            result = [fileData writeToFile:filePath atomically:YES];
        }
    }
    return result;
}

+ (BOOL) writeJPEGImage:(UIImage *) image quality:(CGFloat) compressionQuality forPath:(NSString *) filePath {
    BOOL result = NO;
    if (image && [[[filePath pathExtension] lowercaseString] isEqualToString:@"jpg"]) {
        result = [self writeFile:UIImageJPEGRepresentation(image, compressionQuality) forPath:filePath replace:YES];
    }
    return result;
}

+ (BOOL) writePNGImage:(UIImage *) image forPath:(NSString*) filePath {
    BOOL result = NO;
    if (image && [[[filePath pathExtension] lowercaseString] isEqualToString:@"png"]) {
        result = [self writeFile:UIImagePNGRepresentation(image) forPath:filePath replace:YES];
    }
    return result;
}

+ (BOOL) deleteFile:(NSString*) filePath {
    BOOL result = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        result = [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
    }
    return result;
}

+ (BOOL)existFile:(NSString *)filePath {
    if (filePath) {
        return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    }
    return NO;
}

+ (BOOL)moveFile:(NSString *)filePath target:(NSString *)targetPath {
    if (filePath && targetPath) {
        return [[NSFileManager defaultManager] moveItemAtPath:filePath toPath:targetPath error:NULL];
    }
    return NO;
}

+ (BOOL)copyFile:(NSString *)filePath target:(NSString *)targetPath {
    if (filePath && targetPath) {
        return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:targetPath error:NULL];
    }
    return NO;
}

+ (long long) fileSize:(NSString*) filePath {
    long long size = -1;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:nil];
        NSNumber *theFileSize = [attributes objectForKey:NSFileSize];
        if (theFileSize) {
            size = [theFileSize longLongValue];
        }
    }
    return size;
}
@end

