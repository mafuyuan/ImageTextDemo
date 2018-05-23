//
//  EmtionView.m
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
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
