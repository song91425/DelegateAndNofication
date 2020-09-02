//
//  NIBCollectionViewCell.h
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/27.
//  Copyright © 2020 lssong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellDatas;
NS_ASSUME_NONNULL_BEGIN

@interface NIBCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) CellDatas *datas;
@end

NS_ASSUME_NONNULL_END
