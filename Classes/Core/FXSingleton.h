//
//  FXSingleton.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/15.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark -

#if __has_feature(objc_instancetype)

    /**
     *  单例定义宏
     *  放在.h文件 @interface 下面 例如:AS_SINGLETON(ClassName)
     */
    #undef	AS_SINGLETON
    #define AS_SINGLETON( ... ) \
    + (instancetype)sharedInstance;

    /**
     *  单例实现宏，不支持singleInit初始化方法
     *  放在.m文件 @implementation 下面 例如:DEF_SINGLETON(ClassName)
     */
    #undef	DEF_SINGLETON
    #define DEF_SINGLETON( ... ) \
    - (id) copy { \
        return self; \
    } \
    - (id) mutableCopy { \
        return self; \
    } \
    + (instancetype)sharedInstance \
    { \
        static dispatch_once_t once; \
        static id __singleton__; \
        dispatch_once( &once, ^{ \
            __singleton__ = [[self alloc] init]; \
        }); \
        return __singleton__; \
    }

    /**
     *  单例实现宏，支持singleInit初始化方法
     *  放在.m文件 @implementation 下面 例如:DEF_SINGLETON_INIT(ClassName)
     *  实现方法 -(void) singleInit {} 方法
     */
    #undef	DEF_SINGLETON_INIT
    #define DEF_SINGLETON_INIT( ... ) \
    - (id) copy { \
        return self; \
    } \
    - (id) mutableCopy { \
        return self; \
    } \
    + (instancetype)sharedInstance \
    { \
        static dispatch_once_t once; \
        static id __singleton__; \
        dispatch_once( &once, ^{ \
            __singleton__ = [[self alloc] init]; \
            if ([__singleton__ respondsToSelector:@selector(singleInit)]) { \
                [__singleton__ singleInit]; \
            } \
        }); \
        return __singleton__; \
    }
#else	// #if __has_feature(objc_instancetype)

    #undef	AS_SINGLETON
    #define AS_SINGLETON( __class ) \
    + (__class *)sharedInstance;

    #undef	DEF_SINGLETON
    #define DEF_SINGLETON( __class ) \
    - (id) copy { \
        return self; \
    } \
    - (id) mutableCopy { \
        return self; \
    } \
    + (__class *)sharedInstance \
    { \
        static dispatch_once_t once; \
        static __class * __singleton__; \
        dispatch_once( &once, ^{ \
            __singleton__ = [[[self class] alloc] init]; \
            if ([__singleton__ respondsToSelector:@selector(singleInit)]) { \
                [__singleton__ performSelector:@selector(singleInit)]; \
            } \
        }); \
        return __singleton__; \
    }
#endif	// #if __has_feature(objc_instancetype)

    /**
     *  自动加载此单利
     */
    #undef	DEF_SINGLETON_AUTOLOAD
    #define DEF_SINGLETON_AUTOLOAD( __class ) \
    DEF_SINGLETON( __class ) \
    + (void)load \
    { \
        [self sharedInstance]; \
    }

#pragma mark -
