//
//  SearchBarView.h
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionTextView.h"
@protocol SearchBarViewDelegate <NSObject>

- (void)buttonClick:(NSString *)msg;

@optional

- (void)setUpOriginal;

@end

@interface SearchBarView : UIView<UITextViewDelegate>

@property (nonatomic,weak)UIView *bgView;

@property (nonatomic,weak)UIImageView *searchImageV;

@property (nonatomic,strong)EmotionTextView *textView;

@property (nonatomic,weak)UIButton *rightButton;

@property (nonatomic,assign)id<SearchBarViewDelegate>delegate;

@end
