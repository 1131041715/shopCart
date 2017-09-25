//
//  WeddingShopCenterPromptlyBuySetionFootViewCell.h
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/9/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ShopCartModel.h"

@interface WeddingShopCenterPromptlyBuySetionFootViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *leaveMessageTwxtV;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

@property (nonatomic,strong) void (^resetLeaveMessageTwxtVBlock)(NSString *strText);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) ShopCartModel *model;

@end
