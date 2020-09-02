//
//  Second.h
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/21.
//  Copyright © 2020 lssong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SecondViewControllerDelegate <NSObject>
@required
-(void) updateTextField:(NSString *_Nullable) text;

@end
NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController
@property(nonatomic, weak) id<SecondViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
