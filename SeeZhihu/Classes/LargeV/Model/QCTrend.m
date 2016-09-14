//
//  QCTrend.m
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "QCTrend.h"


NSString *const kQCTrendAgree = @"agree";
NSString *const kQCTrendFollower = @"follower";
NSString *const kQCTrendAnswer = @"answer";
NSString *const kQCTrendDate = @"date";


@interface QCTrend ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QCTrend

@synthesize agree = _agree;
@synthesize follower = _follower;
@synthesize answer = _answer;
@synthesize date = _date;


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
            self.agree = [self objectOrNilForKey:kQCTrendAgree fromDictionary:dict];
            self.follower = [self objectOrNilForKey:kQCTrendFollower fromDictionary:dict];
            self.answer = [self objectOrNilForKey:kQCTrendAnswer fromDictionary:dict];
            self.date = [self objectOrNilForKey:kQCTrendDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.agree forKey:kQCTrendAgree];
    [mutableDict setValue:self.follower forKey:kQCTrendFollower];
    [mutableDict setValue:self.answer forKey:kQCTrendAnswer];
    [mutableDict setValue:self.date forKey:kQCTrendDate];

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

    self.agree = [aDecoder decodeObjectForKey:kQCTrendAgree];
    self.follower = [aDecoder decodeObjectForKey:kQCTrendFollower];
    self.answer = [aDecoder decodeObjectForKey:kQCTrendAnswer];
    self.date = [aDecoder decodeObjectForKey:kQCTrendDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_agree forKey:kQCTrendAgree];
    [aCoder encodeObject:_follower forKey:kQCTrendFollower];
    [aCoder encodeObject:_answer forKey:kQCTrendAnswer];
    [aCoder encodeObject:_date forKey:kQCTrendDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    QCTrend *copy = [[QCTrend alloc] init];
    
    if (copy) {

        copy.agree = [self.agree copyWithZone:zone];
        copy.follower = [self.follower copyWithZone:zone];
        copy.answer = [self.answer copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
