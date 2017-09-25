//
//  shopCartModel.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/7/17.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartModel : NSObject
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, assign) BOOL selectStatus;
@property (nonatomic, strong) NSMutableArray *productArray;

/**
 邮费
 */
@property (nonatomic, assign) CGFloat Postage;

/**
 每个商家的所有费用
 */
@property (nonatomic, assign) CGFloat allCost;

/**
 是否已经下架
 */
@property (nonatomic, assign) BOOL soldOut;
@end

@interface ShopCartProductModel : NSObject
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) NSInteger productCount;
@property (nonatomic, strong) NSString *productPriceLate;
@property (nonatomic, strong) NSString *productPriceNow;
@property (nonatomic, strong) NSString *productSize;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) NSInteger shopCartId;
@property (nonatomic, strong) NSString *leaveStr;

/**
 是否已经下架
 */
@property (nonatomic, assign) BOOL soldOut;
@property (nonatomic, assign) BOOL selectStatus;
@end
