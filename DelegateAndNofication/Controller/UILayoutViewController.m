//
//  UILayoutViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/24.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "UILayoutViewController.h"

@interface UILayoutViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *buleColor;
@property (weak, nonatomic) IBOutlet UIView *greenColor;
@property (weak, nonatomic) IBOutlet UIScrollView *optiScrollView;
@end

@implementation UILayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"11111");
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createScrollViewAndImageVIew];
    // 开启线程判断是否轮换
    [self openNewRunloop];
}

///  把子视图跳到前面来
-(void) initView{
    // 把横条带到前面显示
    [self.backgroundScrollView bringSubviewToFront:self.buleColor];
    [self.backgroundScrollView bringSubviewToFront:self.greenColor];
    
    // 设置背景scrollView的大小
    // 设置ScrollView的高度
    CGFloat scrollH = self.optiScrollView.frame.origin.y + self.optiScrollView.frame.size.height + 50;
    
    CGSize size = CGSizeMake(self.view.frame.size.width, scrollH);
    self.backgroundScrollView.contentSize=size;
    
    
}

- (void)viewDidLayoutSubviews{
    NSLog(@"33333");
    
}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"222222");
    [self initView];
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    // 判断是哪个ScrollView
    NSInteger tag = scrollView.tag;
    if(tag == 10){
        // 获取ScrollView的偏移
        CGFloat offsetX= scrollView.contentOffset.x;
        // 计算pageControl的当前页，用取模，(self.scrollView.frame.size.width * 0.5)滑到一半就改变当前页
        int page = (offsetX + (self.scrollView.frame.size.width * 0.5)) / self.scrollView.frame.size.width ;
        self.pageControl.currentPage = page;
    }else if(tag == 11){
        NSLog(@"优化ScrollView");
    }else{
        NSLog(@"背景ScrollView");
    }
    
    
}

// 即将拖拽ScrollView，停止计时器，通过一个开关来完成
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}
// 拖拽完毕，开启新计时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(autoScrolleView) userInfo:nil repeats:YES];
}
///  创建ScrollVIew和ImageVIew
-(void) createScrollViewAndImageVIew{
    
    CGFloat imgW = 600;
    CGFloat imgH = 350;
    CGFloat imaY = 0;
    CGFloat scrollViewW = 0;
    // 动态创建UIImageVIew
    for (int i=1; i<4; i++) {
        // 创建 UIImageView，用来显示图片
        UIImageView *image = [[UIImageView alloc] init];
        
        NSString *imageName = [NSString stringWithFormat:@"img%d", i ];
        image.image =[UIImage imageNamed:imageName];
        
        // 计算每个图片的坐标
        CGFloat imgX = (i-1) * imgW;
        
        // 设置imageView的frame
        image.frame = CGRectMake(imgX, imaY, imgW, imgH);
        scrollViewW += imgX;
        [self.scrollView addSubview:image];
    }
    
    // 动态创建UIImageVIew
    for (int i=1; i<4; i++) {
        // 创建 UIImageView，用来显示图片
        UIImageView *image = [[UIImageView alloc] init];
        
        NSString *imageName = [NSString stringWithFormat:@"img%d", i ];
        image.image =[UIImage imageNamed:imageName];
        
        // 计算每个图片的坐标
        CGFloat imgX = (i-1) * imgW;
        
        // 设置imageView的frame
        image.frame = CGRectMake(imgX, imaY, imgW, imgH);
        scrollViewW += imgX;
        [self.optiScrollView addSubview:image];
    }
    
    // 设计ScrollView的大小才能显示
    CGFloat maxW = self.scrollView.frame.size.width*3;
    
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    
    CGFloat optiW = self.optiScrollView.frame.size.width*3;
    self.optiScrollView.contentSize = CGSizeMake(optiW, 0);
    
    // 实现分页效果,是按照scrollView自身的大小自动分页 CGFloat maxW就是自身大小*3就是分三页
    self.scrollView.pagingEnabled = YES;
    
    // 隐藏水平滚动器
    self.scrollView.showsHorizontalScrollIndicator= NO;
    
    // 添加当前页指示器
    [self.backgroundScrollView bringSubviewToFront:self.pageControl];
    
    // 告诉pageControl共有多少页
    self.pageControl.numberOfPages = 3;
    // 设置pageControl当前页
    self.pageControl.currentPage=0;
    
    // 实现分页效果,是按照scrollView自身的大小自动分页 CGFloat maxW就是自身大小*3就是分三页
    self.optiScrollView.pagingEnabled = YES;
    
    // 隐藏水平滚动器
    self.optiScrollView.showsHorizontalScrollIndicator= NO;

    // 创建定时器实现轮播效果,用来取消该定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(autoScrolleView) userInfo:nil repeats:YES];
    
    
}


-(void) autoScrolleView{
    // 获取轮播图片的当前页
    NSInteger page = self.pageControl.currentPage;
    if(page == self.pageControl.numberOfPages-1){
        page = 0;
    }else{
        page++;
    }
    self.pageControl.currentPage = page;
    
    // 设置图片改变
    CGFloat offsetX = self.scrollView.frame.size.width * page;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    //问题： 如果手一直拖住图片，则需要停止计时器，不然ScrollView会滚动很快，可以在ScrollView代理，那里优化
    NSLog(@"定时器开始了");
    
}

-(void) openNewRunloop{
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(printLogForMainThread) userInfo:nil repeats:YES];
}

-(void) printLogForMainThread{
    NSLog(@"RunLoop轮换");
}

@end
