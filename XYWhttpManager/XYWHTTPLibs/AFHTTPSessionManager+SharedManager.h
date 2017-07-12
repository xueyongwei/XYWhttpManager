//
//  AFHTTPSessionManager+SharedManager.h
//  ZuoYou
//
//  Created by xueyognwei on 16/12/15.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
/*
    目的：
    解决[AFHTTPSessionManager manager]方法带来的内存泄漏
 */
@interface AFHTTPSessionManager (SharedManager)
+(AFHTTPSessionManager *)sharedManager;
-(void)refreshRequestToken;
@end
