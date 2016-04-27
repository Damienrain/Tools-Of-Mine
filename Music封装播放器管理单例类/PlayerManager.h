//
//  PlayerManager.h
//  PlayerM
//
//  Created by 左建军 on 16/4/4.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

// 播放模式
typedef NS_ENUM(NSInteger, PlayType){
    playTypeSingle, // 单曲
    playTypeRandom, // 随机
    playTypeList    // 顺序
};
// 播放状态
typedef NS_ENUM(NSInteger, PlayerState){
    playerStatePlay,  // 播放
    playerStatePause  // 暂停
};


@interface PlayerManager : NSObject

@property (nonatomic, assign, readonly)PlayerState playerState;  // 播放状态
@property (nonatomic, assign) PlayType playType; // 播放模式

@property (nonatomic, strong) NSMutableArray *musicArray;  // 传入的播放列表
@property (assign) NSUInteger playIndex;  //传入播放位置

@property (nonatomic, assign, readonly) float currentTime; // 当前时长
@property (nonatomic, assign, readonly) float totalTime; // 总时长

@property (nonatomic, strong)AVPlayer *avPlayer; // 播放器对象

//  单例创建对象
+ (instancetype)defaultManager;

- (void)play; // 播放
- (void)pause;  // 暂停
- (void)stop;  // 停止
- (void)seekToNewTime:(float)time; // 指定位置播放

- (void)lastMusic; // 上一首
- (void)nextMusic; // 下一首
- (void)changeMusicWithIndex:(NSInteger)index; // 指定位置切换

- (void)playerDidFinish; // 播放完成


@end









