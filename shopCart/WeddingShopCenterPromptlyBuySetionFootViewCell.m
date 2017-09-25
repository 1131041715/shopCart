//
//  WeddingShopCenterPromptlyBuySetionFootViewCell.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/9/9.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WeddingShopCenterPromptlyBuySetionFootViewCell.h"

@interface WeddingShopCenterPromptlyBuySetionFootViewCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *distributionWayLable;

@property (weak, nonatomic) IBOutlet UILabel *summationLable;

@property (weak, nonatomic) IBOutlet UIView *oneLineView;

@property (weak, nonatomic) IBOutlet UIView *towLineView;

@property (nonatomic,strong) UILabel *pleaceHoledLab;

@end


@implementation WeddingShopCenterPromptlyBuySetionFootViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.oneLineView.backgroundColor = [UIColor purpleColor];
    self.towLineView.backgroundColor = [UIColor greenColor];
    
//    self.leaveMessageTwxtV.backgroundColor = [UIColor colorWithHexString:typeViewBackgroundColor];
    self.leaveMessageTwxtV.backgroundColor = [UIColor cyanColor];
    self.leaveMessageTwxtV.layer.cornerRadius = 5.0;
    self.leaveMessageTwxtV.layer.masksToBounds = YES;
    
    UILabel *pleaceHoledLab = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, kScreenWidth - 43, 30)];
    pleaceHoledLab.textColor = [UIColor darkGrayColor];
    pleaceHoledLab.font = [UIFont systemFontOfSize:16];
    pleaceHoledLab.text = @"买家留言";
    self.pleaceHoledLab = pleaceHoledLab;
    [self.leaveMessageTwxtV addSubview:pleaceHoledLab];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        self.pleaceHoledLab.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        self.pleaceHoledLab.hidden = NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        
        if (textView.text.length > 0) {
          
        }
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *str = @"WeddingShopCenterPromptlyBuySetionFootViewCell";
    WeddingShopCenterPromptlyBuySetionFootViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeddingShopCenterPromptlyBuySetionFootViewCell" owner:nil options:nil] firstObject];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    //去掉高亮
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setModel:(ShopCartModel *)model{
    _model = model;

    if (model.Postage == 0.0) {
        self.distributionWayLable.text = @"快递 包邮";
    }else{
        self.distributionWayLable.text = [NSString stringWithFormat:@"快递 邮费%.2f",model.Postage];
    }
    self.summationLable.text = [NSString stringWithFormat:@"%.2f",model.allCost];
    
    ShopCartProductModel *productModel = model.productArray.lastObject;
    
//    NSLog(@"%@~~~~~~~~~",productModel.leaveStr);
    if (productModel.leaveStr.length > 0) {
        self.pleaceHoledLab.hidden = YES;
    }
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.resetLeaveMessageTwxtVBlock) {
        self.resetLeaveMessageTwxtVBlock(textView.text);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
