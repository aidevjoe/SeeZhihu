//
//  QCNSObject.h
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QCStar, QCDetail;

@interface QCUserInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) QCStar *star; /**< 七星阵排名 */
@property (nonatomic, strong) QCDetail *detail; /**< 用户详细数据 */
@property (nonatomic, strong) NSArray *trend; /**< 近日动态 */
@property (nonatomic, strong) NSArray *topanswers; /**< 高票答案 */
@property (nonatomic, strong) NSString *avatar; /**< 用户头像url */
@property (nonatomic, strong) NSString *signature; /**< 用户签名 */
@property (nonatomic, strong) NSString *internalBaseClassDescription; /**< 用户个人描述 */
@property (nonatomic, strong) NSString *error; /**< 如用户hash不存在，则error==”no result”
                                                如用户存在，但当日没有他的数据（可能是数据抓取出错），则error==”no snapshot” */
@property (nonatomic, strong) NSString *name; /**< 用户名 */

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
