//
//  WeddingShopCenterPromptlyBuyViewController.m
//  WeddingAppWY
//
//  Created by 大碗豆 on 17/8/10.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "WeddingShopCenterPromptlyBuyViewController.h"
#import "WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell.h"
#import "WeddingShopCenterPromptlyBuySectionHeadView.h"
#import "WeddingShopCenterPromptlyBuySetionFootViewCell.h"
#import "ShopCartModel.h"
#import "WeddingShopCenterPromptlyBuyModel.h"


@interface WeddingShopCenterPromptlyBuyViewController ()<UITableViewDelegate,UITableViewDataSource,WeddingShopCenterPromptlyBuySectionHeadViewDelegate>

{
    UILabel *_allMoneyLabel;
    UILabel *_saveMoneyLable;
    UIButton *_payButton;
//    CGFloat _cellHeight;
}

@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) NSString *leaveStr;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WeddingShopCenterPromptlyBuyModel *model;


@end

@implementation WeddingShopCenterPromptlyBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestRefreshShopCartDicData];
}


/**
 从购物车进来的数据请求
 */
- (void)requestRefreshShopCartDicData{
    
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yudingdan.plist" ofType:nil]];
    WeddingShopCenterPromptlyBuyModel *model = [WeddingShopCenterPromptlyBuyModel mj_objectWithKeyValues:dicData];
    
    self.model = model;
    [self setShopcatInformation:model];
    
}


#pragma mark - getData
- (void)setShopcatInformation:(WeddingShopCenterPromptlyBuyModel*)model{
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < model.data.preFleet.count; i ++ ) {
        
        WeddingShopCenterPromptlyDicDataShopArayList *shopDic = model.data.preFleet[i];
        
        ShopCartModel *model = [[ShopCartModel alloc] init];
        model.shopName = [NSString stringWithFormat:@"%@",shopDic.shopname];
        model.selectStatus = NO;
        model.productArray = [NSMutableArray array];
        
        CGFloat tampStrPostage = 0;
        CGFloat allmoney = 0;
        
        for (NSInteger j = 0; j < shopDic.shop.count + 1; j ++ ) {
            
            ShopCartProductModel *productModel  = [[ShopCartProductModel alloc] init];
            
            if (j < shopDic.shop.count) {
                WeddingShopCenterPromptlyGoodsArayList *goodsDic = shopDic.shop[j];
                
                productModel.productName = [NSString stringWithFormat:@"%@",goodsDic.shopname];
                productModel.selectStatus = NO;
                productModel.productPriceNow = [NSString stringWithFormat:@"￥%.2f",goodsDic.money];
                productModel.productPriceLate = [NSString stringWithFormat:@"￥%.2f",goodsDic.market];
                productModel.productCount = goodsDic.num;
                
                CGFloat postPage = [goodsDic.freight floatValue];
                
                if (postPage >= tampStrPostage) {
                    
                    tampStrPostage = postPage;
                }
                
                CGFloat priceNow = [[productModel.productPriceNow substringFromIndex:1] floatValue];
                allmoney += priceNow * productModel.productCount;
                
                NSArray *attrAllKey = [goodsDic.attr allKeys];
                NSMutableArray *valueArr = [NSMutableArray new];
                for (NSInteger index = 0; index < attrAllKey.count; index ++ ) {
                    NSString *str = [NSString stringWithFormat:@"%@",goodsDic.attr[attrAllKey[index]]];
                    [valueArr addObject:str];
                }
                NSString *sizeStr = [NSString stringWithFormat:@"规格：%@",[valueArr componentsJoinedByString:@" "]];
                
                productModel.productSize = sizeStr;
                productModel.imageUrl = goodsDic.img;
            }
            productModel.leaveStr = @"";
            [model.productArray addObject:productModel];
            model.Postage = tampStrPostage;
            model.allCost = tampStrPostage + allmoney;
        }
        [self.dataArray addObject:model];
    }
    [self loadDefaultTableView];
    [self setFootView];
}


