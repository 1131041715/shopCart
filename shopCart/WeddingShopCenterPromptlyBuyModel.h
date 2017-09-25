//
//  WeddingShopCenterPromptlyBuyModel.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/9/12.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeddingShopCenterPromptlyOrginalDicData,WeddingShopCenterPromptlyDicDataShopArayList,WeddingShopCenterPromptlyGoodsArayList;
@interface WeddingShopCenterPromptlyBuyModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) WeddingShopCenterPromptlyOrginalDicData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface WeddingShopCenterPromptlyOrginalDicData : NSObject

@property (nonatomic, strong) NSArray<WeddingShopCenterPromptlyDicDataShopArayList *> *preFleet;

@end

@interface WeddingShopCenterPromptlyDicDataShopArayList : NSObject

@property (nonatomic, copy) NSString *shopid;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, strong) NSArray<WeddingShopCenterPromptlyGoodsArayList *> *shop;

@end

@interface WeddingShopCenterPromptlyGoodsArayList : NSObject

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) CGFloat market;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSDictionary *attr;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) CGFloat money;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *freight;

@end
