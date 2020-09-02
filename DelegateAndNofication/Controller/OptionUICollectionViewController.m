//
//  OptionUICollectionViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/26.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "OptionUICollectionViewController.h"
#import "CellDatas.h"
#import "CollectionViewCell.h"
#import "NIBCollectionViewCell.h"

#define CELLID @"cell"
#define CELLMAXSECTION 100

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@interface OptionUICollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation OptionUICollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}


-(NSArray *) datas{
    // 懒加载数据
    if (_datas == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"resource.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _datas = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            // 字典转模型，_datas里存放的是模型
            [_datas addObject:[CellDatas datasWithDict:dict type:@"OptionUICollectionViewController"]];
        }
    }
    return  _datas;
}

-(void) initView{
    
    // 初始化流布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 流布局的item大小
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width,  200);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing=0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,60, self.view.frame.size.width, 200) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled =true;
    collectionView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:collectionView];
    
    _collectionView = collectionView;
    
    // 注册cell，即每个item的样式
//        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CELLID];
    
    // 使用自定义的nib文件布局
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionView" bundle:nil] forCellWithReuseIdentifier:CELLID];
    
    // 指定CollectionView的滚动位置和，滚动结束的滚动条所放的位置，，
    // 注意这里会把cell绘制出来，这样才会使下面的方法生效，否则不生效
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection: 0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
    
    UIPageControl *pageCotrol = [[UIPageControl alloc] init];
    pageCotrol.center = CGPointMake(SCREEN_WIDTH*0.5, 200);
    pageCotrol.bounds = CGRectMake(0, 0, 150, 40);
    pageCotrol.pageIndicatorTintColor= [UIColor blueColor];
    pageCotrol.currentPageIndicatorTintColor= [UIColor redColor];
    pageCotrol.enabled = NO;
    pageCotrol.numberOfPages = _datas.count;
    
    [self.view addSubview:pageCotrol];
    _pageControl = pageCotrol;
    
    [self addTimer:@"originClass"];
    
}

// 设置定时器
-(void) addTimer:(NSString *) type{
    NSTimer *timer;
    if ([type isEqualToString:@"nib"]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPageForNIB) userInfo:nil repeats:YES];
    }else{
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    }
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
}

//移除定时器
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

// 自定义nib实现
-(void)nextPageForNIB{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if(nextItem == self.datas.count){
        nextItem = 0;
        nextSection=0;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

// 使用原始类的cell
-(void) nextPage{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if(nextItem == self.datas.count){
        nextItem = 0;
        nextSection=0;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//  static int count = 0;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // self.datas会调用重写的datas方法。
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 下面这个会调用初始化的CollectionViewCell，调用该类重写的UIView的initWithFram方法
//    CollectionViewCell *cell = [self originClassCell:collectionView cellForItemAtIndexPath:indexPath];
    
    NIBCollectionViewCell *cell = [self customerCellUseNIB:collectionView cellForItemAtIndexPath:indexPath];
    return cell;
}

-(NIBCollectionViewCell *) customerCellUseNIB:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 下面这个会调用初始化的CollectionViewCell，调用该类重写的UIView的initWithFram方法
    NIBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    NSLog(@"indexPath.item: %d,, section: %d", indexPath.item,indexPath.section);
    
    // CollectionViewCell重写initWithFram方法，所以cell不会为空，该if语句是不会执行
    if(!cell){
        cell = [NIBCollectionViewCell new];
    }
    
    // 赋值操作，给cell初始化
    cell.datas = self.datas[indexPath.item];
    NSLog(@"%@", cell.datas.title);
    return cell;
}

-(CollectionViewCell *) originClassCell:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 下面这个会调用初始化的CollectionViewCell，调用该类重写的UIView的initWithFram方法
     CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
     NSLog(@"indexPath.item: %d,, section: %d", indexPath.item,indexPath.section);
     
     // CollectionViewCell重写initWithFram方法，所以cell不会为空，该if语句是不会执行
     if(!cell){
         cell = [CollectionViewCell new];
     }
     
     // 赋值操作，给cell初始化
     cell.datas = self.datas[indexPath.item];
     NSLog(@"%@", cell.datas.title);
    return cell;
}
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int) (scrollView.contentOffset.x / scrollView.frame.size.width + 0.5)%self.datas.count;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
