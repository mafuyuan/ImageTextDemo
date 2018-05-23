//
//  SearchBarView.m
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import "SearchBarView.h"
#import "EmotionTextView.h"
@implementation SearchBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = MY_Color(242, 242, 242, 1);
        
        UIView *bgView  = [[UIView alloc]init];

        bgView.backgroundColor = [UIColor whiteColor];
        
        bgView.layer.cornerRadius = 22;
        
        bgView.layer.masksToBounds = YES;
        
        [self addSubview:bgView];
        
        self.bgView = bgView;
        
        
        UIImageView *searchImageV = [[UIImageView alloc]init];
        
        searchImageV.image = [UIImage imageNamed:@"search"];
        
        searchImageV.contentMode = UIViewContentModeCenter;
        
        [self addSubview:searchImageV];
        
        self.searchImageV = searchImageV;
        
        EmotionTextView *textView = [[EmotionTextView alloc]init];
        
        textView.textContainerInset = UIEdgeInsetsMake(11, -5, 0, -5);
        
        textView.font = [UIFont systemFontOfSize:18];
        
        textView.delegate = self;
        
        textView.returnKeyType = UIReturnKeyDone;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:)name:UITextViewTextDidChangeNotification object:textView];
        
        [self addSubview:textView];
        
        self.textView = textView;
        
        
        UIButton *rightButton = [[UIButton alloc]init];
        
        [rightButton setImage:[UIImage imageNamed:@"send"] forState:UIControlStateDisabled];
        
        [rightButton setImage:[UIImage imageNamed:@"send-On"] forState:0];
        
        rightButton.enabled = NO;
        
        [rightButton addTarget:self action:@selector(adClick) forControlEvents:UIControlEventTouchUpInside];
        
        rightButton.imageView.contentMode = UIViewContentModeCenter;
        
        [self addSubview:rightButton];
        
        self.rightButton = rightButton;
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(12, 0, self.width - 24, 44);
    
    self.bgView.centerY = self.height/2;
    
    self.searchImageV.frame = CGRectMake(12, 0, 44, 44);
    
    self.searchImageV.centerY = self.height/2;
    
    CGFloat buttonW = 80;
    
    self.rightButton.frame = CGRectMake(self.width - 12 - buttonW , 0, buttonW, 44);
    
    self.rightButton.centerY = self.height/2;
    
    self.textView.frame = CGRectMake(56, 0, self.bgView.width-44 - 80, 44);
    
    self.textView.centerY = self.height/2;
    
}


- (void)adClick{
    
    if ([self.delegate respondsToSelector:@selector(buttonClick:)]) {
        
        [self.delegate buttonClick:self.textView.realText];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        textView.inputView = nil;
        if ([_delegate respondsToSelector:@selector(setUpOriginal)]) {
            [self.delegate setUpOriginal];
        }
        return NO;
    }
    return YES;
//    EmotionTextView *m_textView =(EmotionTextView *)textView;
//    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *data =[m_textView.realText dataUsingEncoding:gbkEncoding];
//    if (data.length>24) {//提示输入内容过多
//        return NO;
//    }else{
//        return YES;
//    }
}

/**
 *  监听UITextfield值的变化
 */
-(void)textViewEditChanged:(NSNotification *)obj{
    if (self.textView.text ==nil || [self.textView.text isEqualToString:@""]) {
        self.rightButton.enabled = NO;
    }else{
        self.rightButton.enabled = YES;
    }
}



@end
