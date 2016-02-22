//
//  ChooseTableViewCell.h
//  VVIP
//
//  Created by JiayouTech on 15/11/3.
//  Copyright © 2015年 JiayouTech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CartBlockT)(int number);
@interface ChooseTableViewCell : UITableViewCell
{
    UILabel *_label1;
    UILabel *_label2;
    NSMutableArray *moneyArray;
}
@property (nonatomic , copy) void (^CartBlockT)(int number);
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex ,NSInteger money);
@property (retain ,nonatomic) UIImageView *wineImage;

@property (retain ,nonatomic) UILabel *imageShow;

@property (retain ,nonatomic) UILabel *wineName;

@property (retain ,nonatomic) UILabel *wineMoney;

@property (retain ,nonatomic) UITextField *wineQuantity;

@property (retain ,nonatomic) UIButton *wineLeft;

@property (retain ,nonatomic) UIButton *wineRight;
@property(nonatomic,copy)CartBlockT block;
@property (nonatomic) int number;        //数量
@property (nonatomic) float price;       //价格
@property (nonatomic) float total_price;    //商品价格
@property (retain ,nonatomic) UILabel *wineMoneyOriginalPrice;

@property (retain ,nonatomic) UIView *wineMoneyOriginalPriceShow;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCallBackT:(CartBlockT)callBackT;
@end
