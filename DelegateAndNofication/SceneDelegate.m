//
//  SceneDelegate.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/21.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "SceneDelegate.h"
#import "SidesloppingViewController.h"
#import "ViewController.h"
#import "SWRevealViewController.h"
#import "OptionUIImageViewController.h"
#import "TableBarViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    NSLog(@"+++++++++++++scene:willConnectToSession:options:++++++++++++");
    
    if(@available(iOS 13.0, *)){
        // Override point for customization after application launch.
        //左侧菜单栏
        SidesloppingViewController *sidesloppingViewController = [[SidesloppingViewController alloc] init];
        //首页
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController  *centerView1Controller = [story instantiateViewControllerWithIdentifier:@"ViewController"];
        // ios 13 后需要指定启动模式
        centerView1Controller.modalPresentationStyle = UIModalPresentationCurrentContext;
//       ViewController *centerView1Controller = [[ViewController alloc] init];
        //右侧菜单栏
        //    RightViewController *rightViewController = [[RightViewController alloc] init];
        
        SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:sidesloppingViewController frontViewController:centerView1Controller];
        //    revealViewController.rightViewController = rightViewController;
        
        //浮动层离左边距的宽度
        revealViewController.rearViewRevealWidth = 230;
        //    revealViewController.rightViewRevealWidth = 230;
        
        //是否让浮动层弹回原位
        //mainRevealController.bounceBackOnOverdraw = NO;
        [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        
        
        UIWindowScene *windowScene = (UIWindowScene *)scene;
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // window的初始化不一样
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        [self.window setWindowScene:windowScene];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        
        UIStoryboard *storyHome = [UIStoryboard storyboardWithName:@"TableBar" bundle:nil];
        
        TableBarViewController *tableBar = [storyHome instantiateViewControllerWithIdentifier:@"TableBarViewController"];
        UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:tableBar];
        [self.window setRootViewController:vc];
        [self.window makeKeyAndVisible];
        
    }
 
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    NSLog(@"+++++++++++++sceneDidDisconnect:++++++++++++");
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"+++++++++++++sceneDidBecomeActive:++++++++++++");
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    NSLog(@"+++++++++++++sceneWillResignActive:++++++++++++");
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    NSLog(@"+++++++++++++sceneWillEnterForeground:++++++++++++");
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"+++++++++++++sceneDidEnterBackground:++++++++++++");
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}
- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts{
    NSLog(@"+++++++++++++scene:openURLContexts:++++++++++++");

}

@end
