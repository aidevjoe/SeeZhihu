//
//  QCTopanswers.m
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "QCTopanswers.h"


NSString *const kQCTopanswersLink = @"link";
NSString *const kQCTopanswersAgree = @"agree";
NSString *const kQCTopanswersTitle = @"title";
NSString *const kQCTopanswersIspost = @"ispost";
NSString *const kQCTopanswersDate = @"date";


@interface QCTopanswers ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QCTopanswers

@synthesize link = _link;
@synthesize agree = _agree;
@synthesize title = _title;
@synthesize ispost = _ispost;
@synthesize date = _date;


- (NSString *)link{
     /**< 是否专栏文章，用于判断链接域名是zhihu.com还是zhuanlan.zhihu.com */
    if (self.ispost.boolValue) {
        return [@"https://www.zhuanlan.zhihu.com" stringByAppendingPathComponent:_link];
    }else{
        return [@"https://www.zhihu.com" stringByAppendingPathComponent:_link];
    }
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
            self.link = [self objectOrNilForKey:kQCTopanswersLink fromDictionary:dict];
            self.agree = [self objectOrNilForKey:kQCTopanswersAgree fromDictionary:dict];
            self.title = [self objectOrNilForKey:kQCTopanswersTitle fromDictionary:dict];
            self.ispost = [self objectOrNilForKey:kQCTopanswersIspost fromDictionary:dict];
            self.date = [self objectOrNilForKey:kQCTopanswersDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.link forKey:kQCTopanswersLink];
    [mutableDict setValue:self.agree forKey:kQCTopanswersAgree];
    [mutableDict setValue:self.title forKey:kQCTopanswersTitle];
    [mutableDict setValue:self.ispost forKey:kQCTopanswersIspost];
    [mutableDict setValue:self.date forKey:kQCTopanswersDate];

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

    self.link = [aDecoder decodeObjectForKey:kQCTopanswersLink];
    self.agree = [aDecoder decodeObjectForKey:kQCTopanswersAgree];
    self.title = [aDecoder decodeObjectForKey:kQCTopanswersTitle];
    self.ispost = [aDecoder decodeObjectForKey:kQCTopanswersIspost];
    self.date = [aDecoder decodeObjectForKey:kQCTopanswersDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_link forKey:kQCTopanswersLink];
    [aCoder encodeObject:_agree forKey:kQCTopanswersAgree];
    [aCoder encodeObject:_title forKey:kQCTopanswersTitle];
    [aCoder encodeObject:_ispost forKey:kQCTopanswersIspost];
    [aCoder encodeObject:_date forKey:kQCTopanswersDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    QCTopanswers *copy = [[QCTopanswers alloc] init];
    
    if (copy) {

        copy.link = [self.link copyWithZone:zone];
        copy.agree = [self.agree copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.ispost = [self.ispost copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
