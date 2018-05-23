//
//  ViewController.m
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.

#import "ViewController.h"
#import "ComposeToolBar.h"
#import "SearchBarView.h"
#import "EmotionKeyboard.h"
#import "EmotionTool.h"
#import "DecoderTool.h"

@interface ViewController ()<SearchBarViewDelegate,ComposeToolbarDelegate>

@property (nonatomic,weak)SearchBarView *bar;

@property (nonatomic, strong) UIButton *hideKeyboard;

@property (nonatomic, strong) ComposeToolBar *toolbar;

@property (nonatomic, strong) EmotionKeyboard *kerboard;
/**  是否正在切换键盘 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

@property (weak, nonatomic) IBOutlet UILabel *displayLab;

@end

@implementation ViewController

- (UIButton *)hideKeyboard{
    if (!_hideKeyboard) {
        self.hideKeyboard = [[UIButton alloc]init];
        _hideKeyboard.backgroundColor = [UIColor clearColor];
        _hideKeyboard.frame = self.view.bounds;
        [_hideKeyboard addTarget:self action:@selector(hideKeyboardAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_hideKeyboard belowSubview:self.toolbar];//添加到toolbar的后面
    }
    return _hideKeyboard;
}

- (ComposeToolBar *)toolbar{
    if (!_toolbar) {
        self.toolbar = [[ComposeToolBar alloc] init];
        _toolbar.width = self.view.width;
        _toolbar.delegate = self;
        _toolbar.height = 44;
        _toolbar.y = self.view.height;
        [self.view addSubview:_toolbar];
    }
    return _toolbar;
}
- (EmotionKeyboard *)kerboard{
    if (!_kerboard) {
        self.kerboard = [EmotionKeyboard keyboard];
        self.kerboard.emotions =[EmotionTool trafficSigns];
        self.kerboard.width = SCREEN_WIDTH;
        self.kerboard.height = 216;
    }
    return _kerboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:EmotionDidSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:EmotionDidDeletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    SearchBarView *bar = [[SearchBarView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 88)];
    bar.delegate = self;
    [self.view addSubview:bar];
    self.bar = bar;
    
    self.toolbar.hidden = NO;//解决第一次动画闪屏的bug
}

#pragma mark - ComposeToolbarDelegate 监听按钮的点击事件
- (void)composeTool:(ComposeToolBar *)toolbar{
    if (toolbar.button.selected) {
        
        [self openEmotionKeyBoard];// 打开表情键盘
    }else{
        
        [self openDefaultKeyBoard];// 打开默认键盘
    }
}

#pragma mark - 通知相关
- (void)emotionDidSelected:(NSNotification *)note
{
    Emotion *emotion = note.userInfo[SelectedEmotion];
    
    [self.bar.textView appendEmotion:emotion];// 1.拼接表情
    
    self.bar.rightButton.enabled = self.bar.textView.attributedText != nil;//是否可以点击按钮
    
    [self tipInputMore];// 提示不能超过限制
}

- (void)emotionDidDeleted:(NSNotification *)note
{
    [self.bar.textView deleteBackward];
}

/**  键盘即将隐藏 */
- (void)keyboardWillHide:(NSNotification *)note{
    
    if (self.isChangingKeyboard) return;
    
    self.hideKeyboard.hidden = YES;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];// 1.键盘弹出需要的时间
    
    [UIView animateWithDuration:duration animations:^{
        
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
    
}
/**  键盘即将弹出 */
- (void)keyboardWillShow:(NSNotification *)note {
    
    self.hideKeyboard.hidden = NO;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];// 1.键盘弹出需要的时间
    
    [UIView animateWithDuration:duration animations:^{
        
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]; // 取出键盘高度
        
        CGFloat keyboardH = keyboardF.size.height;
        
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH - self.toolbar.height);
    }];
    
}

#pragma mark - SearchBarViewDelegate
/**
 点击发送按钮
 @param msg 文字
 */
-(void)buttonClick:(NSString *)msg{
    
    self.displayLab.attributedText = [[DecoderTool sharedDecoderTool] decodeWithPlainStr:msg font:[UIFont systemFontOfSize:25] textColor: [UIColor redColor]];//设置富文本
    
    [self disPLabelSizeFit];
    
}
- (void)setUpOriginal{
    
    self.toolbar.button.selected = NO;
}

/**
 打开图片键盘
 */
- (void)openEmotionKeyBoard{
    self.changingKeyboard = YES;// 正在切换键盘
    self.bar.textView.inputView = self.kerboard;
    [self.bar.textView resignFirstResponder];// 关闭键盘
    self.changingKeyboard = NO; // 更换完毕 ,记录是否正在更换键盘
    [self.bar.textView becomeFirstResponder];
}

/**
 打开默认键盘
 */
- (void)openDefaultKeyBoard{
    self.changingKeyboard = YES;// 正在切换键盘
    self.bar.textView.inputView = nil;
    [self.bar.textView resignFirstResponder];
    self.changingKeyboard = NO; // 更换完毕 ,记录是否正在更换键盘
    [self.bar.textView becomeFirstResponder];
}

/** 提示输入过多 */
- (void)tipInputMore {
    
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSData *data =[self.bar.textView.realText dataUsingEncoding:gbkEncoding];
    
    if (data.length>24) {//提示输入内容过多
        
        [self presentAlertViewWithTitle:@"提示" msg:@"输入的内容超出了限制，请重新输入"];
        
        return;
    }
}

/** 弹出框 */
- (void)presentAlertViewWithTitle:(NSString *)title msg:(NSString *)msg{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/** 隐藏键盘 */
- (void)hideKeyboardAction{
    
    [self.bar.textView resignFirstResponder];
    self.bar.textView.inputView = nil;
    self.toolbar.button.selected = NO;
}

- (void)disPLabelSizeFit{
    
    [self.displayLab sizeToFit];
    CGFloat labelY = self.displayLab.y;
    CGFloat labelW = self.displayLab.width;
    self.displayLab.frame = CGRectMake(0, labelY, labelW , 40);
    self.displayLab.centerX = SCREEN_WIDTH/2;
}
@end
