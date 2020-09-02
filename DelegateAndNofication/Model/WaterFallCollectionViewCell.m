//
//  WaterFallCollectionViewCell.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/28.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"
@interface WaterFallCollectionViewCell()
@property(nonatomic, strong) UIImageView *imageView;

@end
@implementation WaterFallCollectionViewCell

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
    
}

- (void)setImageName:(NSString *)imageName{
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
