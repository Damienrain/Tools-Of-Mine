//
//  CycleScrollView.m
//  Leisure
//
//  Created by 左建军 on 15/11/11.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface CycleScrollView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, assign) NSInteger currentPageIndex; // 当前页数
@property (nonatomic, strong) NSMutableArray *contentViews;

@end

@implementation CycleScrollView

#pragma mark -初始化方法-

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.autoresizesSubviews = YES; // 设置子视图自动调整布局
        
        self.currentPageIndex = 0; // 默认当前是第一页
        // 创建UIScrollView对象
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        // 创建UIPageControl对象
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, self.bounds.size.height - 30, 100, 30)];
        [self addSubview:_pageControl];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        // 创建定时器对象， 按照传入的时间间隔调用定时方法
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration) target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

#pragma mark -NSTimer定时方法-
- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (NSInteger)getNextPageIndex:(NSInteger)currentPageIndex {
    if(currentPageIndex == -1) {
        return self.totalPagesCount - 1;
    } else if (currentPageIndex == self.totalPagesCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

-(void)setTotalPagesCount:(NSInteger)totalPagesCount {
    _totalPagesCount = totalPagesCount;
    if (_totalPagesCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
        _pageControl.numberOfPages = _totalPagesCount;
    }
}
// 设置ScrollView的内容数据
- (void)setScrollViewContentDataSource
{
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    // 获取前一个位置和后一个位置
    NSInteger beforePageIndex = [self getNextPageIndex:self.currentPageIndex - 1];
    NSInteger afterPageIndex = [self getNextPageIndex:self.currentPageIndex + 1];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(beforePageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(afterPageIndex)];
    }
}
// 配置内容页面
- (void)configContentViews {
    // 将scrollView上的子视图全部移除
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 获取数据
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        
        //  添加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

//  点击页面进行回调
- (void)contentViewTapAction:(UITapGestureRecognizer *)tap {
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}


#pragma mark -UIScrollView的回调方法-

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //  滑动视图时将计时器暂停，防止手动滑动与自动滚动的冲突
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 手动滑动结束后，计时器继续
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getNextPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getNextPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
    _pageControl.currentPage = self.currentPageIndex;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
