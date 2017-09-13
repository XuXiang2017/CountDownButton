//
//  CountDownButton.m
//  CountDownButton
//
//  Created by 徐翔 on 2017/9/12.
//  Copyright © 2017年 XuXiang. All rights reserved.
//

#import "CountDownButton.h"

#define defaultColor [UIColor colorWithRed:50/255.0 green:126/255.0 blue:243/255.0 alpha:1.0]

typedef void(^ButtonClickedBlock)();
typedef void(^CountDownBlock)(int time);
typedef void(^CountDownCompletionBlock)();

@interface CountDownButton()
{
    int _countDownTime;
}
/** 按钮点击事件的回调 */
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;
/** 倒计时进行中的回调 */
@property (nonatomic, copy) CountDownBlock countDownBlock;
/** 倒计时结束的回调 */
@property (nonatomic, copy) CountDownCompletionBlock countDownCompletionBlock;

@end
@implementation CountDownButton

- (instancetype)initWithDuration:(int)duration buttonClicked:(void(^)())buttonClicked countDowning:(void(^)(int time))countDownBlock countDownCompletion:(void(^)())completionBlock {
    self = [super init];
    if (self) {
        _countDownTime = duration;//倒计时最大时间，默认设为60s
        self.startTitle = @"发送验证码";
        self.changeTitle = @"已发送";
        self.backgroundColor = defaultColor;
        
        self.buttonClickedBlock = buttonClicked;
        self.countDownBlock = countDownBlock;
        self.countDownCompletionBlock = completionBlock;
        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setStartTitle:(NSString *)startTitle {
    _startTitle = startTitle;
    [self setTitle:self.startTitle forState:UIControlStateNormal];
}
- (void)setFont:(UIFont *)font {
    _font = font;
    [self.titleLabel setFont:font];
}
#pragma mark - 对齐方式
- (void)setAlignType:(AlignType)alignType {
    _alignType = alignType;
    
    switch (alignType) {
        case Center:
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;
        case Left:
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            break;
        case Right:
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            break;
        default:
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;
    }
}

#pragma mark - 调用方法
/**
 按钮点击事件
 */
- (void)clickButton:(CountDownButton *)btn {
    self.enabled = NO;
    self.backgroundColor = [UIColor lightGrayColor];
    
    [self countDown];
    
    self.buttonClickedBlock();
    
}

/**
 倒计时进行中调用方法
 */
- (void)countDown:(int)time {
    NSString *strTime = [NSString stringWithFormat:@"%@(%02d)", self.changeTitle, time];
    dispatch_async(dispatch_get_main_queue(), ^{
        //设置按钮显示 根据自己需求设置
        [self setTitle:strTime forState:UIControlStateNormal];
        
    });
    self.countDownBlock(time);
}
/**
 倒计时完成调用方法
 */
- (void)countDownCompletion {
    self.enabled = YES;
    self.backgroundColor = defaultColor;
    [self setTitle:self.startTitle forState:UIControlStateNormal];
    
    self.countDownCompletionBlock();
}

#pragma mark - 倒计时
- (void)countDown {
    
    
    __block int timeout = _countDownTime; //倒计时最大时间
    __weak typeof(self)weakSelf = self;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf countDownCompletion];
                
            });
        }else{
            
            [weakSelf countDown:timeout];
            timeout--;
            
        }

    });
    dispatch_resume(timer);
}

@end
