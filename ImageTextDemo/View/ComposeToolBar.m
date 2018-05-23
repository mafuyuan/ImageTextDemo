//
//  ComposeToolBar.m
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
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
