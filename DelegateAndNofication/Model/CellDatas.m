//
//  CellDatas.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/26.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "CellDatas.h"

@implementation CellDatas

-(id) initWithDict:(NSDictionary *)dict type:(NSString *) className{
    self = [super init];
    if([className isEqualToString:@"TableViewViewController"] && self){
        self.detail = dict[@"detail"];
    }
    if (self) {
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
    }
    return self;
}


+(instancetype) datasWithDict:(NSDictionary *) dict type:(nonnull NSString *)className{
    return [[self alloc] initWithDict:dict type:className];
}

-(NSArray *)intiDataWithArray:(NSArray *) arr{
    NSMutableArray *array = [NSMutableArray new];
    if (arr.count>0) {
        for (NSDictionary *dict in arr) {
            CellDatas *model = [CellDatas new];
            model.detail = dict[@"detail"];
            model.title = dict[@"title"];
            model.icon = dict[@"icon"];
            [array addObject:model];
        }
    }
    return array;
}

+(instancetype) dataWithArray:(NSArray *) arr{
    return [[CellDatas new] intiDataWithArray:arr];
}

@end
