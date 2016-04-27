//
//  NetworkRequestManager.h
//  LeftMenu
//
//  Created by 阿仁欧巴 on 16/3/29.
//  Copyright © 2016年 aren. All rights reserved.
//

#import <Foundation/Foundation.h>


//定义枚举 枚举请求方式

typedef NS_ENUM(NSInteger, requestType) {
    GET,
    POST
};

//定义block 请求成功或者失败
typedef void (^requestFinish) (NSData *data);
typedef void (^requestError) (NSError *error);

@interface NetworkRequestManager : NSObject

//定义一个请求方法
+ (void)requestWithType:(requestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(requestFinish)finish error:(requestError)error;





@end
