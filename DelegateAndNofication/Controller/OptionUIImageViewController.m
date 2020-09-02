//
//  OptionUIImageViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/25.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "OptionUIImageViewController.h"
#import "SWRevealViewController.h"
@interface OptionUIImageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *showImageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,assign) int numberOfImages;
@property(weak,nonatomic) UIImageView *firstImageView;
@property(weak,nonatomic) UIImageView *secondImageView;
@property(weak, nonatomic) UIImageView *thridImageView;
@property(strong,nonatomic) NSMutableArray<NSString *> *image;
@end

@implementation OptionUIImageViewController
static int count;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    [self intiView];
    // Do any additional setup after loading the view.
}

///  初始化视图
-(void) intiView{
    self.image = [NSMutableArray new];
    [self.image addObjectsFromArray:@[@"img1", @"img2",@"img3",@"img4",@"img5",@"img6",@"img7"]];

    // 创建3个ImageView
    UIImageView *imageView  = [UIImageView new];
    imageView.image =  [UIImage imageNamed:self.image[0]];
    imageView.frame = CGRectMake(0, 0, 414, 300);
    self.firstImageView = imageView;
    [self.showImageScrollView addSubview:imageView];
    
    imageView  = [UIImageView new];
    imageView.image =  [UIImage imageNamed:self.image[1]];
    CGFloat  imgW = self.showImageScrollView.frame.size.width;
    imageView.frame = CGRectMake(imgW, 0, 414, 300);
    self.secondImageView = imageView;
    [self.showImageScrollView addSubview:imageView];
    
    imageView  = [UIImageView new];
    imageView.image =  [UIImage imageNamed:self.image[2]];
    imgW = 2*self.showImageScrollView.frame.size.width;
    imageView.frame = CGRectMake(imgW, 0, 414, 300);
    self.thridImageView = imageView;
    [self.showImageScrollView addSubview:imageView];
    
    CGFloat scrollW = self.showImageScrollView.frame.size.width * 3;
    self.showImageScrollView.contentSize = CGSizeMake(scrollW, 0);
    self.showImageScrollView.pagingEnabled = YES;
    self.showImageScrollView.contentOffset =CGPointMake(self.showImageScrollView.frame.size.width, 0) ;
    self.showImageScrollView.showsHorizontalScrollIndicator=NO;
    self.showImageScrollView.bouncesZoom=NO;
    // 设置图片显示器
    self.pageControl.numberOfPages = self.image.count-1;
    self.pageControl.currentPage = 1;
    
}

// 开始拖动的时候改变
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"111111");
   
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
//     CGFloat offsetX = scrollView.contentOffset.x;
//    NSLog(@"滚动中结束");
}

// 结束拖动更新，三个UIImageView的具体值视图
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetX = scrollView.contentOffset.x;
     
     NSLog(@"结束拖动%f",offsetX);
     if(offsetX >= (self.showImageScrollView.frame.size.width *2)){
            count ++;
            NSString * str = self.image[0];
            // 移到第三张改变UIImage的实例化
            [self.image removeObjectAtIndex:0];
            [self.image addObject:str];
            _firstImageView.image = [UIImage imageNamed:self.image[0]];
            _secondImageView.image=[UIImage imageNamed:self.image[1]];
            _thridImageView.image=[UIImage imageNamed:self.image[2]];
    //        [self.showImageScrollView setContentOffset:CGPointMake(self.showImageScrollView.contentSize.width, 0) animated:NO];
            NSLog(@"第三张%f", offsetX);
        }else if(offsetX >= self.showImageScrollView.frame.size.width){
            NSLog(@"第二张%f", offsetX);
        }else{
            // 移到第三张改变UIImage的实例化
            NSString * str = self.image[_image.count-1];
            // 移到第三张改变UIImage的实例化
            [self.image removeObjectAtIndex:_image.count-1];
            [self.image insertObject:str atIndex:0];
             NSLog(@"第一张%f", offsetX);
            _firstImageView.image = [UIImage imageNamed:self.image[0]];
            _secondImageView.image=[UIImage imageNamed:self.image[1]];
            _thridImageView.image=[UIImage imageNamed:self.image[2]];

        }
    
   [self.showImageScrollView setContentOffset:CGPointMake(self.showImageScrollView.frame.size.width, 0) animated:NO];
   [self.showImageScrollView layoutIfNeeded];
   
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"第一张scrollViewDidZoom");
    
}
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView{
    NSLog(@"第一张scrollViewDidChangeAdjustedContentInset");
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
