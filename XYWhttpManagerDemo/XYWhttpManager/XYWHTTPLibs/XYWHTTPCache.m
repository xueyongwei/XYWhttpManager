//
//  PPNetworkCache.m
//  PPNetworkHelper
//
//  Created by AndyPang on 16/8/12.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import "XYWHTTPCache.h"
#import <YYCache.h>

@implementation XYWHTTPCache
static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;


+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}



+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    if(!parameters){return URL;};
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}
@end

