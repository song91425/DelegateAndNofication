//
//  LifeCycleViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/4.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "LifeCycleViewController.h"
#import "LifeCycle.h"
#import "BViewController.h"
#import "SandBoxViewController.h"
#import "BundleViewController.h"

@interface LifeCycleViewController ()
@property(strong,nonatomic) LifeCycle *lcView;
@end

@implementation LifeCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testVC];
    NSLog(@"AControllerView --> viewDidLoad");
}

-(void)testUIView{
    _lcView= [LifeCycle new];
    _lcView.frame = CGRectMake(10, 10, 100, 100);
    _lcView.log = @"addSubview-显示过程";
    _lcView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lcView];
    
    // 添加移除lcView按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    [btn setTitle:@"点击销毁View" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}

-(void) testVC{
    //添加测试VC的生命周期
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100,300, 50)];
    [btn1 setTitle:@"点击跳转BViewController" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clikToBViewController) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 100, 200, 100)];
    [label setText:@"这是AViewController"];
    [self.view addSubview:label];
    
}
-(void) removeView{
    NSLog(@"使用removeFromSuperview方法把视图从父视图移走");
    _lcView.log = @"销毁过程";
    [_lcView removeFromSuperview];
    _lcView = nil;
    
}
- (IBAction)readBundle:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BundleLoad" bundle:nil];
    BundleViewController *vc = [story instantiateViewControllerWithIdentifier:@"BundleViewController"];
    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
    
}

// 进入文件沙盒
- (IBAction)clickToSandBox:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"SandBox" bundle:nil];
    SandBoxViewController *vc = [story instantiateViewControllerWithIdentifier:@"SandBoxViewController"];
    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

// 跳转
-(void) clikToBViewController{
    
    BViewController *vc = [BViewController new];
    // 使用push跳转方法
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
//    BViewController *vc =[BViewController new] ;
    nav.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:nav animated:YES completion:nil];
}

+ (void)initialize
{
    NSLog(@"AControllerView --> initialize");
    
}

- (instancetype)init{
     NSLog(@"AControllerView --> init");
    self = [super init];
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"AControllerView --> viewWillAppear");
}

- (void)viewWillLayoutSubviews{
    NSLog(@"AControllerView --> viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews{
    NSLog(@"AControllerView --> viewDidLayoutSubviews");
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"AControllerView --> viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"AControllerView --> viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"AControllerView --> viewDidDisappear");
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
