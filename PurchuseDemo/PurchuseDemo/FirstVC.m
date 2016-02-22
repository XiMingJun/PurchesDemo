//
//  FirstVC.m
//  PurchuseDemo
//
//  Created by wangjian on 15/11/7.
//  Copyright © 2015年 com.qhfax. All rights reserved.
//

#import "FirstVC.h"
#import "DataModels.h"
@implementation FirstVC
- (void)viewDidLoad{
    for (int i = 0; i < _dateArray.count; i++) {
        PurchaseModel *model = _dateArray[i];
        for (int j = 0; j < model.commodityLst.count; j++) {
            CommodityLst *commodModel = model.commodityLst[j];
            if (_countNum[i][j] > 0) {
                NSLog(@"%@--%ld瓶",commodModel.name,_countNum[i][j]);
            }
        }
    }
    NSLog(@"总价格----%f",_totalPrice);
}
@end
