//
//  CommodityLst.m
//
//  Created by 健 王 on 15/11/7
//  Copyright (c) 2015 深圳市前海融通科技有限公司. All rights reserved.
//

#import "CommodityLst.h"


NSString *const kCommodityLstAmount = @"amount";
NSString *const kCommodityLstSalePrice = @"salePrice";
NSString *const kCommodityLstCommodityId = @"commodityId";
NSString *const kCommodityLstCount = @"count";
NSString *const kCommodityLstName = @"name";
NSString *const kCommodityLstCategory = @"category";


@interface CommodityLst ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommodityLst

@synthesize amount = _amount;
@synthesize salePrice = _salePrice;
@synthesize commodityId = _commodityId;
@synthesize count = _count;
@synthesize name = _name;
@synthesize category = _category;


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
            self.amount = [[self objectOrNilForKey:kCommodityLstAmount fromDictionary:dict] doubleValue];
            self.salePrice = [[self objectOrNilForKey:kCommodityLstSalePrice fromDictionary:dict] doubleValue];
            self.commodityId = [self objectOrNilForKey:kCommodityLstCommodityId fromDictionary:dict];
            self.count = [[self objectOrNilForKey:kCommodityLstCount fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kCommodityLstName fromDictionary:dict];
            self.category = [self objectOrNilForKey:kCommodityLstCategory fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.amount] forKey:kCommodityLstAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.salePrice] forKey:kCommodityLstSalePrice];
    [mutableDict setValue:self.commodityId forKey:kCommodityLstCommodityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kCommodityLstCount];
    [mutableDict setValue:self.name forKey:kCommodityLstName];
    [mutableDict setValue:self.category forKey:kCommodityLstCategory];

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

    self.amount = [aDecoder decodeDoubleForKey:kCommodityLstAmount];
    self.salePrice = [aDecoder decodeDoubleForKey:kCommodityLstSalePrice];
    self.commodityId = [aDecoder decodeObjectForKey:kCommodityLstCommodityId];
    self.count = [aDecoder decodeDoubleForKey:kCommodityLstCount];
    self.name = [aDecoder decodeObjectForKey:kCommodityLstName];
    self.category = [aDecoder decodeObjectForKey:kCommodityLstCategory];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_amount forKey:kCommodityLstAmount];
    [aCoder encodeDouble:_salePrice forKey:kCommodityLstSalePrice];
    [aCoder encodeObject:_commodityId forKey:kCommodityLstCommodityId];
    [aCoder encodeDouble:_count forKey:kCommodityLstCount];
    [aCoder encodeObject:_name forKey:kCommodityLstName];
    [aCoder encodeObject:_category forKey:kCommodityLstCategory];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommodityLst *copy = [[CommodityLst alloc] init];
    
    if (copy) {

        copy.amount = self.amount;
        copy.salePrice = self.salePrice;
        copy.commodityId = [self.commodityId copyWithZone:zone];
        copy.count = self.count;
        copy.name = [self.name copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
    }
    
    return copy;
}


@end
