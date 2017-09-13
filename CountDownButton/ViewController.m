//
//  ViewController.m
//  CountDownButton
//
//  Created by 徐翔 on 2017/9/12.
//  Copyright © 2017年 XuXiang. All rights reserved.
//

#import "ViewController.h"
#import "CountDownButton.h"



@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CountDownButton *btn = [[CountDownButton alloc] initWithDuration:20 buttonClicked:^{
        NSLog(@"开始");
    } countDowning:^(int time) {
        NSLog(@"%d",time);
    } countDownCompletion:^{
        NSLog(@"完成");
    }];
    btn.frame = CGRectMake(50, 50, 200, 50);
    btn.backgroundColor = [UIColor greenColor];
    btn.startTitle = @"点击发送";
    btn.changeTitle = @"验证码已发送";
    btn.alignType = Right;
    btn.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:btn];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
