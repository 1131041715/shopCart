//
//  WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/8/10.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell.h"


@interface WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *goodsSize;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *boforePrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsCount;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lineView.backgroundColor = [UIColor redColor];
    self.nowPrice.textColor = [UIColor orangeColor];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *str = @"WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell";
    WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell" owner:nil options:nil] firstObject];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    //去掉高亮
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)setModel:(ShopCartProductModel *)model{
    _model = model;
    
    self.goodsTitle.text = model.productName;
    self.goodsSize.text = model.productSize;
    self.nowPrice.text = model.productPriceNow;
    self.boforePrice.text = model.productPriceLate;
    self.goodsCount.text = [NSString stringWithFormat:@"%ld",model.productCount];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.imageUrl]] placeholderImage:[UIImage imageNamed:@"rp"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
