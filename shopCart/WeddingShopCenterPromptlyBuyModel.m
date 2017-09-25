//
//  WeddingShopCenterPromptlyBuyModel.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/9/12.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WeddingShopCenterPromptlyBuyModel.h"

//@implementation WeddingShopCenterPromptlyBuyModel
//
//@end
@implementation WeddingShopCenterPromptlyBuyModel

@end
@implementation WeddingShopCenterPromptlyOrginalDicData

+ (NSDictionary *)objectClassInArray{
    return @{@"preFleet" : [WeddingShopCenterPromptlyDicDataShopArayList class]};
}

@end


@implementation WeddingShopCenterPromptlyDicDataShopArayList

+ (NSDictionary *)objectClassInArray{
    return @{@"shop" : [WeddingShopCenterPromptlyGoodsArayList class]};
}

@end


@implementation WeddingShopCenterPromptlyGoodsArayList

@end
