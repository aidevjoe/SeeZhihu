//
//  QCRank.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCRank.h"

@implementation QCRank

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id",
             @"hashValue": @"hash"
             };
}

- (NSString *)rankTyleStr{
    return self.follower ? @"粉丝数" : @"赞同数";
}

@end


