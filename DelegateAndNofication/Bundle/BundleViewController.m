//
//  BundleViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/11.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "BundleViewController.h"

@interface BundleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainBundle;
@property (weak, nonatomic) IBOutlet UILabel *bundleForClass;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation BundleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

-(void) initData{
    // Bundle 的实例化。
    NSBundle *bundle = [NSBundle mainBundle];
    _mainBundle.text = [NSString stringWithFormat:@"%@", bundle];
     NSObject *bundle1 = [NSBundle bundleForClass:[self class]];
    _bundleForClass.text = [NSString stringWithFormat:@"%@", bundle1];
    
    // 1. 定位到Bundle文件目录
    NSString *bundlePath = [bundle pathForResource:@"resource" ofType:@"bundle"];
    // 2. 根据1.的结果实例化NSBundle,bundle2可以操作在该类下的所以文件.
    NSBundle *bundle2 = [NSBundle bundleWithPath:bundlePath];
    // 3. 根据2.的结果，获取Bundle目录下的资源
    NSString *str = [bundle2 pathForResource:@"imgBundle" ofType:@"png"];
    NSString *str2 = [bundle2 pathForResource:@"Root" ofType:@"plist"];
    
    // bundle 目录下的plist文件
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:str2];
    NSLog(@"dict: %@", dict);
    
    // imageView的image处于一级目录
    _imageView.image = [UIImage imageNamed:str];
    
    // imageView的image处于二级目录
    str2 = [bundle2 pathForResource:@"folder/imgBundle2" ofType:@"png"];
    _imageView2.image = [UIImage imageNamed:str2];

    
    NSLog(@"mainBundle: %@   bundleForClass: %@ ", bundle, bundle1);
    
//    [bundle initWithPath:@"info.plist"];
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
