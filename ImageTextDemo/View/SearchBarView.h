//
//  SearchBarView.h
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2016/12/19.
//  Copyright © 2016年 佳思德Mac. All rights reserved.
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
