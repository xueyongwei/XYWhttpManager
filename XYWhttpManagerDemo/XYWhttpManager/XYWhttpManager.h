//
//  XYWhttpManager.h
//  XYW
//
//  Created by xueyongwei on 16/8/22.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    目的：封装网络请求借口
    1.可更换网络请求库
    2.处理网络统一问题（如：异地登录错误）
 */
@interface XYWhttpManager : NSObject
/**
 发起带缓存的post数据请求
 
 @param urlString 地址
 @param param 参数
 @param VC 发起者
 @param refresh 本次请求需要更新网络数据
 @param success 成功的回答
 @param failure 失败的回调
 */
+(void)XYWCachePost:(NSString *)urlString parameters:(NSDictionary *)param inViewController:(UIViewController *)VC refresh:(BOOL)refresh sucess:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
/**
 请求网络数据
 
 @param urlString 地址
 @param param 参数
 @param VC 发起者
 @param success 成功的回调
 @param failure 失败的回调
 */
+(void)XYWpost:(NSString *)urlString parameters:(NSDictionary *)param inViewController:(UIViewController *)VC sucess:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
/**
 更新下AFHTTPSessionManager的token
 */
+(void)refreshRequestToken;
@end
