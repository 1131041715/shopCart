//
//  ShopCartCell.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/7/17.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "ShopCartCell.h"





@interface ShopCartCell ()

@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *delectBtn;


@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productSize;
@property (weak, nonatomic) IBOutlet UILabel *productPriceNow;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLate;
@property (weak, nonatomic) IBOutlet UIView *addOrSub;
@property (weak, nonatomic) IBOutlet UITextField *productCount;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation ShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addOrSub.layer.borderWidth = 1;
    self.addOrSub.layer.borderColor = [RGB_COLOR(200, 200, 200) CGColor];
    self.addOrSub.layer.cornerRadius = 5;
    self.addOrSub.layer.masksToBounds = YES;
    self.productCount.layer.borderWidth = 0.5;
    self.productCount.layer.borderColor = [RGB_COLOR(200, 200, 200) CGColor];
    [self.selectBtn setImage:IMG(@"shopcat_no_select") forState:UIControlStateNormal];
    [self.selectBtn setImage:IMG(@"shopcat_select") forState:UIControlStateSelected];
    
    self.selectBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.delectBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.productCount.enabled = NO;
    self.lineView.backgroundColor = [UIColor purpleColor];
}


- (void)setModel:(ShopCartProductModel *)model{
    _model = model;
    self.productName.text = model.productName;
    self.productSize.text = model.productSize;
    self.productPriceNow.text = model.productPriceNow;
    self.productPriceLate.text = model.productPriceLate;
    self.productCount.text = [NSString stringWithFormat:@"%ld",model.productCount];
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.imageUrl]] placeholderImage:[UIImage imageNamed:@"rp"]];
}


- (IBAction)selectProductAction:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectProductActionWithIndex:selectFlag:)]) {
        [self.delegate selectProductActionWithIndex:self.indexPath selectFlag:sender.selected];
    }
    
}

- (IBAction)subProductAction:(UIButton *)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(subProductCountActionWithIndex:)]) {
        [self.delegate subProductCountActionWithIndex:self.indexPath];
    }
}

- (IBAction)addProductAction:(UIButton *)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addProductCountActionWithIndex:)]) {
        [self.delegate addProductCountActionWithIndex:self.indexPath];
    }
}

- (IBAction)deleteProductAction:(UIButton *)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(deleteProductActionWithIndex:)]) {
        [self.delegate deleteProductActionWithIndex:self.indexPath];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
