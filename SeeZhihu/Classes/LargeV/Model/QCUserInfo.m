//
//  QCNSObject.m
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "QCUserInfo.h"
#import "QCStar.h"
#import "QCDetail.h"
#import "QCTrend.h"
#import "QCTopanswers.h"


NSString *const kQCNSObjectStar = @"star";
NSString *const kQCNSObjectDetail = @"detail";
NSString *const kQCNSObjectTrend = @"trend";
NSString *const kQCNSObjectTopanswers = @"topanswers";
NSString *const kQCNSObjectAvatar = @"avatar";
NSString *const kQCNSObjectSignature = @"signature";
NSString *const kQCNSObjectDescription = @"description";
NSString *const kQCNSObjectError = @"error";
NSString *const kQCNSObjectName = @"name";


@interface QCUserInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QCUserInfo

@synthesize star = _star;
@synthesize detail = _detail;
@synthesize trend = _trend;
@synthesize topanswers = _topanswers;
@synthesize avatar = _avatar;
@synthesize signature = _signature;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize error = _error;
@synthesize name = _name;

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"star" : QCStar.class,
             @"detail" : QCDetail.class,
             @"trend" : QCTrend.class,
             @"topanswers" : QCTopanswers.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"internalBaseClassDescription" : @"description",
             };
}

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
            self.star = [QCStar modelObjectWithDictionary:[dict objectForKey:kQCNSObjectStar]];
            self.detail = [QCDetail modelObjectWithDictionary:[dict objectForKey:kQCNSObjectDetail]];
    NSObject *receivedQCTrend = [dict objectForKey:kQCNSObjectTrend];
    NSMutableArray *parsedQCTrend = [NSMutableArray array];
    if ([receivedQCTrend isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedQCTrend) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedQCTrend addObject:[QCTrend modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedQCTrend isKindOfClass:[NSDictionary class]]) {
       [parsedQCTrend addObject:[QCTrend modelObjectWithDictionary:(NSDictionary *)receivedQCTrend]];
    }

    self.trend = [NSArray arrayWithArray:parsedQCTrend];
    NSObject *receivedQCTopanswers = [dict objectForKey:kQCNSObjectTopanswers];
    NSMutableArray *parsedQCTopanswers = [NSMutableArray array];
    if ([receivedQCTopanswers isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedQCTopanswers) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedQCTopanswers addObject:[QCTopanswers modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedQCTopanswers isKindOfClass:[NSDictionary class]]) {
       [parsedQCTopanswers addObject:[QCTopanswers modelObjectWithDictionary:(NSDictionary *)receivedQCTopanswers]];
    }

    self.topanswers = [NSArray arrayWithArray:parsedQCTopanswers];
            self.avatar = [self objectOrNilForKey:kQCNSObjectAvatar fromDictionary:dict];
            self.signature = [self objectOrNilForKey:kQCNSObjectSignature fromDictionary:dict];
            self.internalBaseClassDescription = [self objectOrNilForKey:kQCNSObjectDescription fromDictionary:dict];
            self.error = [self objectOrNilForKey:kQCNSObjectError fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQCNSObjectName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.star dictionaryRepresentation] forKey:kQCNSObjectStar];
    [mutableDict setValue:[self.detail dictionaryRepresentation] forKey:kQCNSObjectDetail];
    NSMutableArray *tempArrayForTrend = [NSMutableArray array];
    for (NSObject *subArrayObject in self.trend) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTrend addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTrend addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTrend] forKey:kQCNSObjectTrend];
    NSMutableArray *tempArrayForTopanswers = [NSMutableArray array];
    for (NSObject *subArrayObject in self.topanswers) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTopanswers addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTopanswers addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTopanswers] forKey:kQCNSObjectTopanswers];
    [mutableDict setValue:self.avatar forKey:kQCNSObjectAvatar];
    [mutableDict setValue:self.signature forKey:kQCNSObjectSignature];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kQCNSObjectDescription];
    [mutableDict setValue:self.error forKey:kQCNSObjectError];
    [mutableDict setValue:self.name forKey:kQCNSObjectName];

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

    self.star = [aDecoder decodeObjectForKey:kQCNSObjectStar];
    self.detail = [aDecoder decodeObjectForKey:kQCNSObjectDetail];
    self.trend = [aDecoder decodeObjectForKey:kQCNSObjectTrend];
    self.topanswers = [aDecoder decodeObjectForKey:kQCNSObjectTopanswers];
    self.avatar = [aDecoder decodeObjectForKey:kQCNSObjectAvatar];
    self.signature = [aDecoder decodeObjectForKey:kQCNSObjectSignature];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kQCNSObjectDescription];
    self.error = [aDecoder decodeObjectForKey:kQCNSObjectError];
    self.name = [aDecoder decodeObjectForKey:kQCNSObjectName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_star forKey:kQCNSObjectStar];
    [aCoder encodeObject:_detail forKey:kQCNSObjectDetail];
    [aCoder encodeObject:_trend forKey:kQCNSObjectTrend];
    [aCoder encodeObject:_topanswers forKey:kQCNSObjectTopanswers];
    [aCoder encodeObject:_avatar forKey:kQCNSObjectAvatar];
    [aCoder encodeObject:_signature forKey:kQCNSObjectSignature];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kQCNSObjectDescription];
    [aCoder encodeObject:_error forKey:kQCNSObjectError];
    [aCoder encodeObject:_name forKey:kQCNSObjectName];
}

- (id)copyWithZone:(NSZone *)zone
{
    QCUserInfo *copy = [[QCUserInfo alloc] init];
    
    if (copy) {

        copy.star = [self.star copyWithZone:zone];
        copy.detail = [self.detail copyWithZone:zone];
        copy.trend = [self.trend copyWithZone:zone];
        copy.topanswers = [self.topanswers copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.signature = [self.signature copyWithZone:zone];
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.error = [self.error copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
