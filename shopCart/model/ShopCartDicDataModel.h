//
//  ShopCartDicDataModel.h
//  WeddingRequestData
//
//  Created by 大碗豆 on 17/9/8.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShopCaryOrginalDicData,ShopCartDicDataShopArayList,ShopCartGoodsArayList,ShopCartGoodsAttrDicData;
@interface ShopCartDicDataModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ShopCaryOrginalDicData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface ShopCaryOrginalDicData : NSObject

@property (nonatomic, strong) NSArray<ShopCartDicDataShopArayList *> *list;

@end

@interface ShopCartDicDataShopArayList : NSObject

@property (nonatomic, copy) NSString *shopid;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, strong) NSArray<ShopCartGoodsArayList *> *shop;

@end

@interface ShopCartGoodsArayList : NSObject

@property (nonatomic, assign) NSInteger shopid;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) CGFloat market;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSDictionary *attr;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) CGFloat money;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, assign) BOOL del;

@end

//@interface ShopCartGoodsAttrDicData : NSObject
//
//@property (nonatomic, copy) NSString *尺码;
//
//@property (nonatomic, copy) NSString *颜色;
//
//@end

