//
//  EmtionGrideView.m
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
//

#import "EmotionGrideView.h"
#import "EmtionView.h"

@interface EmotionGrideView ()

@property (nonatomic, weak) UIButton *deleteButton;

@property (nonatomic, strong) NSMutableArray *emotionViews;


@end

@implementation EmotionGrideView


- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

/**
 *  监听表情的单击
 */
- (void)emotionClick:(EmtionView *)emotionView
{
    [self selecteEmotion:emotionView.emotion];

}

/**
 *  点击了删除按钮
 */
- (void)deleteClick
{
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDidDeletedNotification object:nil userInfo:nil];
}

/**
 *  选中表情
 */
- (void)selecteEmotion:(Emotion *)emotion
{
    if (emotion == nil) return;
    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDidSelectedNotification object:nil userInfo:@{SelectedEmotion : emotion}];
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 添加新的表情
    NSInteger count = emotions.count;
    NSInteger currentEmotionViewCount = self.emotionViews.count;
    for (int i = 0; i<count; i++) {
        EmtionView *emotionView = nil;
        if (i >= currentEmotionViewCount) { // emotionView不够用
            emotionView = [[EmtionView alloc] init];
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else { // emotionView够用
            emotionView = self.emotionViews[i];
        }
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    
    // 隐藏多余的emotionView
    for (NSInteger i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    // 1.排列所有的表情
    NSInteger count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / EmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / EmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % EmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / EmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}


@end
