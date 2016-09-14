//
//  QCStar.m
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "QCStar.h"


NSString *const kQCStarAgreerank = @"agreerank";
NSString *const kQCStarAnswerrank = @"answerrank";
NSString *const kQCStarCount100rank = @"count100rank";
NSString *const kQCStarFavrank = @"favrank";
NSString *const kQCStarFollowerrank = @"followerrank";
NSString *const kQCStarRatiorank = @"ratiorank";
NSString *const kQCStarCount1000rank = @"count1000rank";


@interface QCStar ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QCStar

@synthesize agreerank = _agreerank;
@synthesize answerrank = _answerrank;
@synthesize count100rank = _count100rank;
@synthesize favrank = _favrank;
@synthesize followerrank = _followerrank;
@synthesize ratiorank = _ratiorank;
@synthesize count1000rank = _count1000rank;


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
            self.agreerank = [self objectOrNilForKey:kQCStarAgreerank fromDictionary:dict];
            self.answerrank = [self objectOrNilForKey:kQCStarAnswerrank fromDictionary:dict];
            self.count100rank = [self objectOrNilForKey:kQCStarCount100rank fromDictionary:dict];
            self.favrank = [self objectOrNilForKey:kQCStarFavrank fromDictionary:dict];
            self.followerrank = [self objectOrNilForKey:kQCStarFollowerrank fromDictionary:dict];
            self.ratiorank = [self objectOrNilForKey:kQCStarRatiorank fromDictionary:dict];
            self.count1000rank = [self objectOrNilForKey:kQCStarCount1000rank fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.agreerank forKey:kQCStarAgreerank];
    [mutableDict setValue:self.answerrank forKey:kQCStarAnswerrank];
    [mutableDict setValue:self.count100rank forKey:kQCStarCount100rank];
    [mutableDict setValue:self.favrank forKey:kQCStarFavrank];
    [mutableDict setValue:self.followerrank forKey:kQCStarFollowerrank];
    [mutableDict setValue:self.ratiorank forKey:kQCStarRatiorank];
    [mutableDict setValue:self.count1000rank forKey:kQCStarCount1000rank];

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

    self.agreerank = [aDecoder decodeObjectForKey:kQCStarAgreerank];
    self.answerrank = [aDecoder decodeObjectForKey:kQCStarAnswerrank];
    self.count100rank = [aDecoder decodeObjectForKey:kQCStarCount100rank];
    self.favrank = [aDecoder decodeObjectForKey:kQCStarFavrank];
    self.followerrank = [aDecoder decodeObjectForKey:kQCStarFollowerrank];
    self.ratiorank = [aDecoder decodeObjectForKey:kQCStarRatiorank];
    self.count1000rank = [aDecoder decodeObjectForKey:kQCStarCount1000rank];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_agreerank forKey:kQCStarAgreerank];
    [aCoder encodeObject:_answerrank forKey:kQCStarAnswerrank];
    [aCoder encodeObject:_count100rank forKey:kQCStarCount100rank];
    [aCoder encodeObject:_favrank forKey:kQCStarFavrank];
    [aCoder encodeObject:_followerrank forKey:kQCStarFollowerrank];
    [aCoder encodeObject:_ratiorank forKey:kQCStarRatiorank];
    [aCoder encodeObject:_count1000rank forKey:kQCStarCount1000rank];
}

- (id)copyWithZone:(NSZone *)zone
{
    QCStar *copy = [[QCStar alloc] init];
    
    if (copy) {

        copy.agreerank = [self.agreerank copyWithZone:zone];
        copy.answerrank = [self.answerrank copyWithZone:zone];
        copy.count100rank = [self.count100rank copyWithZone:zone];
        copy.favrank = [self.favrank copyWithZone:zone];
        copy.followerrank = [self.followerrank copyWithZone:zone];
        copy.ratiorank = [self.ratiorank copyWithZone:zone];
        copy.count1000rank = [self.count1000rank copyWithZone:zone];
    }
    
    return copy;
}


@end
