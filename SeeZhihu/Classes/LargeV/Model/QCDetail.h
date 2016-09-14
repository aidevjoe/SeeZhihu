//
//  QCDetail.h
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QCDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *logs; /**< 公共编辑数 */
@property (nonatomic, strong) NSString *mostvotepercent; /**< 最高赞同占比 */
@property (nonatomic, strong) NSString *ratio; /**< 平均赞同（总赞同数/(回答+专栏)） */
@property (nonatomic, strong) NSString *thanks; /**< 感谢数 */
@property (nonatomic, strong) NSString *count10000; /**< 赞同≥10000答案数 */
@property (nonatomic, strong) NSString *count5000; /**< 赞同≥5000答案数 */
@property (nonatomic, strong) NSString *count2000; /**< 赞同≥2000答案数 */
@property (nonatomic, strong) NSString *count1000; /**< 赞同≥1000答案数 */
@property (nonatomic, strong) NSString *count500; /**< 赞同≥500答案数 */
@property (nonatomic, strong) NSString *count100; /**< 赞同≥100答案数 */
@property (nonatomic, strong) NSString *count200; /**< 赞同≥200答案数 */
@property (nonatomic, strong) NSString *agreeiratiow; /**< 7日赞同数增幅 */
@property (nonatomic, strong) NSString *follower; /**< 被关注数（粉丝） */
@property (nonatomic, strong) NSString *followee; /**< 关注数 */
@property (nonatomic, strong) NSString *followeri; /**< 1日被关注数增加 */
@property (nonatomic, strong) NSString *followeriw; /**< 7日被关注数增加 */
@property (nonatomic, strong) NSString *followiratio; /**< 1日被关注数增幅 */
@property (nonatomic, strong) NSString *followiratiow; /**< 7日被关注数增幅 */
@property (nonatomic, strong) NSString *tratio; /**< 感谢/赞同比 */
@property (nonatomic, strong) NSString *answer; /**< 回答数 */
@property (nonatomic, strong) NSString *post; /**< 专栏文章数 */
@property (nonatomic, strong) NSString *mostvote; /**< 最高赞同 */
@property (nonatomic, strong) NSString *mostvote5percent; /**< 前5赞同占比 */
@property (nonatomic, strong) NSString *ask; /**< 提问数 */
@property (nonatomic, strong) NSString *agree; /**< 赞同数 */
@property (nonatomic, strong) NSString *agreei; /**< 1日赞同数增加 */
@property (nonatomic, strong) NSString *agreeiw; /**< 7日赞同数增加 */
@property (nonatomic, strong) NSString *agreeiratio; /**< 1日赞同数增幅 */
@property (nonatomic, strong) NSString *mostvote5; /**< 前5赞同 */
@property (nonatomic, strong) NSString *mostvote10; /**< 前10赞同 */
@property (nonatomic, strong) NSString *mostvote10percent; /**< 前10赞同占比 */
@property (nonatomic, strong) NSString *fav; /**< 收藏数 */
@property (nonatomic, strong) NSString *fratio; /**< 收藏/赞同比 */

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
