//
//  AFHTTPSessionManager+SharedManager.m
//  ZuoYou
//
//  Created by xueyognwei on 16/12/15.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "AFHTTPSessionManager+SharedManager.h"

@implementation AFHTTPSessionManager (SharedManager)
static AFHTTPSessionManager *manager;
+(AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager] ;
//        NSString *apiCerPath = [[NSBundle mainBundle] pathForResource:@"api.zuoyoupk.com" ofType:@"cer"];
//        NSData *apicertData =[NSData dataWithContentsOfFile:apiCerPath];
//        NSString *uploadCerPath = [[NSBundle mainBundle] pathForResource:@"upload.zuoyoupk.com" ofType:@"cer"];
//        NSData *uploadCertData =[NSData dataWithContentsOfFile:uploadCerPath];
//        NSString *wxCerPath = [[NSBundle mainBundle] pathForResource:@"mp.weixin.qq.com" ofType:@"cer"];
//        NSData *wxCertData =[NSData dataWithContentsOfFile:wxCerPath];
//        //设置ATS证书
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        securityPolicy.validatesDomainName = YES;
//        // 是否允许,NO-- 不允许无效的证书
//        securityPolicy.allowInvalidCertificates=YES;
//        //也不验证域名一致性
//        securityPolicy.validatesDomainName=NO;
//        //关闭缓存避免干扰测试
//        manager.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
//        // 设置证书
//        NSSet * certSet = [[NSSet alloc] initWithObjects:apicertData,uploadCertData,wxCertData, nil];
//        [securityPolicy setPinnedCertificates:certSet];
//        manager.securityPolicy = securityPolicy;
        manager.requestSerializer.timeoutInterval = 30.0;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
//        [manager refreshRequestToken];
    });
    return manager;
}
-(void)refreshRequestToken
{
    [self.requestSerializer setValue:[self token] forHTTPHeaderField:@"Auth-Access-Token"];
}
-(NSString *)token
{
   return @"token";
}

@end
