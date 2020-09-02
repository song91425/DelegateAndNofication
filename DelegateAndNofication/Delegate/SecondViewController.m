//
//  Second.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/21.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
//创建一个TextField输入要传端值
@property (nonatomic, strong) UITextField *tf_sendValue;
//创建返回上一控制器的按钮
@property (nonatomic, strong) UIButton *btn_backVc;

// 创建发送广播的button
@property(nonatomic, strong) UIButton *btn_Notification;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加TextField
    UITextField * tf = [[UITextField alloc] init];
    tf.frame = CGRectMake(30, 100, self.view.frame.size.width, 30);
    tf.textAlignment = 1;
    tf.placeholder=@"请输入要传入的值";
    self.tf_sendValue = tf;
    [self.view addSubview: _tf_sendValue];
    
    // 添加返回上一控制器的按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(200, 200, 150, 35);
    [btn setTitle:@"返回上一控制器" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.center = self.view.center;
    self.btn_backVc = btn;
    [self.view addSubview:btn];
    //添加点击事件
    [self.btn_backVc addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton *btnNotification = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 30)];
    [btnNotification setBackgroundColor:[UIColor blueColor]];
    [btnNotification setTitle:@"发送通知到ViewController页面" forState:UIControlStateNormal];
    
    self.btn_Notification = btnNotification;
    [self.view addSubview:btnNotification];
    
    [self.btn_Notification addTarget:self action:@selector(clickToSendNotification) forControlEvents:UIControlEventTouchDown];
    
    
}

// 发送广播按钮
-(void) clickToSendNotification{
    [NSNotificationCenter.defaultCenter postNotificationName:@"com.lss.Notification" object:@"lss" userInfo:@{@"data":@"SecondViewController", @"user":@(100)}];
}

- (void)clickBackBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *str = self.tf_sendValue.text;
    if (str.length>0) {
        if ([self.delegate respondsToSelector:@selector(updateTextField:)]) {
            [self.delegate updateTextField:str];
        }
    };
    
}

@end
