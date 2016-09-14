//
//  QCTopanswers.h
//
//  Created by   on 16/7/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QCTopanswers : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *link; /**< 链接地址（不含域名） */
@property (nonatomic, strong) NSString *agree; /**< 赞同数 */
@property (nonatomic, strong) NSString *title; /**< 标题 */
@property (nonatomic, strong) NSString *ispost; /**< 是否专栏文章，用于判断链接域名是zhihu.com还是zhuanlan.zhihu.com */
@property (nonatomic, strong) NSString *date; /**< 日期，格式为2014-09-25 */

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
