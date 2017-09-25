//
//  WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/8/10.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopCartModel.h"

@interface WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)ShopCartProductModel *model;
@end
