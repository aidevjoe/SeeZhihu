//
//  QCTrend.h
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QCTrend : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *agree; /**< 赞同数 */
@property (nonatomic, strong) NSString *follower; /**< 被关注数 */
@property (nonatomic, strong) NSString *answer; /**< 回答数+专栏文章数 */
@property (nonatomic, strong) NSString *date; /**< 日期，格式为2014-09-25 */

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
