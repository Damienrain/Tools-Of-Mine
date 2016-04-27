//
//  NetworkRequestManager.m
//  LeftMenu
//
//  Created by 阿仁欧巴 on 16/3/29.
//  Copyright © 2016年 aren. All rights reserved.
//

#import "NetworkRequestManager.h"

@implementation NetworkRequestManager

+ (void)requestWithType:(requestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(requestFinish)finish error:(requestError)error
{
    //1.创建请求对象
    NetworkRequestManager *manager = [[NetworkRequestManager alloc] init];
    //2.执行请求方法
    [manager requestWithType:type urlString:urlString parDic:parDic finish:finish error:error];

}

//这样变成“-” 本类对象就可以使用了
- (void)requestWithType:(requestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(requestFinish)finish error:(requestError)requestError;
{
    //1.将字符串转换为URL对象
    NSURL *url = [NSURL URLWithString:urlString];
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //3.判断type是GET还是POST
    if (type == POST) {
        [request setHTTPMethod:@"POST"];
        if (parDic.count > 0) {
            [request setHTTPBody:[self parDicToData:parDic]];
        }
    }
  
    //4.请求网络创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    //5.创建task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            finish(data);
        } else {
            requestError(error);
        }
    }];
    //6.执行任务
    [task resume];
    
}

//将字典请求参数q转换为数据对象

- (NSData *)parDicToData:(NSDictionary *)parDic
{
    NSMutableArray *mArray = [NSMutableArray array];
    //1.遍历字典 首先得到key
    for (NSString *key in parDic) {
        //2.将遍历的结果转换为这样的字符串形式  然后再添加到数组中保存起来
        NSString *str = [NSString stringWithFormat:@"%@=%@",key, parDic[key]];
        [mArray addObject:str];
    }
    //3.将数组中的元素链接起来成为一个字符串
    NSString *parameter = [mArray componentsJoinedByString:@"&"];
    //4.返回编码数据
    NSData *data = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;

}






















@end
