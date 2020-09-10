//
//  BViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/4.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "BViewController.h"
#import "CViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [self.view setMultipleTouchEnabled:YES];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self testVC];
     NSLog(@"BViewController --> viewDidLoad");
    // Do any additional setup after loading the view.
}


-(void) testVC{
    //添加测试VC的生命周期
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 300, 50)];
    [btn1 setTitle:@"点击跳转CViewController" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clikToCViewController) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 100, 200, 100)];
    [label setText:@"这是BViewController"];
    [self.view addSubview:label];
    
    //添加返回到AVC的按钮
       UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 300, 50)];
       [btn2 setTitle:@"点击返回BViewController" forState:UIControlStateNormal];
       [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
       [btn2 addTarget:self action:@selector(clikToAViewController) forControlEvents:UIControlEventTouchDown];
       [self.view addSubview:btn2];
    
}


// 跳转
-(void) clikToAViewController{
    [self.navigationController popToViewController:self animated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

// 跳转
-(void) clikToCViewController{
    
    //  push 跳转模式
    [self.navigationController pushViewController:[CViewController new] animated:YES];

    // 没有指定跳转模式，默认不是全屏模式，所以BViewController在当前的可视区域可见，没有被系统销毁
//    [self presentViewController:[CViewController new] animated:YES completion:nil];
}
+ (void)initialize
{
    NSLog(@"BViewController --> initialize");
    
}

- (instancetype)init{
     NSLog(@"BViewController --> init");
    self = [super init];
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"BViewController --> viewWillAppear");
}

- (void)viewWillLayoutSubviews{
    NSLog(@"BViewController --> viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews{
    NSLog(@"BViewController --> viewDidLayoutSubviews");
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"BViewController --> viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"BViewController --> viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"BViewController --> viewDidDisappear");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray * array2 = [touches allObjects];
    UITouch *touch = array2[0];
    NSLog(@"UITouch: %i, %i", touches.count, touch.tapCount);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
