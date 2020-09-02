//
//  CollectionCellCollectionViewCell.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/26.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CellDatas.h"
@interface CollectionViewCell()
@property(weak, nonatomic) UILabel *label;
@property(weak, nonatomic) UIImageView *imamgeView;
@end
@implementation CollectionViewCell

// 重写父类方法，在初始化CollectionViewCell时候，会先调用此方法。initWithFrame是UIView里的方法，在此把视图创建好，并添加进来
-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc] init];
        self.imamgeView = img;
        [self.contentView addSubview:img];
        
        UILabel *lab = [[UILabel alloc] init];
        [self.contentView addSubview:lab];
        self.label = lab;
    }

    return self;
}

-(void) setDatas:(CellDatas *)datas{
    _datas = datas;
    
    [self settingData];
    [self settingFrame];
    
    
}

// 给子控件赋值
-(void) settingData{
    self.imamgeView.image = [UIImage imageNamed:_datas.icon];
    self.label.text = _datas.title;
}

// 设置子控件的Fram
-(void) settingFrame{
    CGFloat screenWidth = self.contentView.frame.size.width;
    self.imamgeView.frame = CGRectMake(0, 0, screenWidth, 200);
    self.label.frame = CGRectMake(0, 0, screenWidth, 200);
    _label.font = [UIFont systemFontOfSize:30];
    _label.textAlignment = NSTextAlignmentCenter;
}
@end
