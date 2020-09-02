//
//  NIBTableViewCell.h
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/2.
//  Copyright © 2020 lssong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellDatas;
NS_ASSUME_NONNULL_BEGIN
///  使用代理，不需要传ViewController到TableCell里
@protocol SkipControllerDelegate <NSObject>
/// 使用代理完成跳转
/// @param tag  留用区分cell上的控件
-(void) skipToViewController:(NSInteger ) tag;

@end


@interface NIBTableViewCell : UITableViewCell

@property(weak, nonatomic) id<SkipControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *clickButton;
-(void) setDatas:(CellDatas *) data forView:(UITableView *) tableview;
// 维护一个Navigation对象来达到跳转
@property(weak,nonatomic) UIViewController *view;

// 使用block完成回调
@property(strong,nonatomic)  void (^btnClick)(void);

@end

NS_ASSUME_NONNULL_END
