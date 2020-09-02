//
//  DeliveryClickEvent.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/21.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "DeliveryClickEvent.h"

@implementation DeliveryClickEvent

//点击view，响应代理方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if ([_delegate respondsToSelector:@selector(customerViewDelegateFunc)]) {
        [_delegate customerViewDelegateFunc];
    }
}

@end
