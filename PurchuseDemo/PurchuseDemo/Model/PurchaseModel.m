//
//  PurchaseModel.m
//
//  Created by 健 王 on 15/11/7
//  Copyright (c) 2015 深圳市前海融通科技有限公司. All rights reserved.
//

#import "PurchaseModel.h"
#import "CommodityLst.h"


NSString *const kPurchaseModelCategoryName = @"categoryName";
NSString *const kPurchaseModelCommodityLst = @"commodityLst";
NSString *const kPurchaseModelQuantity = @"Quantity";


@interface PurchaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PurchaseModel

@synthesize categoryName = _categoryName;
@synthesize commodityLst = _commodityLst;
@synthesize quantity = _quantity;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.categoryName = [self objectOrNilForKey:kPurchaseModelCategoryName fromDictionary:dict];
    NSObject *receivedCommodityLst = [dict objectForKey:kPurchaseModelCommodityLst];
    NSMutableArray *parsedCommodityLst = [NSMutableArray array];
    if ([receivedCommodityLst isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCommodityLst) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCommodityLst addObject:[CommodityLst modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCommodityLst isKindOfClass:[NSDictionary class]]) {
       [parsedCommodityLst addObject:[CommodityLst modelObjectWithDictionary:(NSDictionary *)receivedCommodityLst]];
    }

    self.commodityLst = [NSArray arrayWithArray:parsedCommodityLst];
            self.quantity = [[self objectOrNilForKey:kPurchaseModelQuantity fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.categoryName forKey:kPurchaseModelCategoryName];
    NSMutableArray *tempArrayForCommodityLst = [NSMutableArray array];
    for (NSObject *subArrayObject in self.commodityLst) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCommodityLst addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCommodityLst addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCommodityLst] forKey:kPurchaseModelCommodityLst];
    [mutableDict setValue:[NSNumber numberWithDouble:self.quantity] forKey:kPurchaseModelQuantity];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.categoryName = [aDecoder decodeObjectForKey:kPurchaseModelCategoryName];
    self.commodityLst = [aDecoder decodeObjectForKey:kPurchaseModelCommodityLst];
    self.quantity = [aDecoder decodeDoubleForKey:kPurchaseModelQuantity];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_categoryName forKey:kPurchaseModelCategoryName];
    [aCoder encodeObject:_commodityLst forKey:kPurchaseModelCommodityLst];
    [aCoder encodeDouble:_quantity forKey:kPurchaseModelQuantity];
}

- (id)copyWithZone:(NSZone *)zone
{
    PurchaseModel *copy = [[PurchaseModel alloc] init];
    
    if (copy) {

        copy.categoryName = [self.categoryName copyWithZone:zone];
        copy.commodityLst = [self.commodityLst copyWithZone:zone];
        copy.quantity = self.quantity;
    }
    
    return copy;
}


@end
