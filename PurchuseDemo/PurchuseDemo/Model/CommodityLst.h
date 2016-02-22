//
//  CommodityLst.h
//
//  Created by 健 王 on 15/11/7
//  Copyright (c) 2015 深圳市前海融通科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommodityLst : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double amount;
@property (nonatomic, assign) double salePrice;
@property (nonatomic, strong) NSString *commodityId;
@property (nonatomic, assign) double count;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *category;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
