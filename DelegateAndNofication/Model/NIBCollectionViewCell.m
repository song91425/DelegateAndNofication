//
//  NIBCollectionViewCell.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/27.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "NIBCollectionViewCell.h"
#import "CellDatas.h"

@interface NIBCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation NIBCollectionViewCell

-(void) setDatas:(CellDatas *)datas{
    _datas = datas;
    NSLog(@"nibdaxia %f",self.frame.size.width);
    [self setBackgroundColor:[UIColor grayColor]];
    // 赋值操作
    self.title.text = _datas.title;
    self.title.adjustsFontSizeToFitWidth = YES;
    self.image.image = [UIImage imageNamed:_datas.icon];
    self.image.backgroundColor = [UIColor greenColor];
    // 设置图片充填
    self.image.contentMode = UIViewContentModeScaleToFill;
}

@end
