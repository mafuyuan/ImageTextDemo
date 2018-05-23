//
//  ComposeToolBar.m
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2016/12/30.
//  Copyright © 2016年 佳思德Mac. All rights reserved.
//

#import "ComposeToolBar.h"

@implementation ComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.adjustsImageWhenHighlighted = NO;
        [button setImage:[UIImage imageNamed:@"emotion_picture"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"textkeyBoard"] forState:UIControlStateSelected];
        button.selected = NO;
        [self addSubview:button];
        self.button  = button;
    }
    return self;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    self.button.selected = !self.button.selected;
    if ([self.delegate respondsToSelector:@selector(composeTool:)]) {
        [self.delegate composeTool:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIButton *button = self.subviews[0];
    button.y = 0;
    button.width = 60;
    button.height = self.height;
    button.x = self.width - button.width;
}

@end
