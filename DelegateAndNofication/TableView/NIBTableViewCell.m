//
//  NIBTableViewCell.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/2.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "NIBTableViewCell.h"
#import "CellDatas.h"
#import "OptionUICollectionViewController.h"

@interface NIBTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property(weak,nonatomic) UITableView *tableView;
@property(nonatomic, assign) BOOL edit;
@property (weak, nonatomic) IBOutlet UIButton *btnDelegate;
// 使用block完成回调
@property (weak, nonatomic) IBOutlet UIButton *btnBlcok;

@end

@implementation NIBTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setDatas:(CellDatas *) data forView:(UITableView *) tableview{
    self.image.image = [UIImage imageNamed:data.icon];
    self.titleLabel.text = data.title;
    self.titleLabel.adjustsFontSizeToFitWidth = true;
    self.detailLabel.text = data.detail;
    self.detailLabel.adjustsFontSizeToFitWidth =true;
    self.tableView = tableview;
    
    // 为图像添加手势事件
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipOthersView)];
    [_image addGestureRecognizer:tap];
    _image.userInteractionEnabled = true; // 必须设置为true，否则添加手势无效
    
    // 为cell上添加，按钮事件。
    [self.clickButton addTarget:self action:@selector(clickCell) forControlEvents:UIControlEventTouchDown];
    
    // 使用代理完成页面跳转
    [self.btnDelegate addTarget:self action:@selector(skipToViewUseDelegate) forControlEvents:UIControlEventTouchDown];
    
    // 使用block完成代理
    [self.btnBlcok addTarget:self action:@selector(btnForBlock) forControlEvents:UIControlEventTouchDown];
}

// 需要什么就传什么
-(void) skipOthersView{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[OptionUICollectionViewController new]];
    nav.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self.view presentViewController:nav animated:YES completion:nil];
}

-(void) clickCell{
    NSLog(@"点击了, UItableView对象是：%@", self.tableView);
    _edit = self.tableView.editing;
    if(_edit){
        [_tableView setEditing:NO animated:YES];
    }else{
        [_tableView setEditing:YES animated:YES];
    }
    
}

// 使用代理让ViewController来完成动作
-(void) skipToViewUseDelegate{
    
    if ([self.delegate respondsToSelector:@selector(skipToViewController:)]) {
        [self.delegate skipToViewController:0];
    }
}
// 使用block来实现回调
- (void)btnForBlock{
    if (self.btnClick) {
        self.btnClick();
    }
    
}

@end

