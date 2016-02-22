//
//  ChooseTableViewCell.m
//  VVIP
//
//  Created by JiayouTech on 15/11/3.
//  Copyright © 2015年 JiayouTech. All rights reserved.
//

#import "ChooseTableViewCell.h"

@implementation ChooseTableViewCell
@synthesize block;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCallBackT:(CartBlockT)callBackT
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [UIColor blackColor];
        moneyArray = [[NSMutableArray alloc] initWithCapacity:0];
         block = callBackT;
        [self loadData];
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [UIColor blackColor];
        [self loadData];
    }
    return self;
}
-(void)loadData
{
    _wineName =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-100, 40)];// [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 160, self.frame.size.height)];
    //_wineName.text=@"namenamenmaneneamamennaeamenaneaskldalksdlkasdnlkasdlkasndlka、";
   
    
    //_wineName.textColor = [UIColor whiteColor];
    _wineName.numberOfLines = 2;
    //_wineName
    [self.contentView addSubview:_wineName];
   // NSString *wineMoneyText =[NSString stringWithFormat:@"HK$ %@",_rightData[@"salePrice"]];
  
    _wineMoney =[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 160, 20)];
    //_wineMoney.text=@"HK$ 3000";
   
    [self.contentView addSubview:_wineMoney];
    
    
    
   
   
    
    
    _wineRight =[UIButton buttonWithType:UIButtonTypeCustom];
    _wineRight.frame = CGRectMake(self.frame.size.width-30, 35, 20, 20);
    [_wineRight setBackgroundImage:[UIImage imageNamed:@"5-2-加号"] forState:UIControlStateNormal];
    [_wineRight setBackgroundColor:[UIColor blueColor]];
    [self.contentView addSubview:_wineRight];
    
    _wineQuantity=[[UITextField alloc] initWithFrame:CGRectMake(_wineRight.frame.origin.x-30, 35, 30, 20)];
    _wineQuantity.text=@"0";
    //_wineQuantity.backgroundColor = [UIColor redColor];
    _wineQuantity.textAlignment = NSTextAlignmentCenter;
    //_wineQuantity.textColor=[UIColor whiteColor];
    _wineQuantity.userInteractionEnabled = NO;
    [self.contentView addSubview:_wineQuantity];
    
    _wineLeft =[UIButton buttonWithType:UIButtonTypeCustom];
    _wineLeft.frame = CGRectMake(_wineQuantity.frame.origin.x-20, 35, 20, 20);
    [_wineLeft setBackgroundImage:[UIImage imageNamed:@"5-2-减号"] forState:UIControlStateNormal];
    [_wineLeft setBackgroundColor:[UIColor brownColor]];
    [self.contentView addSubview:_wineLeft];
    [_wineLeft addTarget:self action:@selector(lostBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_wineRight addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
}
#pragma mark-增加购买数量
- (void)addBtnClick:(UIButton *)button
{
//    NSLog(@"button===%ld",(long)button.tag);
    int NumberInt =[_wineQuantity.text intValue];
    if (NumberInt ==99) {
        return;
    }
    ++NumberInt;
    
    _wineQuantity.text =[NSString stringWithFormat:@"%d",NumberInt];
    _total_price = 300 ;
    //[moneyArray addObject:[NSString stringWithFormat:@"%d",300]];
    button.tag =_total_price;
    if (block) {
        block(NumberInt);
    }
//    NSLog(@"moneyArrayadd===%@",moneyArray);
}
#pragma mark-增加购买数量
- (void)lostBtnClick:(UIButton *)lossbutton
{
    NSLog(@"button===%ld",(long)lossbutton.tag);
    int NumberInt =[_wineQuantity.text intValue];
    if (NumberInt ==0) {
        return;
    }
    --NumberInt;
    _wineQuantity.text =[NSString stringWithFormat:@"%d",NumberInt];
     _total_price = 300 ;
    lossbutton.tag =_total_price;
    if (block) {
        block(NumberInt);
    }
//    [moneyArray removeObject:[NSString stringWithFormat:@"%d",300]];
//     NSLog(@"moneyArraylost===%@",moneyArray);
}
@end
