//
//  CViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/4.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testVC];
     NSLog(@"CViewController --> viewDidLoad");
    // Do any additional setup after loading the view.
}


-(void) testVC{
    //添加测试VC的生命周期
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 300, 50)];
    [btn1 setTitle:@"这是CViewController\n点击返回BViewController" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clikToBViewController) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 100, 200, 100)];
    [label setText:@"这是BViewController"];
    [self.view addSubview:label];
}

// 跳转
-(void) clikToBViewController{
    [self.navigationController popToViewController:self animated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
+ (void)initialize
{
    NSLog(@"CViewController --> initialize");
    
}

- (instancetype)init{
    NSLog(@"CViewController --> init");
    self = [super init];
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"CViewController --> viewWillAppear");
}

- (void)viewWillLayoutSubviews{
    NSLog(@"CViewController --> viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews{
    NSLog(@"CViewController --> viewDidLayoutSubviews");
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"CViewController --> viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"CViewController --> viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"CViewController --> viewDidDisappear");
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
