//
//  SandBoxViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/9.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "SandBoxViewController.h"

@interface SandBoxViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UILabel *home;

@property (weak, nonatomic) IBOutlet UILabel *documents;
@property (weak, nonatomic) IBOutlet UILabel *library;
@property (weak, nonatomic) IBOutlet UILabel *tmp;
@property (weak, nonatomic) IBOutlet UILabel *caches;
@property (weak, nonatomic) IBOutlet UILabel *preferences;

@end

@implementation SandBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _scrollerView.showsHorizontalScrollIndicator = false;
   
    _home.text =  [NSString stringWithFormat:@"Home path: %@", NSHomeDirectory()];
    NSLog(@"Home path: %@", NSHomeDirectory());
    // NSLocalDomainMask mac本地路径  /Library/Documentation
    // NSUserDomainMask app对应的文件路径
    // app对应的Documents路径
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, false);
    NSLog(@"Documents路径： %@", [array lastObject]);
    _documents.text =  [NSString stringWithFormat:@"Documents路径： %@", [array lastObject]];
    
    // 获取Library 路径
    array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, false);
    NSLog(@"Library路径： %@", [array lastObject]);
    _library.text = [NSString stringWithFormat:@"Library路径： %@", [array lastObject]];
    
    // 获取tmp 路径
    NSString *path = NSTemporaryDirectory();
    NSLog(@"tmp路径： %@",path);
     _tmp.text =  [NSString stringWithFormat:@"tmp路径: %@", path];
    
    // 获取Preferences 路径
    array = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, false);
    NSLog(@"Preferences路径： %@", [array lastObject]);
      _preferences.text =  [NSString stringWithFormat:@"Preferences路径: %@", [array lastObject]];
    
    
    // 获取Caches 路径
     array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, false);
     NSLog(@"Caches路径： %@", [array lastObject]);
      _caches.text =  [NSString stringWithFormat:@"Caches路径: %@", [array lastObject]];
    
    self.scrollerView.contentSize = CGSizeMake(self.view.frame.size.width,  _preferences.frame.origin.y + _preferences.frame.size.height + 10);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollerView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height*2);
    NSLog(@"高度： %d", self.scrollerView.contentSize.height);
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
