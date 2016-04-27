//
//  PlayerManager.m
//  PlayerM
//
//  Created by 左建军 on 16/4/4.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PlayerManager.h"

@implementation PlayerManager

//synthesize 是对属性的实现 实际就是指定setter和getter操作的实例变量名是什么
//@synthesize musicArray 默认操作的实例变量名和属性同名
//@synthesize musicArray = _musicArray  指定变量名为等号后的符号
//XCode4.5之后 synthensize 可以省略 默认系统的实现的setter和getter中操作的实例变量名为：_属性名  如果重写setter和getter方法 那么必须得用@synthesize

@synthesize musicArray = _musicArray;

#pragma mark -创建方和初始化方法-

+ (instancetype)defaultManager {
    static PlayerManager *playerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerManager = [[PlayerManager alloc]init];
    });
    return playerManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _playType = playTypeList;  // 默认是顺序播放
        _playerState = playerStatePause;  // 默认暂停状态
    }
    return self;
}

//  重写播放源的setter，getter
-(NSMutableArray *)musicArray {
    if (!_musicArray) {
        _musicArray = [[NSMutableArray alloc] init];
    }
    return _musicArray;
}
- (void)setMusicArray:(NSMutableArray *)musicArray{
    
    // 将原始播放列表清空
    [self.musicArray removeAllObjects];
    // 重新给列表赋值
    [self.musicArray addObjectsFromArray:musicArray];
    
    // 根据播放位置创建播放单元
    AVPlayerItem *avPlayerItem = nil;
    // 通过网络路径来创建
    if ([musicArray[_playIndex] hasPrefix:@"http"]) {
        avPlayerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:_musicArray[_playIndex]]];
    } else {
        // 通过本地路径来创建
        avPlayerItem = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:_musicArray[_playIndex]]];
    }
    
    // 创建播放器，如果存在切换播放单元，否则根据播放单元创建新的播放器
    if (_avPlayer) {
        [_avPlayer replaceCurrentItemWithPlayerItem:avPlayerItem];
    } else {
        _avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    }
    // 默认设置播放状态是暂停状态
    _playerState = playerStatePause;
}

//  获取当前时长
- (float)currentTime {
    //  当前基数为零
    if (_avPlayer.currentItem.timebase == 0) {
        return 0;
    }
    return _avPlayer.currentTime.value / _avPlayer.currentTime.timescale;
}

//  获取总时长
- (float)totalTime {
    if (_avPlayer.currentItem.duration.timescale == 0) {
        return 0;
    }
    return _avPlayer.currentItem.duration.value / _avPlayer.currentItem.duration.timescale;
}

#pragma mark -播放控制-
//  播放
- (void)play {
    [_avPlayer play];
    _playerState = playerStatePlay;
}

//  暂停
- (void)pause {
    [_avPlayer pause];
    _playerState = playerStatePause;
}

// 停止
- (void)stop {
    [self seekToNewTime:0];
    [self pause];
}

// 上一首
- (void)lastMusic {
    // 随机模式
    if (_playType == playTypeRandom) {
        _playIndex = arc4random() % _musicArray.count;
    }else{ // 其他模式
        if (_playIndex == 0) {
            _playIndex = _musicArray.count - 1;
        }
        else {
            _playIndex--;
        }
    }
    [self changeMusicWithIndex:_playIndex];
}
// 下一首
- (void)nextMusic {
    // 随机模式
    if (_playType == playTypeRandom) {
        _playIndex = arc4random() % _musicArray.count;
    }else{ // 其他模式
        _playIndex++;
        if (_playIndex == _musicArray.count) {
            _playIndex = 0;
        }
    }
    [self changeMusicWithIndex:_playIndex];
}
// 指定位置播放
- (void)seekToNewTime:(float)time {
    // 获取播放器的当前时间
    CMTime newTime = _avPlayer.currentTime;
    // 重新设置播放的时间
    newTime.value = newTime.timescale * time;
    // 播放器跳转到新的时间
    [_avPlayer seekToTime:newTime];
}

//  按照指定位置进行切换
- (void)changeMusicWithIndex:(NSInteger)index
{
    // 将指定位置赋值给当前位置
    _playIndex = index;
    AVPlayerItem *avPlayerItem = nil;
    // 通过网络路径来创建
    if ([_musicArray[_playIndex] hasPrefix:@"http"]) {
        avPlayerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:_musicArray[_playIndex]]];
    } else {
        // 通过本地路径来创建
        avPlayerItem = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:_musicArray[_playIndex]]];
    }
    [_avPlayer replaceCurrentItemWithPlayerItem:avPlayerItem];
    
    [self play];
}

//  播放完成
- (void)playerDidFinish{
    if (_playType == playTypeSingle) {
        _playIndex--;  // 单曲播放完成之后还是当前位置
    } else{
        
    }
    [self nextMusic];
}
 

@end










