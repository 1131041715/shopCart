//
//  WeddingShopCenterPromptlyBuySectionHeadView.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/9/10.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WeddingShopCenterPromptlyBuySectionHeadViewDelegate <NSObject>

- (void)WeddingShopCenterPromptlyBuySectionHeadViewClickSetion:(NSInteger)section;

@end

static NSString * const WeddingShopCenterPromptlyBuySectionHeadViews = @"WeddingShopCenterPromptlyBuySectionHeadView";

@interface WeddingShopCenterPromptlyBuySectionHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak)id<WeddingShopCenterPromptlyBuySectionHeadViewDelegate> delegate;

@end
