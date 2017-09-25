//
//  ShopCartDicDataModel.m
//  WeddingRequestData
//
//  Created by 大碗豆 on 17/9/8.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ShopCartDicDataModel.h"

@implementation ShopCartDicDataModel

@end
@implementation ShopCaryOrginalDicData

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ShopCartDicDataShopArayList class]};
}

@end


@implementation ShopCartDicDataShopArayList

+ (NSDictionary *)objectClassInArray{
    return @{@"shop" : [ShopCartGoodsArayList class]};
}

@end


@implementation ShopCartGoodsArayList

@end


//@implementation ShopCartGoodsAttrDicData
//
//@end


