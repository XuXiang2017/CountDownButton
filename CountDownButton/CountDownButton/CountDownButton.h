//
//  CountDownButton.h
//  CountDownButton
//
//  Created by 徐翔 on 2017/9/12.
//  Copyright © 2017年 XuXiang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, AlignType) {
    Center,//居中对齐，默认值
    Left,//靠左对齐
    Right//靠右对齐
};

@interface CountDownButton : UIButton

/**
 初始title,默认“发送验证码”
 */
@property (nonatomic, copy)NSString *startTitle;

/**
 变化时的title,默认“已发送”
 */
@property (nonatomic, copy)NSString *changeTitle;

/**
 字体
 */
@property (nonatomic, strong)UIFont *font;

/**
 对齐方式,默认居中
 */
@property (nonatomic, assign)AlignType alignType;


/**
 构造方法
 */
- (instancetype)initWithDuration:(int)duration buttonClicked:(void(^)())buttonClicked countDown:(void(^)(int time))countDownBlock countDownCompletion:(void(^)())completionBlock;

@end
