//
//  WeddingShopCenterCarAddGoodsSheetView.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/8/19.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CarAddGoodsSheetViewDelegate <NSObject>

-(void)transferCollectionClickWithSection:(NSArray*)sectionArr itemIndex:(NSArray*)itemArr goodsCounts:(NSInteger)count;

@end


typedef NS_ENUM(NSInteger, WidthType){
    WidthFixed,//宽度固定  默认
    WidthAutoChange//宽度自动计算
};
typedef NS_ENUM(NSInteger, leftBtttonType){
    cancle,//取消 默认
    reset//重置
    
};


@interface WeddingShopCenterCarAddGoodsSheetView : UIView

@property (nonatomic,weak) id<CarAddGoodsSheetViewDelegate>delegate;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles items:(NSArray<NSArray *> *)items headViewData:(NSDictionary *)headViewModel widthType:(WidthType)type leftBtnType:(leftBtttonType)leftType;

- (void)showPickView;

@end
