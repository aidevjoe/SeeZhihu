//
//  QCStar.h
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QCStar : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *agreerank; /**< 赞同数排名 */
@property (nonatomic, strong) NSString *answerrank; /**< 回答数+专栏文章数排名 */
@property (nonatomic, strong) NSString *count100rank; /**< 赞同超100的回答数排名 */
@property (nonatomic, strong) NSString *favrank; /**< 收藏数排名 */
@property (nonatomic, strong) NSString *followerrank; /**< 被关注数排名 */
@property (nonatomic, strong) NSString *ratiorank; /**< 平均赞同排名 */
@property (nonatomic, strong) NSString *count1000rank; /**< 赞同超1000的回答数排名 */

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
