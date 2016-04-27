//
//  ReadDetailDB.m
//  Leisure
//
//  Created by aren on 16/4/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadDetailDB.h"
#import "UserInfoManager.h"

@implementation ReadDetailDB

/*
//首先是初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataBase = [DBManager defaultDBManager:SQLITENAME].dataBase;//单例方法
        
    }
    return self;
}

//创建表
- (void)createDataTable
{
    //1.查询数据表中的元素个数
    FMResultSet *set = [self.dataBase executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'", READDETAILTABLE]];
    //2.如果有就不用创建 没有就创建表
    NSInteger count = [set intForColumnIndex:0];
    if (count) {
        NSLog(@"数据库表已经存在");
    } else {
        //没有就创建新的表
        NSString * sql = [NSString stringWithFormat:@"CREATE TABLE %@ (readID INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, userID text, title text, contentID text, content text, name text, coverimg text)", READDETAILTABLE];
        BOOL resultSet = [_dataBase executeUpdate:sql];
        if (resultSet) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    }

}

//根据模型插入一条数据
- (void)saveDetailModel:(ReadDetailListModel *)detailModel
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"insert into %@ (userID,title,contentid,content, name, coverimg) values (?,?,?,?,?,?)", READDETAILTABLE];
    //创建存放一条记录的信息的数组
    NSMutableArray *arguments = [[NSMutableArray alloc] initWithCapacity:0];
    if (![[UserInfoManager getUserID] isEqualToString:@" "]) {
        [arguments addObject:[UserInfoManager getUserID]];
    }
    if (detailModel.title) {
        [arguments addObject:detailModel.title];
    }
    if (detailModel.contentID) {
        [arguments addObject:detailModel.contentID];
    }
    if (detailModel.content) {
        [arguments addObject:detailModel.content];
    }
    if (detailModel.name) {
        [arguments addObject:detailModel.name];
    }
    if (detailModel.coverimg) {
        [arguments addObject:detailModel.coverimg];
    }
    NSLog(@"收藏一条数据");
    //执行数据库操作语句
    [_dataBase executeQuery:sql withArgumentsInArray:arguments];

}

//根据标题删除一条数据
- (void)deleteDetailWithTitle:(NSString *)detailTitle
{
    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE title = '%@'", READDETAILTABLE, detailTitle];
    NSLog(@"删除成功");
    [self.dataBase executeUpdate:query];
    
}

//查询所有数据返回一个数组
- (NSArray *)findWithUserID:(NSString *)userID
{
    FMResultSet *set = [self.dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE userID = '%@'", READDETAILTABLE, userID]];
    //创建数组保存 查询到的所有的数据
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[set columnCount]];
    while ([set next]) {
        ReadDetailListModel *model = [[ReadDetailListModel alloc] init];
        model.title = [set stringForColumn:@"title"];
        model.contentID = [set stringForColumn:@"contentid"];
        model.content = [set stringForColumn:@"content"];
        model.name = [set stringForColumn:@"name"];
        model.coverimg = [set stringForColumn:@"coverimg"];
        [array addObject:model];
        
     }
    NSLog(@"array is %@",array);
    //将数据库操作对象置空
    [set close];
    return array;
}
*/




- (id) init {
    self = [super init];
    if (self) {
        _dataBase = [DBManager defaultDBManager:SQLITENAME].dataBase;
        
    }
    return self;
}

//  创建数据表
- (void)createDataTable {
    // 查询数据表中元素个数
    FMResultSet * set = [_dataBase executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'", READDETAILTABLE]];
    [set next];
    NSInteger count = [set intForColumnIndex:0];
    if (count) {
        NSLog(@"数据表已经存在");
    } else {
        // 创建新的数据表
        NSString * sql = [NSString stringWithFormat:@"CREATE TABLE %@ (readID INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, userID text, title text, contentID text, content text, name text, coverimg text)", READDETAILTABLE];
        BOOL res = [_dataBase executeUpdate:sql];
        if (!res) {
            NSLog(@"数据表创建成功");
        } else {
            NSLog(@"数据表创建失败");
        }
    }
}
//  插入一条数据
- (void) saveDetailModel:(ReadDetailListModel *)detailModel {
    // 创建插入语句
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO %@ (userID,title,contentid,content, name, coverimg) values (?,?,?,?,?,?)", READDETAILTABLE];
    // 创建插入内容
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:0];
    if (![[UserInfoManager getUserID] isEqualToString:@" "]) {
        [arguments addObject:[UserInfoManager getUserID]];
    }
    if (detailModel.title) {
        [arguments addObject:detailModel.title];
    }
    if (detailModel.contentID) {
        [arguments addObject:detailModel.contentID];
    }
    if (detailModel.content) {
        [arguments addObject:detailModel.content];
    }
    if (detailModel.name) {
        [arguments addObject:detailModel.name];
    }
    if (detailModel.coverimg) {
        [arguments addObject:detailModel.coverimg];
    }
    NSLog(@"%@",query);
    NSLog(@"收藏一条数据");
    // 执行语句
    [_dataBase executeUpdate:query withArgumentsInArray:arguments];
}
//  删除一条数据
- (void) deleteDetailWithTitle:(NSString *)detailTitle {
    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE title = '%@'", READDETAILTABLE, detailTitle];
    NSLog(@"删除成功");
    [_dataBase executeUpdate:query];
}
//  查询所有数据
- (NSArray *)findWithUserID:(NSString *)userID {
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE userID = '%@'", READDETAILTABLE, userID];
    FMResultSet * rs = [_dataBase executeQuery:query];
    NSLog(@"rs 是：%@",rs);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
    
    while ([rs next]) {
        ReadDetailListModel * detailModel = [[ReadDetailListModel alloc] init];
        detailModel.title = [rs stringForColumn:@"title"];
        detailModel.contentID = [rs stringForColumn:@"contentid"];
        detailModel.content = [rs stringForColumn:@"content"];
        detailModel.name = [rs stringForColumn:@"name"];
        detailModel.coverimg = [rs stringForColumn:@"coverimg"];
        [array addObject:detailModel];
    }
    NSLog(@"array is %@",array);
    [rs close];
    return array;
}
 


@end
