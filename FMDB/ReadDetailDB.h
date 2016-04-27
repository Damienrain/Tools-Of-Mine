//
//  ReadDetailDB.h
//  Leisure
//
//  Created by aren on 16/4/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "ReadDetailListModel.h"
#import "FMDB.h"

/**
 
 根据模型来管理数据库实现增删改查
 1.
 
 */


@interface ReadDetailDB : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;

/*
//  创建数据表
- (void)createDataTable;
//  插入一条数据
- (void) saveDetailModel:(ReadDetailListModel *)detailModel;
//  删除一条数据
- (void) deleteDetailWithTitle:(NSString *)detailTitle;
//  查询所有数据
- (NSArray *)findWithUserID:(NSString *)userID;
*/


//创建表
- (void)createDataTable;

//根据模型插入一条数据
- (void)saveDetailModel:(ReadDetailListModel *)detailModel;

//根据标题删除一条数据
- (void)deleteDetailWithTitle:(NSString *)detailTitle;

//查询所有数据返回一个数组
- (NSArray *)findWithUserID:(NSString *)userID;








@end




