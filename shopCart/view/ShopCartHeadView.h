//
//  shopCartHeadView.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/7/17.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol shopCartHeadViewDelegate <NSObject>

@optional

- (void)ShopCartHeadViewCurrectSectionsInView:(NSInteger)section selectStatus:(BOOL)selectStatus;

- (void)ShopCartHeadViewDeleteCurrectSectionsInView:(NSInteger)section;

@end


static NSString * const ShopCartHeadViews = @"ShopCartHeadView";

@interface ShopCartHeadView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<shopCartHeadViewDelegate> delegate;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, assign) NSInteger section;

@end
