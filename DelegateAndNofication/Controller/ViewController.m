//
//  ViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/21.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "DeliveryClickEvent.h"
#import "UILayoutViewController.h"
#import "OptionUIImageViewController.h"
#import "OptionUICollectionViewController.h"
#import "WaterLayoutViewController.h"
#import "SWRevealViewController.h"
/// ViewController 需要实现SecondViewControllerDelegate协议，说明ViewController是代理对象，SecondViewControllerDelegate是被代理的。在SecondViewControllerDelegate中产生的事件交给代理来处理，也就是由ViewController响应。
@interface ViewController ()<SecondViewControllerDelegate,CustomerViewDelegate>
//创建一个Label显示下一界面传过来的值
@property (weak, nonatomic) IBOutlet UILabel *lb_showStr;

@property (nonatomic, strong) DeliveryClickEvent *myView; // 自定义view传递事件
// UI 布局练习
@property (weak, nonatomic) IBOutlet UIButton *ui_layout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一个控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    // 使用Delegate实现自己代理视图点击事件传递
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
//    [self customerMyView];
    [self testNotification];
    
    
}

// 点击进入瀑布流
- (IBAction)clickToWaterFall:(UIButton *)sender {
    WaterLayoutViewController *waterFall = [WaterLayoutViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:waterFall];
    nav.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)clickToUICollection:(UIButton *)sender {
    // 加载SB布局，bundle为nil，默认从主路径找
    UIStoryboard *story= [UIStoryboard storyboardWithName:@"OptiUICollection" bundle:nil];
    
    // 加载SB绑定的Controller，通过绑定的SB ID来查找
    OptionUICollectionViewController *ui = [story instantiateViewControllerWithIdentifier:@"OptionUICollectionViewController"];

    // ios 13 后需要指定启动模式
    ui.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    // 具体的跳转
    [self presentViewController:ui animated:YES completion:nil];
    
}

-(void) testNotification{
    // 注册通知, 如果指定object，那么post的时候也要指定，否则就接收不到通知，如指定@"lss"，
    // 则在postNotificationName的时候也需要指定，否则接收不到这条通知。
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(callBackForNotification:) name:@"com.lss.Notification" object:@"lss"];
    
    NSNotification * notice = [NSNotification notificationWithName:@"com.lss.Notification" object:@"lss" userInfo:@{@"data":@"lss",@"user":@"lssong"}];
    [NSNotificationCenter.defaultCenter postNotification:notice];
    

}

/// 继承UIVIew，并使用代理来回调点击事件
-(void) customerMyView{
    DeliveryClickEvent *myView = [[DeliveryClickEvent alloc]init];
    myView.delegate = self;
    self.myView = myView;
    myView.backgroundColor = [UIColor redColor];
    myView.frame = CGRectMake(100,500, 100, 100);
    myView.userInteractionEnabled = YES;
    [self.view addSubview:self.myView];
}

// 通知回调函数
-(void) callBackForNotification:(NSNotification *) notification{
    NSDictionary *dic = notification.userInfo;
    NSLog(@"%@", dic);
    NSLog(@"通知调用%@", notification.object );
}

- (void)customerViewDelegateFunc{
    NSLog(@"myViewDelegate的代理 点击view");
}
- (void)updateTextField:(NSString *)text{
    self.lb_showStr.text = text;
}


/// 进入新页面，并开始新布局
/// @param sender 事件类型
- (IBAction)clickForUILayout:(UIButton *)sender {
    // 加载SB布局，bundle为nil，默认从主路径找
    UIStoryboard *story= [UIStoryboard storyboardWithName:@"UILayout" bundle:nil];
    
    // 加载SB绑定的Controller，通过绑定的SB ID来查找
    UILayoutViewController *ui = [story instantiateViewControllerWithIdentifier:@"UILayoutViewController"];

    // ios 13 后需要指定启动模式
    ui.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    // 具体的跳转
    [self presentViewController:ui animated:YES completion:nil];
    
}

- (IBAction)clickToScrollViewToShowImage:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"OptiScrollView" bundle:nil];
    
    OptionUIImageViewController *vc = [story instantiateViewControllerWithIdentifier:@"OptionUIImageViewController"];
    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)clickPushBtn:(UIButton *)sender {
    SecondViewController *nextVc = [[SecondViewController alloc]init];
    nextVc.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:nextVc animated:YES completion:nil];
    
    // 本类是SecondViewController的代理，所以在SecondViewController调用代理方法由ViewController来执行
    nextVc.delegate = self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