- (void)loadDefaultTableView{
    UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth , kScreenHeight - 49 - 64) style:UITableViewStyleGrouped];
    tab.rowHeight = UITableViewAutomaticDimension;
    tab.estimatedRowHeight = 40;
    tab.backgroundColor = [UIColor whiteColor];
    tab.showsVerticalScrollIndicator = NO;
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tab registerClass:[WeddingShopCenterPromptlyBuySectionHeadView class] forHeaderFooterViewReuseIdentifier:WeddingShopCenterPromptlyBuySectionHeadViews];
    [self.view addSubview:tab];
    
    self.tabView = tab;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShopCartModel *model = self.dataArray[section];
    return model.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCartModel *shopModel = self.dataArray[indexPath.section];
    ShopCartProductModel *productModel = shopModel.productArray[indexPath.row];
    
    if (indexPath.row < shopModel.productArray.count - 1 ) {
        WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell *cell = [WeddingShopCenterPromtlyBuyGoodsDetailTableViewCell cellWithTableView:tableView];
        cell.model = productModel;
        return cell;
    }else{
        WeddingShopCenterPromptlyBuySetionFootViewCell *cell = [WeddingShopCenterPromptlyBuySetionFootViewCell cellWithTableView:tableView];
        cell.leaveMessageTwxtV.text = productModel.leaveStr;
        cell.model = shopModel;
        
        [cell setResetLeaveMessageTwxtVBlock:^(NSString *strText){
            productModel.leaveStr = strText;
            [tableView reloadData];
        }];
        return cell;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tabView endEditing:YES];
    
    NSLog(@"点击cell~~~~~~~~~");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.tabView endEditing:YES];
}


//**取消tableView的section头部的粘连性*/
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    view.backgroundColor = [UIColor redColor];
    
    WeddingShopCenterPromptlyBuySectionHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:WeddingShopCenterPromptlyBuySectionHeadViews];
    head.section = section;
    ShopCartModel *model = self.dataArray[section];
    head.shopName.text = model.shopName;
    head.delegate = self;
    
    return head;
}

- (void)WeddingShopCenterPromptlyBuySectionHeadViewClickSetion:(NSInteger)section{

    NSLog(@"进入店铺~~~~~~~~~");
    
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}


#pragma mark - setFootView
- (void)setFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight - 49, kScreenWidth , 49)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [footView addSubview:line];
    
    UILabel *allselectLabel = [[UILabel alloc] init];
    [footView addSubview:allselectLabel];
    allselectLabel.text = @"实付金额";
    //    allselectLabel.backgroundColor = [UIColor redColor];
    allselectLabel.font = [UIFont systemFontOfSize:16];
    [allselectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(70);
        make.centerY.equalTo(footView);
    }];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:_payButton];
    _payButton.backgroundColor = [UIColor orangeColor];
    [_payButton setTitle:@"提交订单" forState:0];
    [_payButton setTitleColor:[UIColor whiteColor] forState:0];
    [_payButton addTarget:self action:@selector(gotoOderPage) forControlEvents:UIControlEventTouchUpInside];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.right.equalTo(footView).offset(0);
        //        make.height.mas_equalTo(48);
        //        make.top.equalTo(footView).offset(0);
        
        make.trailing.top.bottom.equalTo(footView);
        make.width.mas_equalTo(100);
    }];
    
    _allMoneyLabel = [[UILabel alloc] init];
    [footView addSubview:_allMoneyLabel];
    CGFloat allmoney = 0;
    for (ShopCartModel *shopModel in self.dataArray) {
        allmoney += shopModel.allCost;
    }
    _allMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",allmoney];
    _allMoneyLabel.font = [UIFont systemFontOfSize:16];
    _allMoneyLabel.textColor  = [UIColor redColor];
    [_allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allselectLabel.mas_right).offset(10);
//        make.top.equalTo(footView).offset(8);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(footView);
        make.right.equalTo(_payButton.mas_left).offset(10);
    }];
    
}

- (void)gotoOderPage {

    NSLog(@"结算~~~~~~~~~");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
