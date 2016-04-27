//
//  DBManager.m
//  Leisure
//
//  Created by 左建军 on 16/4/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DBManager.h"

static DBManager *manager = nil;
@implementation DBManager

//自定义初始化方法
- (instancetype)initWithdbName:(NSString *)dbName {
    
    self = [super init];
    if (self) {
        if (!dbName) {
            NSLog(@"数据库名不存在");
        }
        //获取沙盒路径
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //创建数据库存放路径
        NSString *sqlPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",dbName]];
        BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:sqlPath];
        //exist == 0, 创建成功; exsit == 1, 已经存在
        if (!exist) {
            NSLog(@"创建数据库成功");
        } else {
            NSLog(@"数据库已经存在");
        }
        //根据数据库路径打开数据库
        [self openDBWithPath:sqlPath];
    }
    return self;
}

- (void)openDBWithPath:(NSString *)sqlPath
{
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:sqlPath];
    }
    if (![_dataBase open]) {
        NSLog(@"不能打开数据库");
    }
}


//单例方法
+ (DBManager *)defaultDBManager:(NSString *)dbName
{
    @synchronized(self) {
        if (manager == nil) {
            manager = [[DBManager alloc] initWithdbName:dbName];
        }
    }
    return manager;
}


//关闭数据库
- (void)closeDB
{
    [_dataBase close];
    manager = nil;
}

- (void)dealloc
{
    [self closeDB];
}








/*
static DBManager *_dbManager = nil;
+ (DBManager *)defaultDBManager:(NSString *)dbName {
    // 互斥锁
    @synchronized(self) {
        if (!_dbManager) {
            _dbManager = [[DBManager alloc] initWithdbName:dbName];
        }
    }
    return _dbManager;
}

- (instancetype)initWithdbName:(NSString *)dbName {
    self = [super init];
    if (self) {
        if (!dbName) {  // 数据库名不存在
            NSLog(@"创建数据库失败！");
        } else {
            // 获取沙盒路径
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            // 创建数据库路径
            NSString *dbPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@",dbName]];
            BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
            // exist==0 创建路径成功;  ==1 路径已经存在
            if (!exist) {
                NSLog(@"数据库路径：%@", dbPath);
            } else {
                NSLog(@"数据库路径：%@", dbPath);
            }
            [self openDB:dbPath];
        }
    }
    return self;
}

//  打开数据库
- (void)openDB:(NSString *)dbPath {
    if (!_dataBase) {
        self.dataBase = [FMDatabase databaseWithPath:dbPath];
    }
    if (![_dataBase open]) {
        NSLog(@"不能打开数据库");
    }
}

//  关闭数据库
- (void) closeDB {
    [_dataBase close];
    _dbManager = nil;
}

- (void) dealloc {
    [self closeDB];
}
*/


@end
