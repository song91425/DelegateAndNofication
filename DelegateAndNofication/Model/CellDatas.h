//
//  CellDatas.h
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/26.
//  Copyright © 2020 lssong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellDatas : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic,copy) NSString *detail;

-(id) initWithDict:(NSDictionary *) dict type:(NSString *) className;
//+(instancetype) datasWithDict:(NSDictionary *) dict;
+(instancetype) datasWithDict:(NSDictionary *) dict type:(NSString *) className;

-(NSArray *)intiDataWithArray:(NSArray *) arr;
+(instancetype) dataWithArray:(NSArray *) arr;
@end

NS_ASSUME_NONNULL_END
