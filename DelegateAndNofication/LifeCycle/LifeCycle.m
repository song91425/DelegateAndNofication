//
//  LifeCycle.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/9/4.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "LifeCycle.h"

@implementation LifeCycle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)willMoveToSuperview:(UIView *)newSuperview{
    NSLog(@"%@: willMoveToSuperview", self.log);
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    NSLog(@"%@: didMoveToSuperview", self.log);
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    NSLog(@"%@: willMoveToWindow", self.log);
}

-(void) didMoveToWindow{
    [super didMoveToWindow];
    NSLog(@"%@: didMoveToWindow", self.log);
}

- (void)layoutSubviews{
    NSLog(@"%@: layoutSubviews", self.log);
    [super layoutSubviews];
}

-(void)didAddSubview:(UIView *)subview{
    [super didAddSubview:subview];
    NSLog(@"%@: didAddSubview", self.log);
}

- (void)dealloc
{
    NSLog(@"%@: dealloc", self.log);
}
@end
