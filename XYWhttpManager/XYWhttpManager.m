//
//  XYWhttpManager.m
//  XYW
//
//  Created by xueyongwei on 16/8/22.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "XYWhttpManager.h"
#import "AFHTTPSessionManager+SharedManager.h"
#import "XYWHTTPCache.h"
#import <NSDate+YYAdd.h>

#define kTokenInvalueCode @"1005"


@implementation XYWhttpManager

/**
 更新下AFHTTPSessionManager的token
 */
+(void)refreshRequestToken
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    [manager refreshRequestToken];
}

/**
 请求网络数据
 
 @param urlString 地址
 @param param 参数
 @param VC 发起者
 @param success 成功的回调
 @param failure 失败的回调
 */
+(void)XYWpost:(NSString *)urlString parameters:(NSDictionary *)param inViewController:(UIViewController *)VC sucess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    //发起网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    [manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"errCode"]) {
            //此处只拦截所有网络请求共同使用的错误
            NSString *errCode = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"errCode"]];
            if ([errCode isEqualToString:kTokenInvalueCode]) {//登录信息错误
               
            }
        }
        //把数据往后传递
        if (success) {
            success(responseObject) ;
        }
        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 发起带缓存的post数据请求

 @param urlString 地址
 @param param 参数
 @param VC 发起者
 @param refresh 本次请求需要强制更新网络数据
 @param success 成功的回答
 @param failure 失败的回调
 */
+(void)XYWCachePost:(NSString *)urlString parameters:(NSDictionary *)param inViewController:(UIViewController *)VC refresh:(BOOL)refresh sucess:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    if (!refresh) {//不是强制更新网络数据时才判断是否用网络请求
        NSDictionary *localCache =[XYWHTTPCache httpCacheForURL:urlString parameters:param];
        if (localCache) {//本地有数据，检查过期时间
            NSString *cacheTime = [localCache objectForKey:@"Expires"];
            if (![self hasExpires:cacheTime]) {//缓存还未过期，加载本地数据后直接返回
                success(localCache[@"responseObject"]);
                return;
            }
        }
    }
    //发起网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    [manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"errCode"]) {
            //此处只拦截所有网络请求共同使用的错误
            NSString *errCode = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"errCode"]];
            if ([errCode isEqualToString:kTokenInvalueCode]) {//登录信息错误
                
            }
        }
        //加工网络数据，并缓存到本地
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {//获取是否缓存，和缓存过期时间
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            NSString *Expires = [r.allHeaderFields objectForKey:@"Expires"];
            NSMutableDictionary *dataToCache = [NSMutableDictionary new];
            [dataToCache setObject:Expires.length>0?Expires:[self defaultTime] forKey:@"Expires"];
            [dataToCache setObject:responseObject forKey:@"responseObject"];
            if (responseObject) {
                [XYWHTTPCache setHttpCache:dataToCache URL:urlString parameters:param];
            }
        }
        //把数据往后传递
        if (success) {
            success(responseObject) ;
        }
        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 判断日期字符串是否过期

 @param dataStr 日期字符串
 @return 是否过期
 */
+(BOOL)hasExpires:(NSString *)dataStr
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formater setLocale:local];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formater dateFromString:dataStr];
    //是否比现在早（YES：过期了）
    return [date earlierDate:[NSDate date]];
}

/**
 获取个默认的过期时间

 @return 过期时间（默认为100s）
 */
+(NSString *)defaultTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:100];
    NSString *str = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    return str;
}
@end
