//
//  WaterLayoutViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/27.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "WaterLayoutViewController.h"
#import "DDCollectionViewFlowLayout.h"
#import "WaterFallCollectionViewCell.h"
#import "WaterFallCollectionViewCell.h"
#import "OptionUICollectionViewController.h"

#define CELLID @"cell"

@interface WaterLayoutViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, DDCollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WaterLayoutViewController{
    NSMutableArray *dataList;
    NSMutableArray *sectionOne;
    // 存储所有高度的数组
    NSMutableArray *heightArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self initView];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"**************8");
    [self.navigationController pushViewController:[OptionUICollectionViewController new] animated:YES];
    
}

-(void) initData{
    if(!dataList)
        dataList = [[NSMutableArray alloc] initWithCapacity:0];
    [dataList removeAllObjects];
    
    if (!heightArr) {
        heightArr =  [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    [heightArr removeAllObjects];
    for (int i=0; i<32; i++) {
        [dataList addObject:[NSString stringWithFormat:@"%i.png" , i ]];
        CGFloat height = 100 + (arc4random() %100);
        [heightArr addObject: [NSString stringWithFormat:@"%f", height]];
    }
}

-(void) initView{
    DDCollectionViewFlowLayout *layout = [[DDCollectionViewFlowLayout alloc] init];
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height -60) collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:collectionView];
    
    _collectionView = collectionView;
    [self.collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(DDCollectionViewFlowLayout *)layout numberOfColumnsInSection:(NSInteger)section{
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    cell.imageName = dataList[indexPath.row];
    
    return  cell;
}

#pragma mark -UICollectionView Delegate Methods
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.item == 1){
        return CGSizeMake(100, 200);
    }else{
        CGFloat height = [[heightArr objectAtIndex:indexPath.row] floatValue];
        return CGSizeMake(100, height);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", indexPath);
}
@end
