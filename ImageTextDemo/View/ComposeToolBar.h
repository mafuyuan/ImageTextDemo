//
//  ComposeToolBar.h
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComposeToolBar;

@protocol ComposeToolbarDelegate <NSObject>

@optional

- (void)composeTool:(ComposeToolBar *)toolbar;

@end

@interface ComposeToolBar : UIView

@property (nonatomic, weak) id<ComposeToolbarDelegate> delegate;

@property (nonatomic ,weak)UIButton *button;

@end
