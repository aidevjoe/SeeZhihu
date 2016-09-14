
//
//  QCPosts.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/25.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCPosts : NSObject

@property (nonatomic, copy) NSString *excerpt; /**< 摘要文字 */

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *pic; /**< 抬头图url */

@property (nonatomic, copy) NSString *count; /**< 文章包含答案数量 */

@property (nonatomic, copy) NSString *date; /**< 发表日期（yyyy-mm-dd） */

@property (nonatomic, assign) NSInteger publishtime; /**< 发表时间戳 */

@property (nonatomic, copy) NSString *name; /**< 文章名称（yesterday, recent, archive） */

@property (nonatomic, copy, readonly) NSString *postName; /**< 文章名字 中文 */

@end

