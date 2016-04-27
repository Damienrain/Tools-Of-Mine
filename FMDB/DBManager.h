//
//  DBManager.h
//  Leisure
//
//  Created by 左建军 on 16/4/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

/***
        
 1.初始化数据库操作对象
 2.创建数据库的路径
 3.根据路径打开数据库
 4.在dealloc方法中关闭数据库 销毁操作对象
 
 */


@interface DBManager : NSObject

//声明数据操作对象
@property (nonatomic, strong) FMDatabase *dataBase;

//自定义初始化方法
- (instancetype)initWithdbName:(NSString *)DBName;

//单例方法
+ (DBManager *)defaultDBManager:(NSString *)dbName;


//关闭数据库
- (void)closeDB;




















/*
@property (nonatomic, strong) FMDatabase * dataBase;  // 数据库操作对象


//  单例模式创建数据库操作对象;
//  传入数据库名称，在方法中创建数据库;
+ (DBManager *)defaultDBManager:(NSString *)dbName;

//  自定义初始化方法
- (instancetype)initWithdbName:(NSString *)dbName;

// 关闭数据库
- (void) closeDB;
 */



@end
