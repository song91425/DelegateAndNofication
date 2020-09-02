//
//  DeliveryClickEvent.h
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/21.
//  Copyright © 2020 lssong. All rights reserved.
//



#import <UIKit/UIKit.h>
// 自定义VIew，传递点击事件
@protocol CustomerViewDelegate<NSObject>

@optional
-(void) customerViewDelegateFunc;

@end
NS_ASSUME_NONNULL_BEGIN

@interface DeliveryClickEvent : UIView

// 它也是一个是指针，它要求它指向的类型要实现CustomerViewDelegate protocol
@property(nonatomic, weak) id<CustomerViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
