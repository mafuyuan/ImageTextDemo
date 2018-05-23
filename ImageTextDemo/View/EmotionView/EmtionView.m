//
//  EmtionView.m
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
//

#import "EmtionView.h"

#import "Emotion.h"

@implementation EmtionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(Emotion *)emotion
{
    _emotion = emotion;
    NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
    UIImage *image = [UIImage imageNamed:icon];
    [self setImage:image forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateNormal];
}

@end
