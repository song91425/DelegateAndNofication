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
@property(assign, nonatomic) BOOL writeInEnd;
@end

@implementation SandBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _writeInEnd =true;
    });
    [self initData];
    [self writeFile];
    [self writeFileInEnd];
    [self readFile];
}

- (void) initData{
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

// 写文库到plist文件
- (void) writeFile{
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [homePath  stringByAppendingPathComponent:@"obj.plist"];
    
    NSArray *array = @[@(1),@(2),@(3),@(4),@"jieshu5",@{@"key":@"3434",@"lssong":@"song"}];
    // 把array写入plist文件
    if([array writeToFile:filePath atomically:YES]){
        NSLog(@"Write to file success");
    }else{
        NSLog(@"Write to file fail");
    }
    
}


/// 追加内容到
-(void) writeFileInEnd{
    NSFileManager *manager = [NSFileManager defaultManager] ;
    
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [homePath  stringByAppendingPathComponent:@"obj1.txt"];
    // 判断文件是否在给定的路径存在，若不存在则按照给定的路径创建文件
    if (![manager fileExistsAtPath:filePath]) {
        [manager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    // 把文件写入末尾
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:filePath];
    // 把文件定位到文件末尾
    [file seekToEndOfFile];
    NSString *content = @"7891011";
    // 写入文件
    [file writeData:[NSData dataWithData:[content dataUsingEncoding:NSUTF8StringEncoding]]];
    
}
-(void)readFile{
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [homePath stringByAppendingPathComponent:@"obj.plist"];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@",array);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollerView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height*2);
    NSLog(@"高度： %d", self.scrollerView.contentSize.height);
}
@end
