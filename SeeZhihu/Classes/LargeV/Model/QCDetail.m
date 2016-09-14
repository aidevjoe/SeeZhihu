//
//  QCDetail.m
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "QCDetail.h"


NSString *const kQCDetailLogs = @"logs";
NSString *const kQCDetailMostvotepercent = @"mostvotepercent";
NSString *const kQCDetailRatio = @"ratio";
NSString *const kQCDetailAgreei = @"agreei";
NSString *const kQCDetailThanks = @"thanks";
NSString *const kQCDetailCount2000 = @"count2000";
NSString *const kQCDetailAgreeiratiow = @"agreeiratiow";
NSString *const kQCDetailCount100 = @"count100";
NSString *const kQCDetailFollowee = @"followee";
NSString *const kQCDetailTratio = @"tratio";
NSString *const kQCDetailFollower = @"follower";
NSString *const kQCDetailCount10000 = @"count10000";
NSString *const kQCDetailCount500 = @"count500";
NSString *const kQCDetailAnswer = @"answer";
NSString *const kQCDetailFollowiratio = @"followiratio";
NSString *const kQCDetailPost = @"post";
NSString *const kQCDetailMostvote = @"mostvote";
NSString *const kQCDetailCount5000 = @"count5000";
NSString *const kQCDetailFolloweri = @"followeri";
NSString *const kQCDetailMostvote5percent = @"mostvote5percent";
NSString *const kQCDetailAsk = @"ask";
NSString *const kQCDetailAgreeiw = @"agreeiw";
NSString *const kQCDetailAgreeiratio = @"agreeiratio";
NSString *const kQCDetailFav = @"fav";
NSString *const kQCDetailFratio = @"fratio";
NSString *const kQCDetailFolloweriw = @"followeriw";
NSString *const kQCDetailMostvote10percent = @"mostvote10percent";
NSString *const kQCDetailCount1000 = @"count1000";
NSString *const kQCDetailFollowiratiow = @"followiratiow";
NSString *const kQCDetailMostvote5 = @"mostvote5";
NSString *const kQCDetailMostvote10 = @"mostvote10";
NSString *const kQCDetailAgree = @"agree";
NSString *const kQCDetailCount200 = @"count200";


@interface QCDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QCDetail

