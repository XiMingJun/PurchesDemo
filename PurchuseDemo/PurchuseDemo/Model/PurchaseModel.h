//
//  PurchaseModel.h
//
//  Created by 健 王 on 15/11/7
//  Copyright (c) 2015 深圳市前海融通科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PurchaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSArray *commodityLst;
@property (nonatomic, assign) double quantity;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
