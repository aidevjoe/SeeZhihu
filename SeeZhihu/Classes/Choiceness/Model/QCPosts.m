//
//  QCPosts.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/25.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCPosts.h"

@implementation QCPosts

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id",
             };
}

- (NSString *)postName{
    NSString *typeStr;
    if ([self.name isEqualToString:@"recent"]) {
        typeStr = @"近日热门";
    }else if ([self.name isEqualToString:@"yesterday"]){
        typeStr = @"昨日最新";
    }else{
        typeStr = @"历史精华";
    }
    return typeStr;
}

@end


