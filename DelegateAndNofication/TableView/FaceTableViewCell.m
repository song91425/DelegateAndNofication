//
//  FaceTableViewCell.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/31.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "FaceTableViewCell.h"
#import "CellDatas.h"
@implementation FaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:YES];
    NSLog(@"选中item");
    // Configure the view for the selected state
}

- (void)setDatas:(CellDatas *)datas{
    _datas = datas;
    self.imageView.image =[UIImage imageNamed: datas.icon];
    self.textLabel.text = datas.title;
    self.detailTextLabel.text = datas.detail;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 10)];
//    view.backgroundColor =[UIColor whiteColor];
//    [self.contentView addSubview:view];
//    self.contentView.backgroundColor= ;

}

//- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 10;
//    frame.origin.y += 20;
//    frame.size.height -= 10;
//   frame.size.width -= 20;
//    [super setFrame:frame];
//}


@end