@synthesize logs = _logs;
@synthesize mostvotepercent = _mostvotepercent;
@synthesize ratio = _ratio;
@synthesize agreei = _agreei;
@synthesize thanks = _thanks;
@synthesize count2000 = _count2000;
@synthesize agreeiratiow = _agreeiratiow;
@synthesize count100 = _count100;
@synthesize followee = _followee;
@synthesize tratio = _tratio;
@synthesize follower = _follower;
@synthesize count10000 = _count10000;
@synthesize count500 = _count500;
@synthesize answer = _answer;
@synthesize followiratio = _followiratio;
@synthesize post = _post;
@synthesize mostvote = _mostvote;
@synthesize count5000 = _count5000;
@synthesize followeri = _followeri;
@synthesize mostvote5percent = _mostvote5percent;
@synthesize ask = _ask;
@synthesize agreeiw = _agreeiw;
@synthesize agreeiratio = _agreeiratio;
@synthesize fav = _fav;
@synthesize fratio = _fratio;
@synthesize followeriw = _followeriw;
@synthesize mostvote10percent = _mostvote10percent;
@synthesize count1000 = _count1000;
@synthesize followiratiow = _followiratiow;
@synthesize mostvote5 = _mostvote5;
@synthesize mostvote10 = _mostvote10;
@synthesize agree = _agree;
@synthesize count200 = _count200;


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
            self.logs = [self objectOrNilForKey:kQCDetailLogs fromDictionary:dict];
            self.mostvotepercent = [self objectOrNilForKey:kQCDetailMostvotepercent fromDictionary:dict];
            self.ratio = [self objectOrNilForKey:kQCDetailRatio fromDictionary:dict];
            self.agreei = [self objectOrNilForKey:kQCDetailAgreei fromDictionary:dict];
            self.thanks = [self objectOrNilForKey:kQCDetailThanks fromDictionary:dict];
            self.count2000 = [self objectOrNilForKey:kQCDetailCount2000 fromDictionary:dict];
            self.agreeiratiow = [self objectOrNilForKey:kQCDetailAgreeiratiow fromDictionary:dict];
            self.count100 = [self objectOrNilForKey:kQCDetailCount100 fromDictionary:dict];
            self.followee = [self objectOrNilForKey:kQCDetailFollowee fromDictionary:dict];
            self.tratio = [self objectOrNilForKey:kQCDetailTratio fromDictionary:dict];
            self.follower = [self objectOrNilForKey:kQCDetailFollower fromDictionary:dict];
            self.count10000 = [self objectOrNilForKey:kQCDetailCount10000 fromDictionary:dict];
            self.count500 = [self objectOrNilForKey:kQCDetailCount500 fromDictionary:dict];
            self.answer = [self objectOrNilForKey:kQCDetailAnswer fromDictionary:dict];
            self.followiratio = [self objectOrNilForKey:kQCDetailFollowiratio fromDictionary:dict];
            self.post = [self objectOrNilForKey:kQCDetailPost fromDictionary:dict];
            self.mostvote = [self objectOrNilForKey:kQCDetailMostvote fromDictionary:dict];
            self.count5000 = [self objectOrNilForKey:kQCDetailCount5000 fromDictionary:dict];
            self.followeri = [self objectOrNilForKey:kQCDetailFolloweri fromDictionary:dict];
            self.mostvote5percent = [self objectOrNilForKey:kQCDetailMostvote5percent fromDictionary:dict];
            self.ask = [self objectOrNilForKey:kQCDetailAsk fromDictionary:dict];
            self.agreeiw = [self objectOrNilForKey:kQCDetailAgreeiw fromDictionary:dict];
            self.agreeiratio = [self objectOrNilForKey:kQCDetailAgreeiratio fromDictionary:dict];
            self.fav = [self objectOrNilForKey:kQCDetailFav fromDictionary:dict];
            self.fratio = [self objectOrNilForKey:kQCDetailFratio fromDictionary:dict];
            self.followeriw = [self objectOrNilForKey:kQCDetailFolloweriw fromDictionary:dict];
            self.mostvote10percent = [self objectOrNilForKey:kQCDetailMostvote10percent fromDictionary:dict];
            self.count1000 = [self objectOrNilForKey:kQCDetailCount1000 fromDictionary:dict];
            self.followiratiow = [self objectOrNilForKey:kQCDetailFollowiratiow fromDictionary:dict];
            self.mostvote5 = [self objectOrNilForKey:kQCDetailMostvote5 fromDictionary:dict];
            self.mostvote10 = [self objectOrNilForKey:kQCDetailMostvote10 fromDictionary:dict];
            self.agree = [self objectOrNilForKey:kQCDetailAgree fromDictionary:dict];
            self.count200 = [self objectOrNilForKey:kQCDetailCount200 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.logs forKey:kQCDetailLogs];
    [mutableDict setValue:self.mostvotepercent forKey:kQCDetailMostvotepercent];
    [mutableDict setValue:self.ratio forKey:kQCDetailRatio];
    [mutableDict setValue:self.agreei forKey:kQCDetailAgreei];
    [mutableDict setValue:self.thanks forKey:kQCDetailThanks];
    [mutableDict setValue:self.count2000 forKey:kQCDetailCount2000];
    [mutableDict setValue:self.agreeiratiow forKey:kQCDetailAgreeiratiow];
    [mutableDict setValue:self.count100 forKey:kQCDetailCount100];
    [mutableDict setValue:self.followee forKey:kQCDetailFollowee];
    [mutableDict setValue:self.tratio forKey:kQCDetailTratio];
    [mutableDict setValue:self.follower forKey:kQCDetailFollower];
    [mutableDict setValue:self.count10000 forKey:kQCDetailCount10000];
    [mutableDict setValue:self.count500 forKey:kQCDetailCount500];
    [mutableDict setValue:self.answer forKey:kQCDetailAnswer];
    [mutableDict setValue:self.followiratio forKey:kQCDetailFollowiratio];
    [mutableDict setValue:self.post forKey:kQCDetailPost];
    [mutableDict setValue:self.mostvote forKey:kQCDetailMostvote];
    [mutableDict setValue:self.count5000 forKey:kQCDetailCount5000];
    [mutableDict setValue:self.followeri forKey:kQCDetailFolloweri];
    [mutableDict setValue:self.mostvote5percent forKey:kQCDetailMostvote5percent];
    [mutableDict setValue:self.ask forKey:kQCDetailAsk];
    [mutableDict setValue:self.agreeiw forKey:kQCDetailAgreeiw];
    [mutableDict setValue:self.agreeiratio forKey:kQCDetailAgreeiratio];
    [mutableDict setValue:self.fav forKey:kQCDetailFav];
    [mutableDict setValue:self.fratio forKey:kQCDetailFratio];
    [mutableDict setValue:self.followeriw forKey:kQCDetailFolloweriw];
    [mutableDict setValue:self.mostvote10percent forKey:kQCDetailMostvote10percent];
    [mutableDict setValue:self.count1000 forKey:kQCDetailCount1000];
    [mutableDict setValue:self.followiratiow forKey:kQCDetailFollowiratiow];
    [mutableDict setValue:self.mostvote5 forKey:kQCDetailMostvote5];
    [mutableDict setValue:self.mostvote10 forKey:kQCDetailMostvote10];
    [mutableDict setValue:self.agree forKey:kQCDetailAgree];
    [mutableDict setValue:self.count200 forKey:kQCDetailCount200];

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

    self.logs = [aDecoder decodeObjectForKey:kQCDetailLogs];
    self.mostvotepercent = [aDecoder decodeObjectForKey:kQCDetailMostvotepercent];
    self.ratio = [aDecoder decodeObjectForKey:kQCDetailRatio];
    self.agreei = [aDecoder decodeObjectForKey:kQCDetailAgreei];
    self.thanks = [aDecoder decodeObjectForKey:kQCDetailThanks];
    self.count2000 = [aDecoder decodeObjectForKey:kQCDetailCount2000];
    self.agreeiratiow = [aDecoder decodeObjectForKey:kQCDetailAgreeiratiow];
    self.count100 = [aDecoder decodeObjectForKey:kQCDetailCount100];
    self.followee = [aDecoder decodeObjectForKey:kQCDetailFollowee];
    self.tratio = [aDecoder decodeObjectForKey:kQCDetailTratio];
    self.follower = [aDecoder decodeObjectForKey:kQCDetailFollower];
    self.count10000 = [aDecoder decodeObjectForKey:kQCDetailCount10000];
    self.count500 = [aDecoder decodeObjectForKey:kQCDetailCount500];
    self.answer = [aDecoder decodeObjectForKey:kQCDetailAnswer];
    self.followiratio = [aDecoder decodeObjectForKey:kQCDetailFollowiratio];
    self.post = [aDecoder decodeObjectForKey:kQCDetailPost];
    self.mostvote = [aDecoder decodeObjectForKey:kQCDetailMostvote];
    self.count5000 = [aDecoder decodeObjectForKey:kQCDetailCount5000];
    self.followeri = [aDecoder decodeObjectForKey:kQCDetailFolloweri];
    self.mostvote5percent = [aDecoder decodeObjectForKey:kQCDetailMostvote5percent];
    self.ask = [aDecoder decodeObjectForKey:kQCDetailAsk];
    self.agreeiw = [aDecoder decodeObjectForKey:kQCDetailAgreeiw];
    self.agreeiratio = [aDecoder decodeObjectForKey:kQCDetailAgreeiratio];
    self.fav = [aDecoder decodeObjectForKey:kQCDetailFav];
    self.fratio = [aDecoder decodeObjectForKey:kQCDetailFratio];
    self.followeriw = [aDecoder decodeObjectForKey:kQCDetailFolloweriw];
    self.mostvote10percent = [aDecoder decodeObjectForKey:kQCDetailMostvote10percent];
    self.count1000 = [aDecoder decodeObjectForKey:kQCDetailCount1000];
    self.followiratiow = [aDecoder decodeObjectForKey:kQCDetailFollowiratiow];
    self.mostvote5 = [aDecoder decodeObjectForKey:kQCDetailMostvote5];
    self.mostvote10 = [aDecoder decodeObjectForKey:kQCDetailMostvote10];
    self.agree = [aDecoder decodeObjectForKey:kQCDetailAgree];
    self.count200 = [aDecoder decodeObjectForKey:kQCDetailCount200];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_logs forKey:kQCDetailLogs];
    [aCoder encodeObject:_mostvotepercent forKey:kQCDetailMostvotepercent];
    [aCoder encodeObject:_ratio forKey:kQCDetailRatio];
    [aCoder encodeObject:_agreei forKey:kQCDetailAgreei];
    [aCoder encodeObject:_thanks forKey:kQCDetailThanks];
    [aCoder encodeObject:_count2000 forKey:kQCDetailCount2000];
    [aCoder encodeObject:_agreeiratiow forKey:kQCDetailAgreeiratiow];
    [aCoder encodeObject:_count100 forKey:kQCDetailCount100];
    [aCoder encodeObject:_followee forKey:kQCDetailFollowee];
    [aCoder encodeObject:_tratio forKey:kQCDetailTratio];
    [aCoder encodeObject:_follower forKey:kQCDetailFollower];
    [aCoder encodeObject:_count10000 forKey:kQCDetailCount10000];
    [aCoder encodeObject:_count500 forKey:kQCDetailCount500];
    [aCoder encodeObject:_answer forKey:kQCDetailAnswer];
    [aCoder encodeObject:_followiratio forKey:kQCDetailFollowiratio];
    [aCoder encodeObject:_post forKey:kQCDetailPost];
    [aCoder encodeObject:_mostvote forKey:kQCDetailMostvote];
    [aCoder encodeObject:_count5000 forKey:kQCDetailCount5000];
    [aCoder encodeObject:_followeri forKey:kQCDetailFolloweri];
    [aCoder encodeObject:_mostvote5percent forKey:kQCDetailMostvote5percent];
    [aCoder encodeObject:_ask forKey:kQCDetailAsk];
    [aCoder encodeObject:_agreeiw forKey:kQCDetailAgreeiw];
    [aCoder encodeObject:_agreeiratio forKey:kQCDetailAgreeiratio];
    [aCoder encodeObject:_fav forKey:kQCDetailFav];
    [aCoder encodeObject:_fratio forKey:kQCDetailFratio];
    [aCoder encodeObject:_followeriw forKey:kQCDetailFolloweriw];
    [aCoder encodeObject:_mostvote10percent forKey:kQCDetailMostvote10percent];
    [aCoder encodeObject:_count1000 forKey:kQCDetailCount1000];
    [aCoder encodeObject:_followiratiow forKey:kQCDetailFollowiratiow];
    [aCoder encodeObject:_mostvote5 forKey:kQCDetailMostvote5];
    [aCoder encodeObject:_mostvote10 forKey:kQCDetailMostvote10];
    [aCoder encodeObject:_agree forKey:kQCDetailAgree];
    [aCoder encodeObject:_count200 forKey:kQCDetailCount200];
}

