//
//  ShopCartCell.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/7/17.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopCartModel.h"

@protocol ShopCartCellDelegate <NSObject>

@optional
- (void)selectProductActionWithIndex:(NSIndexPath *)indexPath selectFlag:(BOOL)selectFlag;
- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)deleteProductActionWithIndex:(NSIndexPath *)indexPath;
@end


static NSString * const ShopCartCells = @"ShopCartCell";

@interface ShopCartCell : UITableViewCell

@property (assign ,nonatomic) id<ShopCartCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (nonatomic,strong) ShopCartProductModel *model;

@end
