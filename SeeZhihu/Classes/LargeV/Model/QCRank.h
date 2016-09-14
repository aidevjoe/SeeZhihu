//
//  QCRank.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCRank : NSObject

@property (nonatomic, copy) NSString *avatar; /**< 用户头像url */

@property (nonatomic, copy) NSString *ID; /**< 用户ID */

@property (nonatomic, copy) NSString *hashValue; /**< 用户hash */

@property (nonatomic, copy) NSString *signature; /**< 用户签名 */

@property (nonatomic, copy) NSString *name; /**< 用户名称 */

@property (nonatomic, assign) NSInteger agree; /**< 点赞数 */

@property (nonatomic, assign) NSInteger follower; /**< 关注数 */

@property (nonatomic, copy, readonly) NSString *rankTyleStr; /**< 排行类型 */

@property (nonatomic, assign) NSInteger answer; /**< 回答+专栏数量 */

@end