- (id)copyWithZone:(NSZone *)zone
{
    QCDetail *copy = [[QCDetail alloc] init];
    
    if (copy) {

        copy.logs = [self.logs copyWithZone:zone];
        copy.mostvotepercent = [self.mostvotepercent copyWithZone:zone];
        copy.ratio = [self.ratio copyWithZone:zone];
        copy.agreei = [self.agreei copyWithZone:zone];
        copy.thanks = [self.thanks copyWithZone:zone];
        copy.count2000 = [self.count2000 copyWithZone:zone];
        copy.agreeiratiow = [self.agreeiratiow copyWithZone:zone];
        copy.count100 = [self.count100 copyWithZone:zone];
        copy.followee = [self.followee copyWithZone:zone];
        copy.tratio = [self.tratio copyWithZone:zone];
        copy.follower = [self.follower copyWithZone:zone];
        copy.count10000 = [self.count10000 copyWithZone:zone];
        copy.count500 = [self.count500 copyWithZone:zone];
        copy.answer = [self.answer copyWithZone:zone];
        copy.followiratio = [self.followiratio copyWithZone:zone];
        copy.post = [self.post copyWithZone:zone];
        copy.mostvote = [self.mostvote copyWithZone:zone];
        copy.count5000 = [self.count5000 copyWithZone:zone];
        copy.followeri = [self.followeri copyWithZone:zone];
        copy.mostvote5percent = [self.mostvote5percent copyWithZone:zone];
        copy.ask = [self.ask copyWithZone:zone];
        copy.agreeiw = [self.agreeiw copyWithZone:zone];
        copy.agreeiratio = [self.agreeiratio copyWithZone:zone];
        copy.fav = [self.fav copyWithZone:zone];
        copy.fratio = [self.fratio copyWithZone:zone];
        copy.followeriw = [self.followeriw copyWithZone:zone];
        copy.mostvote10percent = [self.mostvote10percent copyWithZone:zone];
        copy.count1000 = [self.count1000 copyWithZone:zone];
        copy.followiratiow = [self.followiratiow copyWithZone:zone];
        copy.mostvote5 = [self.mostvote5 copyWithZone:zone];
        copy.mostvote10 = [self.mostvote10 copyWithZone:zone];
        copy.agree = [self.agree copyWithZone:zone];
        copy.count200 = [self.count200 copyWithZone:zone];
    }
    
    return copy;
}


@end
